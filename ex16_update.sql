-- ex16_update.sql

/*
    update문
    - 원하는 행의 원하는 컬럼값으로 수정하는 명령어
    
    구문
    update 테이블명 set 컬럼명=값 [,컬럼명=값] x N [where 절]

*/
commit;
rollback;

select * from tblCountry;

--대한민국: 서울 > 세종
update tblCountry set capital = '세종'; --모든 레코드 대상
update tblCountry set capital = '세종' where name = '대한민국';

update tblCountry set
            capital = '제주',
            population = 5000,
            area = 20
                where name = '대한민국';


select * from tblMemo;

-- 내가 원하는 레코드(1개) 검색 > PK 컬럼을 조건으로 사용(***********)

update tblMemo set memo = '새로운 메모' where 내가원하는메모를어떻게찾을까?

update tblMemo set memo = '새로운 메모' where seq = 3; --O > PK(*****)
update tblMemo set memo = '새로운 메모' where name = '홍길동'; --X
update tblMemo set memo = '새로운 메모' where memo is null; --X










