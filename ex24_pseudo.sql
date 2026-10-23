-- ex24_pseudo.sql

/*

    의사 컬럼, Pseudo Column
    - 실제 컬럼은 아닌데 컬럼처럼 행동하는 객체
    
    rownum
    - 행번호
    - 테이블의 레코드 행번호를 가져오는 역할
    - 오라클 전용
    
*/
select
    name, buseo, rownum
from tblInsa;



select name, buseo, rownum from tblInsa where rownum = 1;
select name, buseo, rownum from tblInsa where rownum <= 5;

select name, buseo, rownum from tblInsa where rownum = 5;
select name, buseo, rownum from tblInsa where rownum >= 6 and rownum <= 10;


/*
    rownum의 동작 방식
    - rownum이 언제 만들어지는지!!!!!!!!
    1. from절이 실행될 때
    2. where절에 의해서 결과셋에 변화가 생길 때
    
*/
select name, buseo, rownum --2.
from tblInsa;               --1. rownum 생성

select name, basicpay, rownum   --2.
from tblInsa                    --1. rownum 생성
order by basicpay desc;         --3.


select 
    name, basicpay, rnum, rownum
from (select name, basicpay, rownum as rnum
               from tblInsa
               order by basicpay desc) where rownum = 5; 




select 
    name, basicpay, rnum, rownum
from (select 
         name, basicpay, rownum as rnum
      from (select name, basicpay from tblInsa order by basicpay desc))
where rnum between 21 and 30;
   
-- 페이징   
-- 1~10
-- 11~20
-- 21~30

/*
    
    순위와 관련된 작업
    1. rownum
    2. 순위 함수(윈도우) > 편하게
    3. offset fetch > 12c 버전 이후 도입

*/






               
               
               
               
