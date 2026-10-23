-- ex06_column.sql

-- 컬럼 리스트에서 할 수 있는 행동들
-- select 컬럼리스트

-- 컬럼명
select name, jikwi, buseo from tblInsa;

-- 연산
select name || '님', sudang * 2 from tblInsa;

-- 상수
select name, 100 from tblInsa;

select 100 from tblInsa;

select 100 from tblCountry;

-- 함수(인풋+아웃풋)
select name, length(name) from tblCountry;


/*

    Java Stream > list.stream().distinct().forEach()

    distinct
    - 컬럼 리스트에서 사용
    - 레코드의 중복값 제거
    - distinct 컬럼명 > X
    - distinct 컬럼리스트 > O
    
*/

-- tblCountry
-- 각 나라의 대륙? > 개인 데이터
select name, continent from tblCountry;

-- tblCountry 테이블에서 어떤 대륙들이 있나요? > 어떤 종류? > 카테고리 > 집합 데이터
select continent from tblCountry;
select distinct continent from tblCountry;

-- 오라클의 동의어(distinct)
select unique continent from tblCountry; -- 사용 비추천

-- 기본값(all 생략)
select all continent from tblCountry;
select continent from tblCountry;

-- tblInsa
-- 이 회사는 어떤 부서들?
select distinct buseo from tblInsa;
select distinct jikwi from tblInsa;
select distinct name from tblInsa; --60명

select buseo, name from tblInsa;
select distinct buseo, name from tblInsa; --60명

select buseo, jikwi from tblInsa;
select distinct buseo, jikwi from tblInsa; --23

select distinct buseo, jikwi, city from tblInsa; --43


/*
    
    SQL > 제어문 없음
    
    case문
    - 조건문 역할
    - 컬럼값 조작
    - 자바: 다중 if문 or switch문
    - 조건 만족: then 값 반환
    - 조건 불만족: null 반환(***)

*/

select
    last || first as name,
    gender,
    
    -- 자바 다중 if문
    case
        --when 조건 then 값
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as gender_name,
    
    -- 자바 switch문
    case gender
        when 'm' then '남자'
        when 'f' then '여자'
    end as gender_name2    
from tblComedian;


select
    name, continent,
    case
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        --else '기타'
        --else continent
        --else name
        --else area
    end as continent_name
from tblCountry;


select
    last || first as name, weight,
    case
        when weight > 90 then '과체중'
        when weight > 50 then '정상체중'
        else '저체중'
    end as state,
    case
        when weight >= 50 and weight <= 90 then '정상'
        else '주의'
    end as state2,
    case
        when weight between 50 and 90 then '정상'
        else '주의'
    end as state3
from tblComedian;

select
    name, jikwi,
    case
        when jikwi = '사원' or jikwi = '대리' then '현장직'
        when jikwi = '과장' or jikwi = '부장' then '관리직'
    end,
    name, jikwi,
    case
        when jikwi in ('사원', '대리') then '현장직'
        when jikwi in ('과장', '부장') then '관리직'
    end
from tblInsa;

select
    name, ssn,
    case
        when ssn like '%-1%' then '남자직원'
        when ssn like '%-2%' then '여자직원'
    end
from tblInsa;

select
    title,
    case
        when completedate is null then '미완료'
        when completedate is not null then '완료'
    end
from tblTodo;





















