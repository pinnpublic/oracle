-- ex05_where.sql

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

    3. SELECT
    1. FROM
    2. WHERE

*/


select *
    from tblCountry
        where 가져오고 싶은 행을 찾기 위한 조건;

select *                        --3.
    from tblCountry             --1.
        where continent = 'AS'; --2.

select *                        
    from tblCountry             
        where continent <> 'AS';

-- tblComedian
-- 1. 몸무게(weight)가 60kg 이상이고, 키(height)가 170cm 미만 사람
select * from tblComedian
    where weight >= 60 and height < 170;

-- 2. 몸무게가 70kg 이하인 여자만
select * from tblComedian
    where weight <= 70 and gender = 'f';

-- tblInsa
-- 3. 부서(buseo)가 '개발부'이고, 급여(basicpay)가 150만원 이상 받는 직원
select * from tblInsa
    where buseo = '개발부' and basicpay > 1500000;

-- 4. 급여(basicpay) + 수당(sudang)을 합친 금액이 200만원 이상 받는 직원
select 
    name, basicpay, sudang,
    basicpay + sudang
from tblInsa
    where basicpay + sudang >= 2000000;



/*

    between, in > 사용 > 뭐라고~
    
    DB > Optimizer > SQL 실행하기 전에 최적의 결과를 얻기 위해서 SQL 수정
    
    SQL을 가장 빠르고 효율적으로 수행할 최적의 처리경로(최저비용)를 
    생성해주는 DBMS 내부의 핵심 엔진입니다.
    


    between
    - where절에서 많이 사용 > 조건으로 사용
    - 컬럼명 between 최솟값 and 최댓값
    - 범위 비교
    - 가독성 향상
    - 최솟값, 최댓값 모두 포함

*/
select * from tblInsa where basicpay >= 1000000 and basicpay <= 1200000;
select * from tblInsa where basicpay <= 1200000 and basicpay >= 1000000;
select * from tblInsa where 1200000 >= basicpay and basicpay >= 1000000;

select * from tblInsa where basicpay between 1000000 and 1100000;


/*
    SQL에서 비교 연산
    1. 숫자형
    2. 문자형
    3. 날짜형
*/
select * from employees where first_name >= 'H';
select * from employees where first_name >= 'H' and first_name <= 'J';
select * from employees where first_name between 'H' and 'J';

desc tblInsa;
select * from tblInsa where ibsadate <= '2010-01-01';
select * from tblInsa where ibsadate <= '2010-01-01' and ibsadate >= '2009-01-01';
select * from tblInsa where ibsadate between '2009-01-01' and '2010-01-01';







/*
    in
    - where절에서 많이 사용 > 조건으로 사용
    - 열거형 비교
    - 컬럼명 in (값, 값, 값..)
    - 가독성 향상
*/

-- tblInsa. 개발부 + 홍보부 + 총무부
select * from tblInsa
    where buseo = '개발부' or buseo = '홍보부' or buseo = '총무부';

select * from tblInsa
    where buseo in ('개발부', '홍보부', '총무부');



/*

    like
    - where절에서 많이 사용 > 조건으로 사용
    - 패턴 비교(정규 표현식 유사 기능)
    - 컬럼명 like '패턴 문자열'
    
    패턴 문자열 구성 요소
    1. _: 임의의 문자 1개(.)
    2. %: 임의의 문자 N개. 0~무한대(.*)
    
*/
-- 직원명: 김OO
select * from tblInsa;
select * from tblInsa where name like '김__';
select * from tblInsa where name like '_길_';
select * from tblInsa where name like '__수';

select * from employees where first_name like 'S____r';

-- 직원명: 김OO, 김O, 김OOO
select * from tblInsa where name like '김__';
select * from tblInsa where name like '김%';


select * from employees where first_name like 'S%';
select * from employees where first_name like '%r';
select * from employees where first_name like '%r%'; -- contains('r') //java

-- 남자 직원만(871212-1022432)
select * from tblInsa where ssn like '______-1______';
select * from tblInsa where ssn like '%-2%';


/*
    null
    - SQL은 피연산자로 null을 가질 수 없다.
    
    null
    not null
    
    is null
    - where절에서 많이 사용
    - null 조건
    - 컬럼명 is null
*/

-- 인구수 미기재
select * from tblCountry where population = null;
select * from tblCountry where population is null;

-- 인구수 기재
select * from tblCountry where population <> null;
select * from tblCountry where not population is null;
select * from tblCountry where population is not null;

-- 연락처 미기재
select * from tblInsa where tel is null;
select * from tblInsa where tel is not null;

-- tblTodo(adddate, completedate)
-- 할일을 완료한 것만
select * from tblTodo where completedate is not null;

-- 아직 안한것들
select * from tblTodo where completedate is null;

-- 도서관 > 대여 테이블(컬럼: 대여날짜, 반납날짜)
-- 아직 반납을 안한 사람?
select * from 대여 where 반납날짜 is null;

-- 반납 완료
select * from 대여 where 반납날짜 is not null;










