-- ex20_join.sql

/*

    관계형 데이터베이스 시스템이 지양하는 것들!! > 테이블을 잘못 만들면 발생!!
    
    1. 테이블에 기본키(PK)가 없는 상태 > 데이터 조작 불가능(레코드 식별 불가능)
    
    2. null이 많은 상태의 테이블 > 공간 낭비 + SQL 작업 불편
    
    3. 하나의 속성(컬럼)값이 원자값이 아닌 상태 > 더 이상 쪼개지지 않는 값을 넣어야 한다.
    
    4. 데이터가 중복되는 상태 > 데이터 관리 불편(일관성 저하)    

*/

--2. 
--회원 테이블

create table tblUser (
    id varchar2(30) primary key,
    name varchar2(30) not null,
    hobby varchar2(100)
);

insert into tblUser (id, name, hobby) values ('hong', '홍길동', '독서');
insert into tblUser (id, name, hobby) values ('dog', '강아지', null);
insert into tblUser (id, name, hobby) values ('cat', '고양이', '런닝');
insert into tblUser (id, name, hobby) values ('test', '테스트', '코딩,여행,런닝,독서');
insert into tblUser (id, name, hobby) values ('hello', '아무개', '그림책독서');

-- 독서가 취미??
select * from tblUser where hobby = '독서';
select * from tblUser where hobby like '%독서%';
select * from tblUser where instr(hobby, '독서') > 0;

-- 독서(X) > 책읽기(O)
update tblUser set hobby = '책읽기' where hobby = '독서';
update tblUser set hobby = '책읽기' where hobby like '%독서%';


drop table tblUser;

create table tblUser (
    id varchar2(30) primary key,
    name varchar2(30) not null,
    hobby1 varchar2(100),
    hobby2 varchar2(100),
    hobby3 varchar2(100)
);

insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('dog', '강아지', null, null, null);
insert into tblUser values ('cat', '고양이', '러닝', '여행', '독서');

select * from tblUser where hobby1 = '독서' or hobby2 = '독서' or hobby3 = '독서';


insert into tblUser values ('cat', '고양이', '러닝', '여행', '독서');
insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('hong', '홍길동', '독서', null, null);
insert into tblUser values ('hong', '홍길동', '독서', null, null);






-- 쇼핑몰 > 판매 테이블
create table tblShop (
    seq number primary key,                 --판매번호(PK)
    id varchar2(30) not null,               --고객아이디
    name varchar2(30) not null,             --고객명
    tel varchar2(15) not null,              --연락처
    item varchar2(50) not null,             --상품명
    qty number not null,                    --수량
    regdate date default sysdate not null   --판매시각
);

insert into tblShop
    values (1, 'hong', '홍길동', '010-1234-5678', '마우스', 1, default);

insert into tblShop
    values (2, 'test', '테스트', '010-8567-9867', '키보드', 1, default);

insert into tblShop
    values (3, 'hong', '홍길동', '010-1234-2342', '태블릿', 1, default);

select * from tblShop where name = '홍길동';





-- tblShop > 개선
create table tblShop (
    seq number primary key,                 --판매번호(PK)
    item varchar2(50) not null,             --상품명
    qty number not null,                    --수량
    regdate date default sysdate not null,  --판매시각
    id varchar2(30) not null                --구매 고객 아이디
);

create table tblUser (
    id varchar2(30) primary key,            --고객아이디(PK)
    name varchar2(30) not null,             --고객명
    tel varchar2(15) not null               --연락처
);

insert into tblUser values ('hong', '홍길동', '010-1111-2222');
insert into tblUser values ('dog', '강아지', '010-3333-4444');
insert into tblUser values ('cat', '고양이', '010-5555-6666');

insert into tblShop values (1, '마우스', 1, default, 'hong');
insert into tblShop values (2, '키보드', 1, default, 'cat');
insert into tblShop values (3, '태블릿', 1, default, 'hong');
insert into tblShop values (4, '모니터', 1, default, 'dog');
insert into tblShop values (5, '노트북', 1, default, 'hong');




-- 직원 정보
-- 직원(번호(PK), 직원명, 급여, 거주지, 담당프로젝트)
create table tblStaff (
    seq number primary key,         --직원번호(PK)
    name varchar2(30) not null,     --직원명
    salary number not null,         --급여
    address varchar2(300) not null, --거주지
    project varchar2(300)           --담당프로젝트
);

insert into tblStaff values (1, '홍길동', 300, '서울시', '홍콩 수출');
insert into tblStaff values (2, '아무개', 250, '인천시', 'TV 광고');
insert into tblStaff values (3, '하하하', 350, '의정부시', '매출 분석');

--'홍길동'에게 담당 프로젝트를 1개 추가 > '고객 관리'
insert into tblStaff values (4, '홍길동', 300, '서울시', '고객 관리');

select * from tblStaff;

drop table tblStaff;
drop table tblProject;

--관계를 맺은 테이블
--1. 생성 순서
--부모테이블 > 자식테이블
--2. 삭제 순서
--자식테이블 > 부모테이블


-- 직원 정보
-- 직원(번호(PK), 직원명, 급여, 거주지)
create table tblStaff ( --부모 테이블
    seq number primary key,         --직원번호(PK)
    name varchar2(30) not null,     --직원명
    salary number not null,         --급여
    address varchar2(300) not null  --거주지
);

--프로젝트(프로젝트명)
create table tblProject ( --자식 테이블
    seq number primary key,         --프로젝트번호(PK)
    project varchar2(300) not null, --프로젝트명
    staff_seq number not null references tblStaff(seq) --tblStaff의 seq > 담당 직원 번호
);

delete from tblStaff;
delete from tblProject;

insert into tblStaff values (1, '홍길동', 300, '서울시');
insert into tblStaff values (2, '아무개', 250, '인천시');
insert into tblStaff values (3, '하하하', 350, '의정부시');

insert into tblProject values (1, '홍콩 수출', 1);
insert into tblProject values (2, 'TV 광고', 2);
insert into tblProject values (3, '매출 분석', 3);
insert into tblProject values (4, '고객 관리', 1);
insert into tblProject values (5, '대리점 분양', 2);

-- 'TV 광고' 담당자?
-- 2	TV 광고	2
select * from tblProject where project = 'TV 광고';
select * from tblStaff where seq = 2;

select * from tblStaff 
    where seq = (select statff_seq from tblProject where project = 'TV 광고');


-- A. 신입 사원 입사 > 신규 프로젝트 배정
-- A.1 신입 사원 추가(O)
insert into tblStaff values (4, '호호호', 220, '성남시');

-- A.2 신규 프로젝트 배정(O)
insert into tblProject values (6, '자재 매입', 4);

select * from tblStaff 
    where seq = (select staff_seq from tblProject where project = '자재 매입');

-- A.3 신규 프로젝트 추가(O)
-- ORA-02291: 무결성 제약조건(HR.SYS_C008446)이 위배되었습니다- 부모 키가 없습니다
insert into tblProject values (7, '고객 유치', 5);

select * from tblStaff 
    where seq = (select statff_seq from tblProject where project = '고객 유치');



-- B. '홍길동' 퇴사
-- B.1 '홍길동' 삭제(O)
-- ORA-02292: 무결성 제약조건(HR.SYS_C008446)이 위배되었습니다- 자식 레코드가 발견되었습니다
delete from tblStaff where name = '홍길동'; --조심(***) 동명이인?
delete from tblStaff where seq = 1; --PK

-- B.2 '홍길동' 삭제 전 > 업무 인수 인계(위임)
select * from tblProject;

update tblProject set staff_seq = 3 where staff_seq = 1;

-- B.3 '홍길동' 삭제
delete from tblStaff where seq = 1; --PK


select * from tblStaff 
    where seq = (select statff_seq from tblProject where project = '홍콩 수출');



/*

    조인, Join
    - (서로 관계를 맺고 있는) 2개(1개) 이상의 테이블을 대상 > select > 1개의 결과셋
    
    조인의 종류(ANSI-SQL)
    1. 크로스 조인, cross join
    2. 내부 조인, inner join
    3. 외부 조인, outer join
    4. 셀프 조인, self join
    5. 전체 외부 조인, full outer join
    
    
    
    1. 크로스 조인, cross join
    - 카티션 곱, 데카르트 곱
    - A 테이블 X B 테이블 = 1개의 결과 테이블
    - 쓸모없다 > 가치있는 행과 가치없는 행이 뒤섞여 있다.
    - 유효성 상관없이 > 대량의 데이터가 필요할 때
    - 일부 특정 업무에 사용
    
*/
select * from tblCustomer; --고객 3명
select * from tblSales;    --판매 9건

select * from tblCustomer cross join tblSales;  --ANSI-SQL
select * from tblCustomer, tblSales; --Oracle




/*
    
    고객 테이블(tblCustomer)
    - 1, 홍길동, 20, 010..
    - 10, 테스트
    
    판매 테이블(tblSales)
    - 1, 마우스, 5, 2026.., 1(FK)
    
    
    Join
    1. 크로스 조인
    
    2. 내부 조인
        
*/
select * from tblCustomer cross join tblSales;

select * from tblCustomer inner join tblSales on tblCustomer.seq = tblSales.cseq;


-- ORA-00918: 열의 정의가 애매합니다. column ambiguously specified ..
-- > 같은 컬럼명이 2개 이상 존재
select                                   --3.
    c.seq as 고객번호,
    c.name as 고객명,
    s.item as 물품명,
    s.qty as 수량
from tblCustomer c inner join tblSales s --1. 별칭 > 개명
    on c.seq = s.cseq;   --2.


select * from tblCustomer; --seq, name, tel, address
select * from tblSales; --seq, item, qty, regdate, cseq


--고객 테이블 + 판매 테이블
--: 어떤 고객이(c.name)이 어떤 물건(s.item)을 몇 개(s.qty)를 사갔습니까?

--1. 조인
select
    c.name,
    s.item,
    s.qty
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;

--2. 서브쿼리
-- tblCustomer, tblSales
-- 누가 메인쿼리?(자식) 서브쿼리?(부모)
select
    item,
    qty,
    --cseq,
    (select name from tblCustomer where seq = tblSales.cseq)
from tblSales;




select * from tblGenre;
select * from tblVideo;
select * from tblMember;
select * from tblRent;


-- 비디오(C) + 장르(P)
select * from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre;

-- 비디오 + 장르 + 대여
-- 비디오(C) + 장르(P)
-- 비디오(P) + 대여(C)
select * from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video;


-- 비디오 + 장르 + 대여 + 회원
create or replace view 대여기록
as
select * from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video
                    inner join tblMember m
                        on m.seq = r.member;


select * from 대여기록;

/*
    
    3. 외부 조인, outer join
    - 내부 조인의 반댓말(X)
    - 내부 조인 결과 + a
    
    구문
    select
        컬럼리스트
    from 테이블A
        (left|right) outer join 테이블B
            on 테이블A.PK = 테이블B.FK;
    
*/

select * from tblCustomer;--3명 > 2명
select * from tblSales;   --9건

insert into tblCustomer values (4, '강아지', '010-1234-5678', '서울시');
insert into tblCustomer values (5, '고양이', '010-1234-5678', '서울시');

commit;

-- 크로스 조인 > 두 테이블 결합 

-- 내부 조인(9개) > 두 테이블 결합 + 양쪽 레코드간의 유의미한 연관이 있는 레코드만 추출
--: 물건을 한번이라도 구매한 이력이 있는 고객의 정보와 구매 내역을 가져오시오.(***)
select * from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;

-- 외부 조인(11개)
--: 물건의 구매 유무와 상관없이 모든 고객을 가져와라 + 단, 구매 이력이 있으면 그것도 같이
-- 내부 조인 + a(가리킨 테이블에서 내부 조인에 들어가지 못한 나머지 레코드를 다 가져와라)
select * from tblCustomer 
    c left outer join tblSales s
        on c.seq = s.cseq;


select * from tblCustomer 
    c right outer join tblSales s
        on c.seq = s.cseq;


select * from tblMen;
select * from tblWomen;


select * from tblStaff;   --4명(3명 + 1명)
select * from tblProject; --5건

-- 프로젝트를 1개 이상 담당하고 있는 직원 정보 + 담당 프로젝트 정보
-- > 내부조인
select * from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq;

-- 담당 프로젝트의 유무와 상관없이 모든 직원 + 담당 프로젝트 정보
select * from tblStaff s
    left outer join tblProject p
        on s.seq = p.staff_seq;








/*
    내부 조인 + 셀프 조인
    외부 조인 + 셀프 조인
        
    4. 셀프 조인, self join
    - 1개의 테이블을 사용하는 조인
    - 테이블이 자기 스스로와 관계를 맺고 경우에만 사용
    
*/

--hr.employees

--직원 테이블
create table tblSelf (
    seq number primary key,                     --직원번호(PK)
    name varchar2(30) not null,                 --직원명
    department varchar2(50) not null,           --부서명
    boss number null references tblSelf(seq)    --상사번호(FK)
);

insert into tblSelf values (1,  '홍사장', '사장실', null);
insert into tblSelf values (2,  '김부장', '영업부', 1);
insert into tblSelf values (3,  '박과장', '영업부', 2);
insert into tblSelf values (4,  '최대리', '영업부', 3);
insert into tblSelf values (5,  '정사원', '영업부', 4);
insert into tblSelf values (6,  '이부장', '개발부', 1);
insert into tblSelf values (7,  '하과장', '개발부', 6);
insert into tblSelf values (8,  '신과장', '개발부', 6);
insert into tblSelf values (9,  '황대리', '개발부', 7);
insert into tblSelf values (10, '허사원', '개발부', 9);

-- 직원 명단을 가져오시오. (단, 상사의 이름도)
-- 1. 조인
-- 2. 서브쿼리
-- 3. 계층형 쿼리

select
    s2.name as 직원명,
    s2.department as 부서명,
    s1.name as 상사명
from tblSelf s1 --상사테이블
    inner join tblSelf s2 --직원테이블
        on s1.seq = s2.boss;


select
    s2.name as 직원명,
    s2.department as 부서명,
    s1.name as 상사명
from tblSelf s1 --상사테이블
    right outer join tblSelf s2 --직원테이블
        on s1.seq = s2.boss;

select
    name as 직원명,
    department as 부서명,
    --boss,
    (select name from tblSelf where seq = a.boss) as 상사명
from tblSelf a; --직원(자식) 테이블




/*

    5. 전체 외부 조인, full outer join
    - 서로 참조하고 있는 관계에서 사용
    - 테이블A(자식) > (참조) > 테이블B(부모)
    - 테이블B(자식) > (참조) > 테이블A(부모)
    
*/
select * from tblMen;
select * from tblWomen;

-- 커플인 남/녀를 가져오시오
select
    m.name as 남자,
    w.name as 여자
from tblMen m
    inner join tblWomen w
        on m.name = w.couple;

-- 커플 + 남자 솔로들
select
    m.name as 남자,
    w.name as 여자
from tblMen m
    left outer join tblWomen w
        on m.name = w.couple;

--커플 + 여자 솔로들..
select
    m.name as 남자,
    w.name as 여자
from tblMen m
    right outer join tblWomen w
        on m.name = w.couple;

--커플 + 남자 솔로들 + 여자 솔로들
--full outer join
select
    m.name as 남자,
    w.name as 여자
from tblMen m
    full outer join tblWomen w
        on m.name = w.couple;





