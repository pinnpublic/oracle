-- ex07_orderby.sql

/*

    [WITH subquery_name AS (subquery)]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC | DESC]];


    *** SELECT문은 레코드가 기본 단위
    
    SELECT column_list      -- 원하는 컬럼을 지정. > 해당 컬럼만 가져와라~
    FROM table_name         -- 데이터 소스. 어떤 테이블로부터 데이터를 가져올지
    WHERE search_condition  -- 행 조건 지정 > 원하는 행만 가져와라~
    ORDER BY order_expression [ASC | DESC] -- 레코드 정렬

    3. SELECT
    1. FROM
    2. WHERE
    4. ORDER BY
    
    
    ORDER BY 절
    - ORDER BY 컬럼명      //asc
    - ORDER BY 컬럼명 ASC  //ascending, 오름차순
    - ORDER BY 컬럼명 DESC //descending, 내림차순
    - ORDER BY 컬럼명 [,컬럼명] x N
    - ORDER BY 컬럼명 [ASC|DESC] [,컬럼명 [ASC|DESC]] x N

    ** 원본 테이블 저장된 레코드의 순서는 어떤 기준 + 정렬인지는 알 수 없다.
       > 오라클 맘대로..
*/
select * from tblInsa; --정렬 상태?
select * from tblInsa order by name asc;
select * from tblInsa order by basicpay desc;

select * from tblInsa order by buseo asc; --1차 정렬 
select * from tblInsa order by buseo asc, city desc; --2차 정렬
select * from tblInsa order by buseo asc, city desc, name asc; --3차 정렬



-- 정렬 > 우위 비교 > 대상 > 숫자, 문자, 날짜
select * from tblInsa order by basicpay desc; --숫자
select * from tblInsa order by name asc; --문자
select * from tblInsa order by ibsadate asc; --날짜

-- 첨자가 1부터 시작
-- ORDER BY 숫자
-- 컬럼 순서
select
    name, buseo, jikwi  --2.
from tblInsa            --1.
    order by 1 asc;     --3.


-- 직위순으로 정렬: 부장(4) > 과장(3) > 대리(2) > 사원(1)
select
    *
from tblInsa
    order by jikwi asc;

select
    name, jikwi,
    case
        when jikwi = '부장' then 4
        when jikwi = '과장' then 3
        when jikwi = '대리' then 2
        when jikwi = '사원' then 1
    end as order_number
from tblInsa
    order by order_number desc;



select
    name, jikwi,
    case
        when jikwi = '부장' then 4
        when jikwi = '과장' then 3
        when jikwi = '대리' then 2
        when jikwi = '사원' then 1
    end as order_number
from tblInsa
    order by order_number desc;


select
    name, jikwi
from tblInsa
    order by case
        when jikwi = '부장' then 4
        when jikwi = '과장' then 3
        when jikwi = '대리' then 2
        when jikwi = '사원' then 1
    end desc;
    
    
--tblInsa. 남자 > 여자순으로 정렬
select
    name, ssn    
from tblInsa
    order by case
        when ssn like '%-1%' then 1
        when ssn like '%-2%' then 2
    end asc;








