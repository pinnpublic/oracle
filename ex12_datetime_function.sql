-- ex12_datetime_function.sql

/*
    날짜시간 함수
    
    sysdate
    - 시스템의 시간을 반환
    - date sysdate
*/
select sysdate from dual;


/*
    날짜 연산
    1. 시각 - 시각 = 시간
    2. 시각 + 시간 = 시각
    3. 시각 - 시간 = 시각
*/

-- 1. 시각 - 시각 = 시간(일)
-- 현재 - 입사일 = 근무일
select
    name, to_char(ibsadate, 'yyyy-mm-dd') as 입사일,
    round(sysdate - ibsadate) as 근무일수, 
    round((sysdate - ibsadate) * 24) as 근무시수,
    round((sysdate - ibsadate) * 24 * 60) as 근무분수,
    round((sysdate - ibsadate) * 24 * 60 * 60) as 근무초수,
    round((sysdate - ibsadate) / 30.4) as 근무개월수, --사용금지
    round((sysdate - ibsadate) / 365.25) as 근무년수 --사용금지
from tblInsa;

--단위? 6513.487708333333333333333333333333333333

select
    title,
    round((completedate - adddate) * 24) as "실행하기까지 걸린 시간"
from tblTodo
    order by round((completedate - adddate) * 24) asc;


/*
    2. 시각 + 시간(일) = 시각
    3. 시각 - 시간(일) = 시각
*/
select
    sysdate,
    sysdate + 100 as "100일 후",
    sysdate - 100 as "100일 전",
    to_char(sysdate + (3 / 24), 'hh24:mi:ss') as "3시간 뒤",
    to_char(sysdate - (30 / 60 / 24), 'hh24:mi:ss') as "30분 전"
from dual;

/*
    
    날짜 연산(일,시,분,초)
    
    시각 - 시각 = 시간(일)
    시각 + 시간(일) = 시각
    시각 - 시간(일) = 시각
    
    
    날짜 연산(년,월)
    
    number months_between(date, date)
    시각 - 시각 = 시간(월)
    
    date add_months(기준시각, 월)
    시각 + 시간(월) = 시각
    시각 - 시간(월) = 시각
    
*/
select
    name,
    round(sysdate - ibsadate) as 근무일수,
    round(months_between(sysdate, ibsadate)) as 근무개월수,
    round(months_between(sysdate, ibsadate) / 12) as 근무년수
from tblInsa;

select
    sysdate,
    add_months(sysdate, 20),
    add_months(sysdate, -10),
    add_months(sysdate, 30 * 12)
from dual;

/*
    시각 - 시각 = 시간(*)
    1. 일, 시, 분, 초 > 연산자(-)
    2. 년, 월 > months_between()
    
    시각 +- 시간(*) = 시각
    1. 일, 시, 분, 초 > 연산자(+,-)
    2. 년, 월 > add_months()
*/



-----------------------------------------

-- null 함수 > null value
-- 1. nvl
-- 2. nvl2
select
    name, population,
    case
        when population is null then 0
        else population
    end,
    nvl(population, 0),
    nvl2(population, 10000, 0),
    nvl2(population, '인구 기재됨', '인구 기재안됨')
    
    --nvl(population, '인구 기재안됨')
    --nvl2(population, 100, sysdate)
    
from tblCountry;








