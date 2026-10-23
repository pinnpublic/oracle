-- ex23_alter.sql

/*

    DML > 데이터 조작
    - 데이터 생성: insert
    - 데이터 수정: update
    - 데이터 삭제: delete
    
    DDL > 객체 조작
    - 객체 생성: create
    - 객체 수정: alter(or replace)
    - 객체 삭제: drop
    
    
    테이블 수정하기
    - 테이블 수정 > 컬럼 수정 > 컬럼명 or 자료형(길이) or 제약사항 수정
    
    
    테이블 수정하는 방법
    1. 테이블 삭제(drop) > 테이블 DDL(create) 수정 > 수정된 DLL로 다시 테이블 생성
        a. 기존 테이블에 데이터가 없는 경우 > 아무 문제 없음~
        b. 기존 테이블에 데이터가 있는 경우 > 미리 데이터 백업 > 테이블 삭제
            > 테이블 DDL 수정 > 수정된 DDL로 다시 테이블 생성
            > 백업한 데이터를 다시 복구
    
    2. alter 명령어 사용 > 기존 테이블의 구조 변경
        a. 기존 테이블에 데이터가 없는 경우 > 아무 문제 없음~
        b. 기존 테이블에 데이터가 있는 경우 > 상황에 따라 비용 차이 발생
*/

drop table tblEdit;

create table tblEdit (
    seq number,
    name varchar2(20)
);

insert into tblEdit values (1, '마우스');
insert into tblEdit values (2, '키보드');
insert into tblEdit values (3, '모니터');

-- Case 1. 새로운 컬럼을 추가하기
alter table 테이블명 add (컬럼 정의);

alter table tblEdit
    add (price number);

select * from tblEdit;


-- 새로운 컬럼이 not null이라면?
-- 1. 데이터 삭제 > 컬럼 추가

delete from tblEdit;

alter table tblEdit
    add (price number not null);

select * from tblEdit;

desc tblEdit;

--2. default 사용
alter table tblEdit
    add (price number default 0 not null);

select * from tblEdit;


-- Case 2. 기존 컬럼을 삭제하기
alter table 테이블명 drop column 컬럼명;

alter table tblEdit
    drop column price;

select * from tblEdit;

alter table tblEdit
    drop column seq; --PK 삭제!! > 절대 금지!!


-- Case 3. 컬럼 수정하기

-- Case 3.1 컬럼 길이 수정하기(확장/축소)
-- VARCHAR2(20) > VARCHAR2(100) 
insert into tblEdit values (4, '삼성 갤럭시 8 와이드 폴더폰');

alter table 테이블명 modify (컬럼 정의);

alter table tblEdit
    modify (name varchar2(100)); --확장

alter table tblEdit
    modify (name varchar2(38)); --축소
    
select
    name,
    length(name),
    lengthb(name)
from tblEdit;

--Case 3.2 컬럼의 NOT NULL 수정하기
alter table 테이블명 modify (컬럼명 자료형(길이) null); --NOT NULL > NULL
alter table 테이블명 modify (컬럼명 자료형(길이) not null); --NULL > NOT NULL

desc tblEdit;

alter table tblEdit
    modify (name varchar2(38) not null);

alter table tblEdit
    modify (name varchar2(38) null);


-- Case 3.3 컬럼의 자료형 바꾸기
alter table tblEdit
    modify (name number);
    
update tblEdit set name = null;
    
select * from tblEdit;


-- Case 3.4 컬럼명 바꾸기
alter table tblEdit
    rename column name to item;
    
select * from tblEdit;    



-- Case 4. 제약 사항 조작(추가, 삭제)
-- 3. 외부에서 만드는 방법
drop table tblEdit;

create table tblEdit (
    seq number,
    name varchar2(20)
);

alter table tblEdit
    add constraint tbledit_seq_pk primary key(seq);

alter table tblEdit
    add constraint tbledit_name_uq unique(name);

alter table tblEdit
    drop constraint tbledit_name_uq;








