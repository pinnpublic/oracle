-- ex18_groupby.sql

/*

    [WITH subquery_name AS (subquery)]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC | DESC]];
    
    SELECT column_list      -- 원하는 컬럼을 지정. > 해당 컬럼만 가져와라~
    FROM table_name         -- 데이터 소스. 어떤 테이블로부터 데이터를 가져올지
    WHERE search_condition  -- 행 조건 지정 > 원하는 행만 가져와라~
    GROUP BY group_by_expression --그룹을 나눈다.
    ORDER BY order_expression [ASC | DESC] -- 레코드 정렬

    4. SELECT
    1. FROM
    2. WHERE
    3. GROUP BY
    5. ORDER BY
    
    
    group by절
    - 특정 기준(컬럼)으로 레코드들을 그룹을 나눈다.
    
    
    강의실
    - 특정 기준(성별=컬럼값)을 사용해서 사람(대상=레코드)들을 그룹을 나눈다.(수단)
        > 각각의 그룹을 대상으로 집계 함수를 실행한다.(목적)

*/
select * from tblInsa;

--tblInsa. 직위별 평균 급여?
select avg(basicpay) from tblInsa; --1556526

select distinct jikwi from tblInsa; --부장,과장,대리,사원

select avg(basicpay) from tblInsa where jikwi = '부장'; --2545714
select avg(basicpay) from tblInsa where jikwi = '과장'; --2308625
select avg(basicpay) from tblInsa where jikwi = '대리'; --1905784
select avg(basicpay) from tblInsa where jikwi = '사원'; --1010231


select
    jikwi,
    round(avg(basicpay))    --3. 4그룹 각각 > 평균
from tblInsa                --1. 60명
    group by jikwi;         --2. 그룹 > 4그룹


select
    count(*), buseo
from tblInsa
    group by buseo
        order by count(*) desc;


select
    buseo,
    count(*) as 인원수,
    sum(basicpay) as 급여합,
    avg(basicpay) as 평균급여,
    max(basicpay) as 최대급여,
    min(basicpay) as 최소급여
from tblInsa
    group by buseo;


select
    count(*)
from tblInsa
    group by ssn;


select
    substr(ssn, 8, 1),
    count(*),
    avg(basicpay)
from tblInsa
    group by substr(ssn, 8, 1);


-- 과장+부장 > 몇명?, 사원+대리 > 몇명?
select
    case
        when jikwi in ('과장', '부장') then 1
        else 2
    end
from tblInsa;


select
    count(*),
    case
        when jikwi in ('과장', '부장') then 1
        else 2
    end
from tblInsa
    group by case
        when jikwi in ('과장', '부장') then 1
        else 2
    end;


--급여
--100만원 미만
--100만원 이상 ~ 200만원 미만
--200만원 이상
select
    count(*)
from tblInsa
    group by basicpay;

select
    --basicpay,
    count(*),
    trunc(basicpay / 1000000)
from tblInsa
    group by trunc(basicpay / 1000000);



--tblTodo
select
    completedate,
    count(*)
from tblTodo
    group by completedate;


select
    case
        when completedate is not null then 1
        else 2
    end,
    count(*)
from tblTodo
    group by case
        when completedate is not null then 1
        else 2
    end;

----------------------------------------------

-- 다중 그룹
select
    buseo,
    jikwi,
    count(*)
from tblInsa
    group by buseo, jikwi
        order by buseo asc, jikwi asc;


---------------------------------------------------------------


--group by 사용 시 주의점!! > 집계 함수의 주의점 유사!!
--ORA-00979: GROUP BY 표현식이 아닙니다.

--group by 사용 시 > 컬럼리스트에 올 수 있는 것
--1. 집계함수
--2. 그룹 기준

--올 수 없는 것
--3. 2가 아닌 나머지 컬럼

select
    count(*),
    jikwi,  --집합데이터
    name
from tblInsa
    group by jikwi; --직위를 그룹의 기준 > 집합데이터


select name, jikwi from tblInsa; --jikwi 개인데이터




