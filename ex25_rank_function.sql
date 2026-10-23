-- ex25_rank_function.sql

/*

    순위 함수(윈도우 함수)
    - rownum을 기반으로 만들어진 함수
    
    1. rank() over(order by 컬럼명 [asc|desc])
    
    2. dense_rank() over(order by 컬럼명 [asc|desc])
    
    3. row_number() over(order by 컬럼명 [asc|desc])
        - rownum을 직접 사용했을 때와 동일

*/
--tblInsa. 급여순으로 가져오시오 + 순위 표시

--rownum
--1. 내가 원하는 정렬
--2. 1번 인라인뷰 > 메인 쿼리(+rownum)
--3. 2번의 rownum > rnum > 메인 쿼리
select * from
    (select
        a.*, rownum as rnum
    from (select name, basicpay from tblInsa order by basicpay desc) a)
where rnum = 10;


select
    name, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa;

select
    name, basicpay,
    dense_rank() over(order by basicpay desc) as rnum
from tblInsa;

select
    name, basicpay,
    row_number() over(order by basicpay desc) as rnum
from tblInsa;




--1위?
select
    name, basicpay,
    row_number() over(order by basicpay desc) as rnum
from tblInsa
    where row_number() over(order by basicpay desc) = 1;


select * from
    (select
        name, basicpay,
        row_number() over(order by basicpay desc) as rnum
    from tblInsa)
        where rnum = 5;

-----------------------------------------------------------

-- partition by buseo == group by 역할
select
    name, buseo, jikwi, basicpay,
    rank() over(partition by buseo, jikwi order by basicpay desc) as rnum
from tblInsa;








