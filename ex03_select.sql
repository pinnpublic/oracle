-- ex03_select.sql

/*

    SELECT문
    - DML, DQL
    - 특정 테이블로부터 원하는 데이터를 가져온다. 읽기
    
    
    
    SELECT 구문
    - OO절 > 각각 기능
    
    [WITH subquery_name AS (subquery)]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC | DESC]];

    SELECT 각 절
    1. 해당 절이 무슨 일?
    2. 각 절의 실행 순서


    SELECT column_list  -- 원하는 컬럼을 지정. > 해당 컬럼만 가져와라~
    FROM table_name     -- 데이터 소스. 어떤 테이블로부터 데이터를 가져올지


    실행 순서
    2. SELECT
    1. FROM

*/

select txt from tblType;

select txt 
from tblType;

select txt 
    from tblType;
    
select 
    txt 
from tblType;    

select 
    txt 
from 
    tblType; 


-- hr.employees > 처음 보는 테이블 > ??? > 구조(테이블 스키마) = 어떤 컬럼
-- 1. DDL 확인(create table employees)
-- 2. 테이블 명세서
-- 3. 직접 테이블 객체 확인
-- 2 >>>>> 1 > 3

-- describe
desc employees;


select * from tblCountry;

select *            -- *(all, star) > 와일드카드 > 모든 컬럼
from tblCountry;

select name         --단일 컬럼
from tblCountry;

select name, capital    --다중 컬럼
from tblCountry;

select capital, name    --다중 컬럼 > 컬럼 순서는 맘대로~
from tblCountry;

select name, name       --같은 컬럼 여러번 가져오기
from tblCountry;

select name, length(name)
from tblCountry;











