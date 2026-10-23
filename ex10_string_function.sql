-- ex10_string_function.sql

/*
    문자열 함수
    
    대소문자 변환
    - upper(), lower(), initcap()
    - varchar2 upper(컬럼명)
    - varchar2 lower(컬럼명)
    - varchar2 initcap(컬럼명)
*/
select
    'aBcDeF',
    upper('aBcDeF'),    --ABCDEF
    lower('aBcDeF'),    --abcdef
    initcap('aBcDeF')   --Abcdef
from dual;

-- 이름에 'an' 포함된 사람?
select first_name
    from employees
        where first_name like '%an%';

select first_name
    from employees
        where first_name like '%an%'
            or first_name like '%An%'
            or first_name like '%aN%'
            or first_name like '%AN%';


select first_name
    from employees
        where upper(first_name) like '%AN%';



/*
    문자열 추출 함수
    - substr()
    - varchar2 substr(컬럼명, 시작위치, 가져올 문자 개수)
    - varchar2 substr(컬럼명, 시작위치)
*/
select
    name,
    substr(name, 1, 3),
    substr(name, 2),
    substr(name, -3)
from tblCountry;


select
    name, ssn,
    substr(ssn, 8, 1),
    case substr(ssn, 8, 1)
        when '1' then '남자'
        when '2' then '여자'
    end
from tblInsa;

-- tblInsa > 60명 > 김, 이, 박, 최, 정 > 각각 몇명?
-- 1. SQL x 5번
-- 2. SQL x 1번
select name from tblInsa;

select count(*) from tblInsa where substr(name, 1, 1) = '김'; --12
select count(*) from tblInsa where substr(name, 1, 1) = '이'; --14
select count(*) from tblInsa where substr(name, 1, 1) = '박'; --2
select count(*) from tblInsa where substr(name, 1, 1) = '최'; --1
select count(*) from tblInsa where substr(name, 1, 1) = '정'; --5

-- case + count
select
    count(case when substr(name, 1, 1) = '김' then 1 end) as 김,
    count(case when substr(name, 1, 1) = '이' then 1 end) as 이,
    count(case when substr(name, 1, 1) = '박' then 1 end) as 박,
    count(case when substr(name, 1, 1) = '최' then 1 end) as 최,
    count(case when substr(name, 1, 1) = '정' then 1 end) as 정,
    count(
        case
            when substr(name, 1, 1) not in ('김', '이', '박', '최', '정') then 1
        end
    ) as 나머지
from tblInsa;



/*
    문자열 길이
    - number length(컬럼명)
*/
select name, length(name) from tblCountry;

-- 대부분의 함수는 값을 사용하는 곳에 적용이 가능하다.
-- 1. SELECT절에서 사용
select name, length(name) from tblCountry;

-- 2. WHERE(조건절)에서 사용
select name, length(name) 
    from tblCountry
        where length(name) = 2;

select 
    name, 
    length(name) as name_length     --3.
from tblCountry                     --1.
    where name_length = 2;          --2.

--3. 정렬에서 사용
select 
    name, length(name) 
from tblCountry
    order by length(name) desc;

select 
    name, 
    length(name) as name_length     --2.
from tblCountry                     --1.
    order by name_length desc;      --3.


/*
    문자열 검색
    - instr() == indexOf() + lastIndexOf()
    - 검색어의 위치를 반환
    - number instr(컬럼명, 검색어)
    - number instr(컬럼명, 검색어, 시작위치)
    - number instr(컬럼명, 검색어, 시작위치, -1) //lastIndexOf()
    - 못찾으면 0을 반환
*/
select
    '안녕하세요. 홍길동님',
    instr('안녕하세요. 홍길동님', '홍길동') as r1,
    instr('안녕하세요. 홍길동님', '아무개') as r2,
    instr('안녕하세요. 홍길동님. 홍길동님. 홍길동님', '홍길동') as r3,
    instr('안녕하세요. 홍길동님. 홍길동님. 홍길동님', '홍길동', 11) as r4,
    instr('안녕하세요. 홍길동님. 홍길동님. 홍길동님', '홍길동', instr('안녕하세요. 홍길동님. 홍길동님. 홍길동님', '홍길동') + 3) as r5,
    instr('안녕하세요. 홍길동님. 홍길동님. 홍길동님', '홍길동', -1) as r6
from dual;



/*
    패딩
    - lpad(), rpad()
    - left padding, right padding
    - varchar2 lpad(컬럼명, 개수, 문자)
    - varchar2 rpad(컬럼명, 개수, 문자)
*/
select
    'A',
    lpad('A', 5), -- '    A' > printf("%5s")
    rpad('A', 5), -- 'A    ' > printf("%-5s")
    lpad('A', 5, 'B'), -- 'BBBBA'
    lpad('1', 5, '0')  -- '00001'
from dual;

/*
    공백 제거
    - trim(), ltrim(), rtrim()
    - varchar2 trim(컬럼명)
    - varchar2 ltrim(컬럼명)
    - varchar2 rtrim(컬럼명)
*/
select
    trim('     하나     둘     셋     '),
    ltrim('     하나     둘     셋     '),
    rtrim('     하나     둘     셋     ')
from dual;


/*
    문자열 치환
    - replace()
    - varchar2 replace(컬럼명, 찾을문자열, 바꿀문자열)
    - regexp_replace(컬럼명, 정규표현식, 바꿀문자열)
*/
select
    replace('홍길동', '홍', '김'),
    replace('홍길동', '최', '김'),
    replace('홍길홍', '홍', '김')
from dual;


select
    name, tel,
    regexp_replace(name, '김[가-힣]{2}', '김OO') as r1,
    regexp_replace(name, '([가-힣])[가-힣]{2}', '\1OO') as r2,
    regexp_replace(tel, '(\d{3})-\d{4}-(\d{4})', '\1-XXXX-\2') as r3
from tblInsa;

-- 김정훈 > 김OO
-- 011-2356-4528 > 011-XXXX-4528


-- 문자열 자르기 > split() 없음

/*
    문자열 치환
    - decode()
    - replace() 유사
    - varchar2 decode(컬럼명, 찾을문자열, 바꿀문자열)
    - varchar2 decode(컬럼명, 찾을문자열, 바꿀문자열 [, 찾을문자열, 바꿀문자열] x N)
*/
select
    last || first as name, 
    gender,
    case
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as g1,
    replace(replace(gender, 'm', '남자'), 'f', '여자') as g2,
    decode(gender, 'm', '남자', 'f', '여자') as g3
from tblComedian;










