-- ex04_operator.sql

/*

    연산자, Operator
    - 컬럼 조작
    
    1. 산술 연산자
    - +, -, *, /
    - %(없음) > 함수 제공(mod())
    
    2. 문자열 연산자
    - ||
    
    3. 비교 연산자
    - >, >=, <, <=
    - =(==), <>(!=)
    - 논리값 반환 > boolean 없음
        3.1 조건 상황 존재 > 내부적으로는 참/거짓 판단 가능
        3.2 논리 상태를 표현 불가능
    - 조건절에서 많이 사용
    
    4. 논리 연산자
    - and(&&), or(||), not(!)
    - 논리값 반환 > boolean 없음
    - 조건절에서 많이 사용
    
    5. 대입 연산자
    - =
    - update문
        - 컬럼 = 값
    - 복합 대입 연산자(+=, -=..) 없음
    - num += 1 //X
    - num++ //X
    - num = num + 1 //O
    
    6. 3항 연산자
    - 없음
    - 제어문 없음
    
    7. 증감 연산자
    - 없음
    
    8. SQL 연산자
    - 자바 > instanceof
    - SQL > in, between, like, is 등.. //연산자, 조건(Condition) > 표준(Predicate)
    
    *** 연산 시 주의점
    
        
*/
select *            -- 2. 가져올 컬럼 지정
from tblCountry;    -- 1. 테이블 지정


select
    population,
    area,
    population + 10,
    population - 10,
    population * 10,
    population / 10,
    area / population -- 1인당 국가 면적
from tblCountry;

select
    name, capital,
    --name + capital --ORA-01722: 수치가 부적합합니다
    name || capital,
    name || '(' || capital || ')'
from tblCountry;

select
    area > 100
from tblCountry;

select *
from tblCountry
where area > 100;


select *
from tblCountry
where (continent = 'AS') and (area < 100);



--** 대다수 언어의 모든 연산자는 피연사자로 null을 가질 수 없다.
-- 10 + 0 = 10
-- 10 + null = null(연산 불가능)

-- if (obj == null)

select
    population,
    population + 100
from tblCountry;





--------------------------------------------

/*
    
    컬럼명 바꾸기
    1. (원본)테이블의 컬럼명을 실제로 수정하기
    2. select 실행 후 > 결과 테이블(Result Table), 결과셋(ResultSet)
                      > 결과셋의 컬럼명을 수정하기
                      > 원본 테이블에는 영향을 주지 않는다.
    
    테이블명/컬럼명 > 별칭(Alias)
    - 별칭은 원본명과 동시에 사용될 수 없다.
    - 별칭을 붙이는 순간 개명(*****), 원본명은 사용이 불가능
    
    
    컬럼 별칭
    - 결과셋의 컬럼명을 바꾼다.
    - 결과셋의 컬럼명을 올바르게 유지
    1. 컬럼명이 중복될 때
    2. 컬럼을 가공했을 때
    
    테이블 별칭
    - SQL 작성 시 간결하게 하려고
    
    
    *** 하나의 테이블내에 같은 컬럼명이 2개 이상
    1. 물리적 (DB에 저장된, 원본) 테이블 > 불가능
    2. 결과셋 > 가능
    3. 결과셋 > 재사용 > 불가능
    결론 > 무조건 컬럼명을 유일하게(+별칭)
    
*/
create table tblType2 ( -- select num from tblType2;
    num number,
    num number
);


select
    name as 국가명,
    capital as 수도명
from tblCountry;

select
    name,
    capital
from tblCountry;

select
    name,
    population,
    area,
    area / population as aaa
from tblCountry;


select name from tblMen;
select name from tblWomen;

-- ORA-00904: "NAME_1": 부적합한 식별자(오타)
-- ORA-00918: 열의 정의가 애매합니다
select
    tblMen.name as men, --남자명
    --name_1 --여자명
    tblWomen.name as womwn --여자명
from tblMen inner join tblWomen
    on tblMen.couple = tblWomen.name;

select
    name, name
from tblCountry;


-- ORA-00918: 열의 정의가 애매합니다
-- 니가 만든 결과셋에 동일한 컬럼명이 2개 이상 있네!!
select * from
    (select
        name, 
        name as name2
    from tblCountry);




-- hr.tblCountry > hr 생략 이유? > 현재 접속한 유저가 hr이라서
-- tblCountry.name > tblCountry 이유? > select의 각절의 실행 순서때문

select name, capital
from tblCountry; --1. 먼저 실행

select hr.tblCountry.name, hr.tblCountry.capital from hr.tblCountry;

-- 테이블 별칭 > 간결하게 하기 위해서(********************)
select c.name, c.capital from tblCountry c;

select tblCountry.name, tblCountry.capital 
from tblCountry c; -- 각절의 순서, 별칭의 동작 방식

select c.name, c.capital 
from tblCountry;










