-- ex08_aggregation_function.sql

/*

    클래스내에서 선언된 함수를 메서드라고 한다.
    - 객체명.메서드()
    - 클래스명.메서드()
    
    SQL의 함수
    - 독립적으로 존재
    
    함수, Function
    1. 내장 함수, Built-in Function
    2. 사용자 정의 함수, User Function > ANSI-SQL(X), PL/SQL(O)
    
    
    집계(통계) 함수, Aggregation Function
    - Java Stream > count(), sum(), average(), max(), min()
    
    SQL 집계 함수
    1. count()
    2. sum()
    3. avg()
    4. max()
    5. min()
    
    1. count()
    - 결과셋의 레코드 수를 반환
    - number count(*) //특정 컬럼의 null 유무와 상관없이 모든 레코드 수 
    - number count(특정 컬럼명) //null을 예상하고 레코드 수
    - null 값은 제외한다.(*****)
    
*/
select * from tblCountry; --14
select count(*) from tblCountry; --14
select count(name) from tblCountry; --14
select count(capital) from tblCountry; --14
select count(population) from tblCountry; --13
select count(name, population) from tblCountry;


-- 연락처가 있는 직원 수? 57
select count(*) from tblInsa;
select count(tel) from tblInsa;
select count(*) from tblInsa where tel is not null;

-- 연락처가 없는 직원 수? 3
select count(*) - count(tel) from tblInsa;
select count(*) from tblInsa where tel is null;

-- 어떤 부서들이 있나요? > 부서가 몇개?
select count(distinct buseo) from tblInsa;

-- tblComedian. 남자수? 여자수?
select * from tblComedian;

select count(*) from tblComedian where gender = 'm'; --8 
select count(*) from tblComedian where gender = 'f'; --2

--*** 자주 사용 패턴
-- 남자수와 여자수를 1개의 테이블로 가져오기
select
    count(
    case
        when gender = 'm' then '남자'
        --when gender = 'f' then '여자'
    end
    ),
    count(
    case
        --when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end
    )
from tblComedian;



select
    count(case
        when gender = 'm' then 1
    end),
    count(case
        when gender = 'f' then 1
    end)
from tblComedian;



--tblInsa. 기획부 몇명? 홍보부 몇명? 개발부 몇명? > 1개의 테이블
select count(*) from tblInsa where buseo = '기획부'; --7
select count(*) from tblInsa where buseo = '홍보부'; --6
select count(*) from tblInsa where buseo = '개발부'; --14

select
    count(case when buseo = '기획부' then 1 end) as 기획부,
    count(case when buseo = '홍보부' then 1 end) as 홍보부,
    count(case when buseo = '개발부' then 1 end) as 개발부,
    count(
        case
            when buseo not in ('기획부', '홍보부', '개발부') then 1
        end
    ) as 나머지부서
from tblInsa;




/*
    2. sum()
    - 해당 컬럼의 합을 구한다.
    - number sum(특정 컬럼명)
    - sum(*) > 사용 불가
    - 숫자형 컬럼에만 적용
*/
select * from tblCountry;
select sum(*) from tblCountry;
select sum(population) from tblCountry;
select sum(name) from tblCountry; --ORA-01722: 수치가 부적합합니다
select sum(ibsadate) from tblInsa; --ORA-00932: 일관성 없는 데이터 유형: NUMBER이(가) 필요하지만 DATE임

select
    sum(basicpay) as 지출급여합,
    sum(sudang) as 지출수당합,
    sum(basicpay) + sum(sudang) as 총지출,
    sum(basicpay + sudang) as 총지출
from tblInsa;


/*
    3. avg()
    - 해당 컬럼의 평균값 반환
    - number avg(특정 컬럼명)
    - avg(*) > 사용 불가
    - 숫자형 컬럼에만 적용
*/
-- tblInsa. 평균 급여?
select sum(basicpay) / 60 from tblInsa; --1556526
select sum(basicpay) / count(*) from tblInsa;
select avg(basicpay) from tblInsa;

-- tblCountry. 평균 인구수?
select sum(population) / 14 from tblCountry; --14475
select sum(population) / count(*) from tblCountry; --14475
select avg(population) from tblCountry; --15588
select sum(population) / 13 from tblCountry; --15588
select sum(population) / count(population) from tblCountry; --15588


-- 회사 > 성과급 지급 > 출처 > 1팀 공로~
-- 1. 균등 지급 > 총지급액 / 모든직원수 = sum() / count(*)
-- 2. 차등 지급 > 총지급액 / 1팀직원수 = sum() / count(1팀) = avg()

/*
    
    4. max()
        - 최댓값 반환
        - object max(특정 컬럼명)
    
    5. min()
        - 최솟값 반환
        - object min(특정 컬럼명)
        
    - 숫자형, 문자형, 날짜형 모두 적용 가능

*/

select max(basicpay), min(basicpay) from tblInsa;
select max(name), min(name) from tblInsa;
select max(ibsadate), min(ibsadate) from tblInsa;

select
    count(*) as 직원수,
    sum(basicpay) as 총급여합,
    avg(basicpay) as 평균급여,
    max(basicpay) as 최고급여,
    min(basicpay) as 최저급여
from tblInsa;


-- 집계 함수 사용 시 주의점!!!

-- 1. ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--               not a single-group group function
-- 컬럼 리스트(SELECT절)에서는 집계함수와 일반컬럼을 동시에 사용할 수 있다.

-- 요구사항] 직원들의 이름과 전체 직원 수를 가져오시오.
select name, count(*) from tblInsa;
select name, jikwi, sudang from tblInsa;
select count(*), avg(basicpay), sum(basicpay) from tblInsa;


select name from tblInsa;
select count(*) from tblInsa;


select name, jikwi, buseo, city from tblInsa;


-- 2. ORA-00934: 그룹 함수는 허가되지 않습니다
--               group function is not allowed her
-- where절에서는 절대로 집계 함수를 사용하지 못한다.
-- where절 특성 > 개인 데이터를 조작하는 영역(************)
--              > 집계함수 사용 불가

-- 요구사항] 평균 급여보다 더 많이 받는 직원들?
select avg(basicpay) from tblInsa; --1556526

-- 직원 1명 퇴사

select *                    --3.
from tblInsa                --1.
where basicpay > 1556526;   --2. 각 레코드에 대한 반복 탐색 + 조건 검사

select * from tblInsa where basicpay > avg(basicpay);










