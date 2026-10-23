-- ex11_casting_function.sql

/*

    자바
    - 엄격한 문법을 준수하는 언어
    
    SQL
    - 유연한 문법을 제공하는 언어
    - 자료형 판정에 대해서 유연함 > 자동 형변환이 많이 발생
    
    
    형변환 함수 > 오라클 함수
    1. varchar2 to_char(숫자형): 숫자 > 문자 (*)
    2. varchar2 to_char(날짜형): 날짜 > 문자 (*****)
    3. number to_number(문자형): 문자 > 숫자 (*)
    4. date to_date(문자형)    : 문자 > 날짜 (*****)
    
    
    
    1. varchar2 to_char(숫자형 [,형식문자열])
    
    형식문자열 구성 요소
    a. 9: 숫자 1개를 문자 1개로 바꾸는 역할.
    b. 0: 숫자 1개를 문자 1개로 바꾸는 역할.
    c. $: 달러 기호
    d. L: 통화 기호(지역 설정)
    e. .: 소수점
    f. ,: 자릿수
    
*/

select
    basicpay as aaaaaaaaaaaaaaaaaaaaaaaaaa,
    to_char(basicpay) as bbbbbbbbbbbbbbbbbbbbbb
from tblInsa;


select
    weight, --64
    to_char(weight), --'64'
    to_char(weight, '99999'), -- '    64'
    to_char(weight, '00000'), -- ' 00064'
    to_char(-weight, '99999'),
    to_char(-weight, '00000'),
    to_char(weight, 'FM00000'), --부호 공백 제거
    ltrim(to_char(weight, '00000')),
    to_char(weight, '99')
from tblComedian;




select
    100,
    to_char(100, 'FM$999'), -- $100
    --to_char(100, '999달러')
    to_char(100, '999') || '달러',
    to_char(100, 'L999') --        ￦100
from dual;

select
    3.14,
    to_char(3.14, '9.99'), -- '3.14'
    to_char(3.15, '99.9'),  --  '3.1'
    to_char(1234567, '999,9999') -- 1,234,567    123,4,567    123,4567
from dual;




/*
    2. varchar2 to_char(날짜형 [,형식문자열])
    
    형식문자열 구성 요소
    a. yyyy         b. yy           c. month            d. mon
    e. mm           f. day          g. dy               h. ddd
    i. dd           j. d            k. hh               l. hh24
    m. mi           n. ss           o. am(pm)
*/
-- 현재 시각
-- c1.get(Calendar.상수)
select sysdate from dual; --26/08/11

select to_char(sysdate, 'yyyy') from dual; --2026 > 년(4자리)
select to_char(sysdate, 'yy') from dual; --26 > 년(2자리)
select to_char(sysdate, 'month') from dual; --8월 > 풀네임 
select to_char(sysdate, 'mon') from dual; --8월 > 약어
select to_char(sysdate, 'mm') from dual; --08 > 월(2자리)
select to_char(sysdate, 'day') from dual; --화요일 > 풀네임
select to_char(sysdate, 'dy') from dual; --화 > 약어
select to_char(sysdate, 'ddd') from dual; --일(올해 며칠)
select to_char(sysdate, 'dd') from dual; --일(이번달 며칠)
select to_char(sysdate, 'd') from dual; --일(이번주 며칠) > 요일 > NLS
select to_char(sysdate, 'hh') from dual; --시(12H)
select to_char(sysdate, 'hh24') from dual; --시(24H)
select to_char(sysdate, 'mi') from dual; --분
select to_char(sysdate, 'ss') from dual; --초
select to_char(sysdate, 'am') from dual; --오전  
select to_char(sysdate, 'pm') from dual; --오전  

-- date
-- 오라클: 년월일시분초
-- 다른: 년월일시분

-- timestamp


-- ISO 8601-1
select
    sysdate, --26/08/11
    to_char(sysdate, 'yyyy-mm-dd'), --2026-08-11
    to_char(sysdate, 'hh24:mi:ss'), --11:11:53
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), --2026-08-11 11:12:14
    to_char(sysdate, 'day am hh:mi:ss') --화요일 오전 11:13:00
from dual;


select
    name, ibsadate,
    to_char(ibsadate, 'yyyy-mm-dd') as 입사일,
    to_char(ibsadate, 'day') as 요일,
    case
        when to_char(ibsadate, 'd') in (7, 1) then '주말입사'
        else '평일입사'
    end
from tblInsa;


select
    name, ibsadate,
    to_char(ibsadate, 'yyyy-mm-dd') as 입사일,
    to_char(ibsadate, 'day') as 요일
from tblInsa
    order by to_char(ibsadate, 'mm') asc;



-- 3. number to_number(문자형)
select
    123 * 2,
    '123' * 2, --암시적 형변환
    to_number('123') * 2
from dual;




-- 4. date to_date(문자형)
select
    *
from tblInsa
    where ibsadate >= '2010-01-01'; -- 날짜 리터럴(X), 문자열 리터럴(O) --암시적 형변환

select
    *
from tblInsa
    where ibsadate >= to_date('2010-01-01');

select
    *
from tblInsa
    where ibsadate >= date '2010-01-01';


select
    ibsadate, --08/10/11
    '2020-01-01', --2020-01-01
    to_date('2020-01-01'), --20/01/01
    date '2020-01-01' --20/01/01
from tblInsa;


select
    '2020-01-01',
    to_date('2020-01-01'), --비권장
    to_date('2020-01-01', 'yyyy-mm-dd'), --권장
    to_date('2020-31-12', 'yyyy-dd-mm'), --20/12/31
    '2020-01-01 14:30:00',
    --to_date('2020-01-01 14:30:00')
    to_date('2020-01-01 14:30:00', 'yyyy-mm-dd hh24:mi:ss')
from dual;

-- 날짜 <-> 문자








