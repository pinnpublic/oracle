-- ex26_with.sql

/*

    [WITH subquery_name AS (subquery)]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC | DESC]];
    
    WITH subquery_name AS (subquery) - 인라인뷰에 잠시 이름을 붙인다.(가독성)
    SELECT column_list      -- 원하는 컬럼을 지정. > 해당 컬럼만 가져와라~
    FROM table_name         -- 데이터 소스. 어떤 테이블로부터 데이터를 가져올지
    WHERE search_condition  -- 행 조건 지정 > 원하는 행만 가져와라~
    GROUP BY group_by_expression --그룹을 나눈다.
    HAVING search_condition -- 원하는 그룹을 지정 > 해당 그룹만 가져와ㄹ
    ORDER BY order_expression [ASC | DESC] -- 레코드 정렬

    1. WITH
    6. SELECT
    2. FROM
    3. WHERE
    4. GROUP BY
    5. HAVING
    7. ORDER BY
    
    
    WITH절
    - CTE(Common Table Expression)
    - 임시 테이블(인라인뷰) > 이름 붙이는 기술
    - 가독성 목적!! > 큰 쿼리
    - 결과셋에는 아무런 영향을 미치지 않는다.
    
*/

select 
    a.* 
from (select name, buseo, jikwi from tblInsa where city = '서울') a;


with a as (select name, buseo, jikwi from tblInsa where city = '서울') --1.
select * from a; --2.


--tblMen.몸무게(90kg이하) + tblWomen.몸무게(60kg초과) > join

select * from tblMen m
    inner join tblWomen w
        on m.name = w.couple;

select * from (select * from tblMen where weight <= 90) m
    inner join (select * from tblWomen where weight > 60) w
        on m.name = w.couple;


-- 뷰 생성 비용
create or replace view vwMen
as
select * from tblMen where weight <= 90;

create or replace view vwWomen
as
select * from tblWomen where weight > 60;

select * from vwMen m
    inner join vwWomen w
        on m.name = w.couple;




with m as (select * from tblMen where weight <= 90), 
     w as (select * from tblWomen where weight > 60)
     
select * from m
    inner join w
        on m.name = w.couple;












