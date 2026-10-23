-- ex32_transaction.sql

/*

    트랜잭션, Transaction
    - 하나의 논리적인 업무 단위
    - 보통 1개 이상의 DML(INSERT, UPDATE, DELETE, MERGE)을 하나로 묶은 단위 > 최종 처리
    - 모든 작업이 성공하면 COMMIT, 하나라도 실패하면 ROLLBACK하는 것이 기본 원칙이다.
    
    
    TCL(DCL)
    1. COMMIT
    2. ROLLBACK
    3. SAVEPOINT
    
    
    ACID
    - 트랜잭션을 정의하는 4가지 중대한 속성을 가리키는 약어
    - Atomicity(원자성): 전부 성공하거나, 전부 실패한다.
    - Consistency(일관성): 완료 후에도 데이터 규칙을 만족한다.
    - Isolation(격리성): 동시에 실행되는 트랜잭션이 서로 부당하게 간섭하지 않는다.
    - Durability(지속성): COMMIT된 결과는 장애가 나도 보존되어야 한다.
    
*/

--은행 업무 각 행동 > DML(insert, update, delete)

--CTAS(Create Table As Select), DDL의 종류 중 하나
create table tblTrans
as
select name, buseo, jikwi from tblInsa where city = '서울';


select * from tblTrans;


-- A.
-- 우리가 하는 행동(insert, update, delete) > 오라클이 시간순으로 기억한다.

select * from tblTrans;

delete from tblTrans where name = '김말자';

select * from tblTrans;

--김말자 되살리기
rollback;

select * from tblTrans;


delete from tblTrans where name = '김말자';

select * from tblTrans;

commit;

select * from tblTrans;


commit;

select * from tblTrans; --20명

insert into tblTrans values ('강아지', '개발부', '사원');

update tblTrans set jikwi = '이사' where name = '홍길동';

delete from tblTrans where name = '한석봉';

select * from tblTrans;

rollback;

select * from tblTrans;


/*

    트랜잭션이 언제 시작해서 ~ 언제 끝나는지? (************)
    
    새로운 트랜잭션이 시작하는 경우
    1. 클라이언트가 접속했을 때
    2. commit 실행
    3. rollback 실행
    4. DDL 실행(create, alter, drop) + commit 동반        
    
    현재 트랜잭션이 끝나는 경우
    1. 클라이언트가 접속을 종료했을 때
        a. 정상 종료
            1. 현재 트랜잭션이 마무리가 된 상태 > 그냥 닫힘 
            2. 현재 트랜잭션이 마무리가 안된 상태 > 질문?
        b. 비정상 종료
            - rollback
    2. commit 실행
    3. rollback 실행       
    4. DDL 실행(create, alter, drop) + commit 동반 
        - create, alter, drop > 프로젝트 초반
        - DML(insert, update, delete) > DDL 작업 후에 진행

*/
commit;

insert into tblTrans values ('강아지', '개발부', '사원');

select * from tblTrans;

insert into tblTrans values ('고양이', '개발부', '사원');

select * from tblTrans;

insert into tblTrans values ('병아리', '개발부', '사원');

select * from tblTrans;

commit;

insert into tblTrans values ('거북이', '개발부', '사원');

select * from tblTrans;

commit; --이전 트랜잭션이 어디서 시작했는지 기억이 안나서?

insert into tblTrans values ('호랑이', '개발부', '사원'); --rollback(X) > commit(O)

select * from tblTrans;

--commit 포함
create sequence seqTrans; --중간에 DDL > 내부적으로 자동 Commit 실행

insert into tblTrans values ('사자', '개발부', '사원'); --rollback(O)

select * from tblTrans;

rollback;

select * from tblTrans;


------------------

select * from tblTrans;

insert into tblTrans values ('돌고래', '개발부', '사원');

savepoint a;

update tblTrans set jikwi = '사장' where name = '홍길동';

savepoint b;

delete from tblTrans where name = '한석봉';

select * from tblTrans;

rollback to b;

select * from tblTrans;

rollback to a;

select * from tblTrans;

rollback;

select * from tblTrans;

-------------------------------

commit;


select * from tblTrans; --23개

insert into tblTrans values ('물방개', '개발부', '사원');

select * from tblTrans; --24개

commit;

delete from tblTrans where name = '물방개';

commit;


-- 클라이언트 프로그램 > Auto Commit 설정 확인(***)


/*
    
    select for update
    - 조회하면서 행 잠그기
    
    1. 일반 select
    - 데이터를 읽기만 한다.
    - 조회한 행을 다른 세션이 update하는 것을 막지 않는다.
    
    2. select for update
    - 조회한 행을 다른 세션이 update하는 것을 막는다. 잠근다.
    - 다른 세션은 잠긴 행이 풀릴 때까지 대기한다.
    - 잠근 상태는 select for update 실행 후 commit/rollback할 때 풀린다.
    
    
*/
rollback;

--홍길동 기획부	부장
select * from tblTrans
    where name = '홍길동';

update tblTrans set
    jikwi = '이사'
        where name = '홍길동';


rollback;


select * from tblTrans
    where name = '홍길동'
        for update;

update tblTrans set
    jikwi = '이사'
        where name = '홍길동';

commit;


rollback;

select * from tblTrans
    where name = '홍길동'
        for update nowait;
        







/*

    교착 상태(Deadlock)
    - 서로(다른 세션)간의 상대방의 잠금을 기다리는 상황
    
*/
commit;

--홍길동, 한석봉
select * from tblTrans;

-- A팀원(세션) > 홍길동(레코드) 잠금
update tblTrans set
    jikwi = '이사'
        where name = '홍길동';
        

update tblTrans set
    jikwi = '대리'
        where name = '한석봉';

rollback;

--후속 처리



-- 락이 안걸리는 방법
-- : 팀원간의 의사 교환 자주~








        









