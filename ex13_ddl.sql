-- ex13_ddl.sql

/*
    수업 진도
    
    1. 초반 DML (ex01 ~ ex12)
    2. DDL > 테이블
    3. 후반 DML
    ------------------------- ANSI-SQL
    4. 데이터 설계(모델링)
    5. 간단한 프로젝트: 1일
    -------------------------
    6. PL/SQL
    ------------------------- PL/SQL
    7. DB 프로젝트: 4일~6일    
    
    
    
    
    
     1. DDL
        - Data Definition Language
        - 데이터 정의어
        - DB의 구조를 생성/관리하는 명령어
        - 데이터베이스 객체(테이블, 뷰, 사용자, 인덱스 등)를
            생성/수정/삭제하는 명령어
        a. create: 생성
        b. alter : 수정
        c. drop  : 삭제
    
    
    테이블 생성하기 > 테이블 구조(스키마, Schema) 설계
        > 컬럼 정의하기 > 컬럼명, 자료형, 길이, 제약사항 정의
    
    
    create table 테이블명 (
        컬럼 선언,
        컬럼명 자료형(길이) NULL 제약사항
    ); 
    
    
    제약사항, Constraint
    - 데이터베이스 무결성을 보장하기 위한 장치
    - 해당 컬럼에 들어갈 데이터에 대한 조건
        1. 조건을 만족하면 > 저장
        2. 조건을 불만족하면 > 오류 발생
    
    1. NOT NULL
        - 해당 컬럼이 반드시 값을 가져야 한다.
        - 해당 컬럼에 값이 없으면 에러 발생
        - 필수값(required)
    
    2. PRIMARY KEY, PK
        - 기본키(Key == 컬럼) > 대표 역할을 하는 컬럼
        - 테이블의 행을 구분하기 위한 제약 사항
        - 이 컬럼은 반드시 중복값이 존재할 수 있다. > 유일해야 한다.
        - 하나의 테이블에는 PK가 2개 이상 존재할 수 있다.
        - 반드시 테이블에는 PK가 존재해야한다.(존재안해도 에러 안남 > 관습)
        - PK = NOT NULL + UNIQUE
    
    3. FOREIGN KEY, FK
        - 나중에
    
    4. UNIQUE
        - 유일하다. 
        - 레코드간의 중복값을 가질 수 있다.
        - UNIQUE = PK - NOT NULL
        - NULL을 가질 수 있다. > 식별자가 될 수 없다.
        ex) 초등학교
            - 학생(번호(PK), 이름(NN), 직책(UQ))
                   1,홍길동,반장
                   2,아무개,NULL
                   3,하하하,부반장
                   4,호호호,체육부장
    
    5. CHECK
        - 사용자 정의형
        - 제약 조건 정의 > where절의 조건과 동일
    
    6. DEFAULT
        - 기본값 설정 기능
        - insert/update 작업 시 > 컬럼에 값을 안넣으면 null 대신에
                                   미리 준비한 값을 대신 삽입
    
    
*/

-- 메모 테이블
create table tblMemo (
    -- 컬럼명 자료형(길이) NULL 제약사항
    seq number(3) NULL,              --메모번호. null > 널 허용 컬럼(optional)
    name varchar2(30) NULL,          --작성자
    memo varchar2(2000) NULL,        --메모
    regdate date  NULL               --작성일    
);

insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', '2026-08-11'); --00:00:00

insert into tblMemo (seq, name, memo, regdate)
    values (2, '홍길동', '메모입니다.'
                , to_date('2026-08-11 14:26:27', 'yyyy-mm-dd hh24:mi:ss'));

insert into tblMemo (seq, name, memo, regdate)
    values (3, '홍길동', '메모입니다.', sysdate);


--26/08/11 00:00:00
--26/08/11 14:26:27
--26/08/11 메모쓸때시간

insert into tblMemo (seq, name, memo, regdate)
    values (4, '홍길동', '메모입니다.', null);
    
insert into tblMemo (seq, name, memo, regdate)
    values (5, null, null, null);   

insert into tblMemo (seq, name, memo, regdate)
    values (null, null, null, null);

select * from tblMemo;
    
drop table tblMemo;
    
create table tblMemo (
    seq number(3) not null,       --메모번호(NN)
    name varchar2(30),            --작성자
    memo varchar2(2000) not null, --메모(NN)
    regdate date                   --작성일    
);

insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', sysdate);
    
-- ORA-01400: NULL을 ("HR"."TBLMEMO"."MEMO") 안에 삽입할 수 없습니다    
insert into tblMemo (seq, name, memo, regdate)
    values (2, '홍길동', null, sysdate);   
    
insert into tblMemo (seq, name, memo, regdate)
    values (3, '홍길동', '', sysdate);  -- 빈문자열('')도 null로 취급한다.

insert into tblMemo (seq, name, memo, regdate)
    values (4, '홍길동', ' ', sysdate);





drop table tblMemo;
    
create table tblMemo (
    seq number(3) primary key,    --메모번호(PK)
    name varchar2(30),            --작성자
    memo varchar2(2000) not null, --메모(NN)
    regdate date                   --작성일    
);

insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', sysdate);

insert into tblMemo (seq, name, memo, regdate)
    values (2, '홍길동', '메모입니다.', sysdate);
    
insert into tblMemo (seq, name, memo, regdate)
    values (null, '홍길동', '메모입니다.', sysdate);





drop table tblMemo;
    
create table tblMemo (
    seq number(3) primary key,    --메모번호(PK)
    name varchar2(30) unique not null,     --작성자(UQ)
    memo varchar2(2000) not null, --메모(NN)
    regdate date                   --작성일    
);

insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', sysdate);

insert into tblMemo (seq, name, memo, regdate)
    values (2, '홍길동', '메모입니다.', sysdate);

insert into tblMemo (seq, name, memo, regdate)
    values (2, '강아지', '메모입니다.', sysdate);

insert into tblMemo (seq, name, memo, regdate)
    values (3, null, '메모입니다.', sysdate);
    
insert into tblMemo (seq, name, memo, regdate)
    values (4, null, '메모입니다.', sysdate);












drop table tblMemo;
    
create table tblMemo (
    seq number(3) primary key,
    name varchar2(30),
    memo varchar2(2000) not null,
    regdate date,
    
    --중요도(1-중요, 2-보통, 3-안중요)
    --priority number(1) check (priority >= 1 and priority <= 3),
    priority number(1) check (priority between 1 and 3),
    
    --카테고리(할일, 공부, 약속)
    --category varchar2(10) check (category = '할일' or category = '공부' or category = '약속')
    category varchar2(10) check (category in ('할일','공부','약속'))
);

insert into tblMemo (seq, name, memo, regdate, priority, category)
    values (1, '홍길동', '메모입니다.', sysdate, 2, '공부');
    
insert into tblMemo (seq, name, memo, regdate, priority, category)
    values (2, '홍길동', '메모입니다.', sysdate, 5, '공부');

insert into tblMemo (seq, name, memo, regdate, priority, category)
    values (3, '홍길동', '메모입니다.', sysdate, 2, '게임');















drop table tblMemo;
    
create table tblMemo (
    seq number(3) primary key,
    name varchar2(30) default '익명',
    memo varchar2(2000) not null,
    regdate date default sysdate
);

insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', sysdate);

-- 의도적으로 null을 넣겠다.(의지 담겨 있음)
insert into tblMemo (seq, name, memo, regdate)
    values (2, null, '메모입니다.', sysdate);

-- 이름 넣는걸 포기하겠습니다.(의지가 없음)
insert into tblMemo (seq, memo, regdate)
    values (3, '메모입니다.', sysdate);
    
select * from tblMemo;


/*
    제약 사항을 만드는 방법(코드 관리)
    
    1. 컬럼 수준에서 만드는 방법
        - 위의 수업 방식
        - 컬럼을 선언할 때 동시에 제약사항도 같이 만드는 방식
    
    2. 테이블 수준에서 만드는 방법
        - 컬럼 선언과 제약사항 선언을 분리해서 만드는 방식
    
    3. 외부에서 만드는 방법

*/
drop table tblMemo;

create table tblMemo (
    seq number(3) constraint tblmemo_seq_pk primary key,
    name varchar2(30),
    memo varchar2(2000),
    regdate date
);

drop table tblMemo;
create table tblMemo (
    seq number(3),
    name varchar2(30) not null,
    memo varchar2(2000) not null,
    regdate date default sysdate,
    
    constraint tblmemo_seq_pk primary key(seq),
    --constraint tblmemo_name_uq unique(name),
    constraint tblmemo_memo_ck check (length(memo) >= 10)
);

-- ORA-00001: 무결성 제약 조건(HR.SYS_C008393)에 위배됩니다
-- ORA-00001: 무결성 제약 조건(HR.TBLMEMO_SEQ_PK)에 위배됩니다
insert into tblMemo (seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다.', sysdate);








