select * from dba_users order by username;


-- Ctrl + Enter
show user;

-- 한줄 주석

/*
    여러줄 주석
*/

-- 현재 작업 중인 파일 > 스크립트(script) > *.sql
-- Ctrl + S > C:\code\oracle\ex01.sql

-- 현재 스키마가 가지고 있는 테이블 목록을 가져와라
-- hr > 소유 테이블
select * from tabs;

select * from employees; 



/*

    사람 > (언어,SQL) > 오라클
    
    SQL, Structured Query Language
    - 구조화된 질의 언어
    - SQL, Query
    - 관계형 데이터베이스 조작 언어
    
    1. SQL와 RDBMS은 서로 독립적으로 관리된다.
        - SQL > 모든 관계형 데이터베이스에서 사용하는 공통 언어
        - Oracle RDB > 오라클 회사
        
    2. 표준 SQL, ANSI-SQL
        - 모든 RDB에 적용 가능한 SQL
    
    3. 제조사별(DBMS) SQL
        - 특정 RDB에서만 적용 가능한 SQL
        - 확장된 문법
        - Oracle > PL/SQL
        - MS-SQL > T-SQL
        
    오라클 수업 = ANSI-SQL(80%) + PL/SQL(5~10%) + DB 설계(10~15%)


    ANSI-SQL
    
    1. DDL
        - Data Definition Language
        - 데이터 정의어
        - DB의 구조를 생성/관리하는 명령어
        - 데이터베이스 객체(테이블, 뷰, 사용자, 인덱스 등)를
            생성/수정/삭제하는 명령어
        a. create: 생성
        b. alter : 수정
        c. drop  : 삭제
    
    2. DML
        - Data Manipulation Language
        - 데이터 조작어
        - 테이블 > 데이터를 추가/수정/삭제/조회하는 명령어
        - CRUD
        - 사용 빈도가 가장 높음
        a. select: 조회 > R > 가장 많이 사용
        b. insert: 추가 > C
        c. update: 수정 > U
        d. delete: 삭제 > D
    
    3. DCL
        - Data Control Language
        - 데이터 제어어
        - 계정 관리, 보안 관리, 트랜잭션 관리 등..
        a. commit
        b. rollback
        c. grant
        d. revoke
        
    ------
    
    4. DQL
        - Data Query Language
        - DML 중 select문을 따로 부르는 표현
    
    5. TCL
        - Transaction Control Language
        - DCL 중 commit/rollback문을 따로 부르는 표현



    오라클 인코딩
    - DB의 데이터를 보조 기억 장치에 저장한다. > 파일 입출력
    - 1.0 ~ 8: EUC-KR
    - 9i ~ 현재: UTF-8
    
    
    SQL > 대소문자를 구분하지 않는다.
    - 팀작업 > 자율적 + 내부 규칙 정한다.
    - 키워드: 대문자
    - 식별자: 소문자
    
*/
select * from tblCountry;
SELECT * FROM tbl_country;
SELECT * FROM TBLCOUNTRY;

-- Ctrl + F7
SELECT
    *
FROM
    tblcountry;


-- SQL*Plus, SQL Developer > 오라클 클라이언트 툴 전용 명령어
show user;












