-- ex19_having.sql

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
    HAVING search_condition -- 원하는 그룹을 지정 > 해당 그룹만 가져와ㄹ
    ORDER BY order_expression [ASC | DESC] -- 레코드 정렬

    5. SELECT
    1. FROM
    2. WHERE
    3. GROUP BY
    4. HAVING
    6. ORDER BY
    
    
    from + where
    - from: 모든 레코드 가져온다.
    - where: 레코드마다 검사
    
    group by + having
    - group by: 그룹을 생성한다.
    - having: 그룹마다 검사
    

*/

select
    buseo,
    count(*)
from tblInsa
    group by buseo
        having count(*) > 10;

select
    buseo,
    count(*)
from tblInsa                            --1.
    where city in ('서울', '인천')      --2. 60명 대상 > 조건
        group by buseo                  --3. 29명 대상 > 그룹
            having count(*) > 5;        --4. 7개 그룹 > 조건


select count(*) from tblInsa where city in ('서울', '인천');
















