-- ex22_union.sql

/*
    
    관계 대수
    - 테이블을 피연산자로 하는 연산
    1. 테이블 x 테이블 = join
    2. 테이블 + 테이블 = union(합집합)
    3. 테이블 - 테이블 = minus(차집합)
    
    테이블
    - 합집합
    - 차집합
    - 교집합
    
*/
select * from tblMen 
union 
select * from tblWomen;


select name, ibsadate from tblInsa
union
select title, adddate from tblTodo;



--쇼핑몰 > 구매 이력 테이블
--전체 기간(X) > 일부 기간(O)
select * from 구매2026; --40만
select * from 구매2025; --90만 
select * from 구매2024; --1백만

select * from 구매2026
union
select * from 구매2025
union
select * from 구매2024;



-- 회사 > 게시판 > 부서별 전용 게시판
select * from 영업부게시판;
select * from 총무부게시판;
select * from 개발부게시판;

-- 사장님 > 한번에 열람
select * from 영업부게시판
union
select * from 총무부게시판
union
select * from 개발부게시판;

--프로야구선수 > 트레이드
select * from 공격수;
select * from 수비수;

select 공통된컬럼 from 공격수
union
select 공통된컬럼 from 수비수;

--------------------------------------------------------------------------------

--동물 > 애완 동물
create table tblAAA (
    name varchar2(30) not null,
    color varchar2(30) not null
);

--동물 > 야생동물
create table tblBBB (
    name varchar2(30) not null,
    color varchar2(30) not null
);

insert into tblAAA values ('강아지', '검정');
insert into tblAAA values ('고양이', '노랑');
insert into tblAAA values ('토끼', '갈색');
insert into tblAAA values ('거북이', '녹색');
insert into tblAAA values ('강아지', '회색');

insert into tblBBB values ('강아지', '검정');
insert into tblBBB values ('고양이', '노랑');
insert into tblBBB values ('호랑이', '주황');
insert into tblBBB values ('사자', '회색');
insert into tblBBB values ('고양이', '삼색');

select * from tblAAA;
select * from tblBBB;

-- union > 합집합 > 중복 제거
select * from tblAAA
union
select * from tblBBB;

-- union all > 중복 허용
select * from tblAAA
union all
select * from tblBBB;

-- 차집합
select * from tblAAA
minus
select * from tblBBB;

select * from tblBBB
minus
select * from tblAAA;


--교집합
select * from tblAAA
intersect
select * from tblBBB;









