-- *.sql > (SQL)스크립트 파일

-- ex01_datatype.sql

-- 한줄 주석
/*
    여러줄 주석
*/


/*

    관계형 데이터베이스
    - 변수(X), 제어문(X) > SQL은 프로그래밍 언어가 아니다.(제어 흐름)
    - DB와 대화를 목적으로 하는 언어 > 대화형 언어
    - SQL 자료형 > 테이블 선언할 때 사용 > 컬럼에 적용

    
    ANSI-SQL 자료형(오라클 자료형)
    
    1. 숫자형
        - 정수/실수
        a. number
            - (유효자리)38자리까지 표현
            - 12345678901234567890123456789012345678
            - 1234567890123456789012345678901234567800000000
            - 1~22byte
            - 1x10^-130 ~ 9.9999x10^125
            - number: 정수 or 실수
            - number(precision): 전체 자릿수, 정수형
            - number(precision, scale): 소수이하 자릿수 > 정수형, 실수형
    
    2. 문자형
    
    3. 날짜/시간형
    
    4. 이진 데이터형
    

*/

/*

    DDL
    
    create table 테이블명 (
        컬럼 선언,
        컬럼 선언,
        컬럼 선언,
        컬럼명 자료형
    );

*/

--수업 식별자 패턴: DB Object > 헝가리언 표기법

drop table tblType;

create table tblType (
    --num number
    --num number(3) -- 3자리, -999 ~ +999
    num number(4,2) -- 4자리(정수 2자리 + 소수이하 2자리), -99.99 ~ +99.99
);

select * from tabs; --tables. 내가 가지고 있는 테이블 목록


-- 데이터 추가하기
-- insert into 테이블명 (컬럼명) values (값);
-- insert into 테이블명 (컬럼명A, 컬럼명B) values (값A, 값B);

insert into tblType (num) values (100);  -- 100 > 정수형 리터럴
insert into tblType (num) values (3.14); -- 3.14 > 실수형 리터럴
insert into tblType (num) values (3.54);
insert into tblType (num) values (999);
insert into tblType (num) values (-999);
insert into tblType (num) values (1000);
insert into tblType (num) values (-1000);
insert into tblType (num) values (999.99);
insert into tblType (num) values (999.39);
insert into tblType (num) values (12345678901234567890123456789012345678);
insert into tblType (num) values (1234567890123456789012345678901234567890123456789);
insert into tblType (num) values (-99.99);
insert into tblType (num) values (99.99);
insert into tblType (num) values (99.90999999);

select * from tblType; --테이블의 모든 데이터를 가져와라

























