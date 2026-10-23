-- ex21_view.sql

/*

    View, 뷰
    - DB Object > 객체 > 오라클에 저장
    - create/drop
    - 가상 테이블, 뷰 테이블 등
    - 테이블과 유사한 행동을 한다.
    - select 결과를 저장한 테이블(***)(X)
    - SQL(select문)을 저장한 객체(O)
    
    구문
    create [or replace] view 뷰이름
    as --연결부(as, is)
    select 문;
    
    
    뷰 사용 목적
    1. 자주 쓰는 쿼리를 저장
    2. 복잡하고 긴 쿼리를 저장
    3. 저장 객체 > 같은 데이터베이스 사용자끼리 뷰 공유 가능 > 재사용 or 협업
    4. 권한 통제 > 보안
        
*/

--public void test() {
--    System.out.println("test");
--}


create or replace view vwInsa
as
select name, jikwi, city from tblInsa
    where buseo = '기획부';


--원본 > 김신제	   과장	    서울
select name, jikwi, city from tblInsa where buseo = '기획부';

--복사본 > 김신제	과장	서울
select * from vwInsa;

-- 김신제	대리	인천
update tblInsa set jikwi = '과장', city = '서울' where name = '김신제';


-- from절 서브쿼리 == 인라인뷰
select * from (select name, jikwi, city from tblInsa
    where buseo = '기획부'); --1회 호출

select * from vwInsa; --N회 호출






--신입 > 직원 연락처 > 문자 메시지 발송

select * from tblInsa; --신입 접근 제한

create or replace view vwTel
as
select num, name, buseo, jikwi, tel from tblInsa;

select * from vwTel; --신입 접근 허용





--비디오 대여점 사장님 > 날마다 업무
--회원, 비디오, 대여, 반납유무, 반납예정일, 연체일, 연체료
create or replace view vwCheck
as
select
    m.name as 회원명,
    v.name as 비디오,
    r.rentdate as 대여일,
    r.retdate as 반납일,
    g.period as 대여기간,
    r.rentdate + g.period as 반납예정일,
    case
        when r.retdate is null then round(sysdate - r.rentdate - g.period)
        when r.retdate is not null then round(r.retdate - r.rentdate - g.period)
    end as 연체일,
    --연체일 * g.price * 0.1
    g.price as 대여료,
    case
        when r.retdate is null then round(sysdate - r.rentdate - g.period)
        when r.retdate is not null then round(r.retdate - r.rentdate - g.period)
    end * g.price * 0.1 as 연체료
from tblMember m
    inner join tblRent r
        on m.seq = r.member
            inner join tblVideo v
                on v.seq = r.video
                    inner join tblGenre g
                        on g.seq = v.genre;




select * from vwCheck;
insert into vwCheck .. ?



-- 컬럼들은 서로 독립적이다.
select
    age as 나이, --우리나라 나이
    나이 - 1
from 회원 a;




-- 뷰 사용 시 주의점!!
-- - 테이블 역할
-- 1. select > 실행O > "뷰는 읽기 전용 테이블이다.!!"
-- 2. insert > 실행O > 절대 사용 금지!!
-- 3. update > 실행O > 절대 사용 금지!!
-- 4. delete > 실행O > 절대 사용 금지!! 

create or replace view vwTodo
as
select * from tblTodo;

select * from vwTodo;
insert into vwTodo values (21, '뷰 만들기', sysdate, null);
update vwTodo set completedate = sysdate where seq = 21;
delete from vwTodo where seq = 21;

-- 뷰
-- 1. 단순뷰(1개 테이블) > CRUD 가능
-- 2. 복합뷰(2개 테이블 이상) > CRUD 불가능

create or replace view vwCouple
as
select * from tblMen m
    inner join tblWomen w
        on m.name = w.couple;

select * from vwCouple;
insert into vwCouple values (?, ?, ?, ?, ?..);


















