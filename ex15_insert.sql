-- ex15_insert.sql

/*
        
    insert문
    - 테이블에 데이터를 추가하는 명령어
    
    구문
    insert into 테이블명 (컬럼리스트) values (값리스트);
    
    insert 
        into 테이블명 (컬럼리스트) 
               values (값리스트);
    
*/

drop table tblMemo;

create table tblMemo (
    seq number(3) primary key,
    name varchar2(30) default '익명',
    memo varchar2(2000),
    regdate date default sysdate not null
);

drop sequence seqMemo;
create sequence seqMemo;

--1. 표준
--: 원본 테이블의 정의된 컬럼 순서대로.. 컬럼리스트와 값리스트를 작성
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

--2. 컬럼리스트의 순서는 원본 테이블과 무관하다.
--: 컬럼리스트와 값리스트의 순서는 일치해야 한다.(*******)
insert into tblMemo (regdate, seq, name, memo)
    values (sysdate, seqMemo.nextVal, '홍길동', '메모입니다.');

--3. ORA-00913: 값의 수가 너무 많습니다
insert into tblMemo (seq, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

--4. ORA-00947: 값의 수가 충분하지 않습니다
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '메모입니다.', sysdate);

--5. null 허용 컬럼을 조작 > null을 넣는 방법
--5.1 null 상수 사용 > 의지 강함
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', null, sysdate);

--5.2 컬럼 생략 > 의지 약함
insert into tblMemo (seq, name, regdate)
    values (seqMemo.nextVal, '홍길동', sysdate);

--6. default 컬럼 조작 > 기본값
--6.1 default 컬럼 > 값을 명시적으로 넣으면
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

--6.2 값을 포기 > null > 의지 강함 > default 동작 불가
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, null, '메모입니다.', sysdate);  

--6.3 값을 포기 > null > 의지 약함 > default 동작 함
insert into tblMemo (seq, memo, regdate)
    values (seqMemo.nextVal, '메모입니다.', sysdate);  

--6.4 명시적 default 사용
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, default, '메모입니다.', sysdate);    

--7. 단축 > 생략된 컬럼리스트의 컬럼 순서는 원본테이블 순서대로(***)
--7.1 컬럼 리스트를 생략할 수 있다.
insert into tblMemo values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

--7.2 값리스트의 순서를 바꿀 수 없다.
insert into tblMemo values ('홍길동', '메모입니다.', sysdate, seqMemo.nextVal);

--7.3 null
insert into tblMemo values (seqMemo.nextVal, '홍길동', sysdate);
insert into tblMemo values (seqMemo.nextVal, '홍길동', null, sysdate);

--7.4 default
insert into tblMemo values (seqMemo.nextVal, '메모입니다.', sysdate);
insert into tblMemo values (seqMemo.nextVal, default, '메모입니다.', sysdate);

--------------------------------------------------------------------------------

--8. 
--tblMemo 테이블 > 복사 > 새 테이블 생성(tblMemoCopy)

create table tblMemoCopy (
    seq number(3) primary key,
    name varchar2(30) default '익명',
    memo varchar2(2000),
    regdate date default sysdate not null
);

select * from tblMemo;
-- insert.. 1	홍길동	메모입니다.	26/08/12

insert into tblMemoCopy select * from tblMemo; --Sub Query

select * from tblMemoCopy;

delete from tblMemoCopy;

insert into tblMemoCopy select * from tblMemo where memo is null;

select * from tblMemoCopy;

insert into 영업부 select * from tblInsa where buseo = '영업부';



--9.
--tblMemo 테이블 > 복사 > 새 테이블 생성(tblMemoCopy)
--테이블 생성(컬럼 복사) + 데이터 복사
--제약사항은 복사가 안된다.(NOT NULL제외)
--더미 데이터용 > 임시용 or 테스트용

drop table tblMemoCopy;

create table tblMemoCopy
as
select * from tblMemo;

desc tblMemoCopy;

select * from tblMemoCopy;


insert into tblMemo values (1, '홍길동', '메모입니다.', sysdate);
insert into tblMemoCopy values (1, '홍길동', '메모입니다.', sysdate);























