-- ex17_delete.sql

/*
    delete문
    - 원하는 행을 삭제하는 명령어
    - 컬럼 삭제? > 해당 컬럼의 값을 삭제 > update
    
    delete [from] 테이블명 [where절]

*/
commit;
rollback;

select * from tblCountry;

delete from tblCountry where 중국?
delete from tblCountry where name = '중국';
delete from tblCountry where continent = 'AS';
delete from tblCountry; --테이블 모든 데이터 삭제


-- DML
-- select 일부
-- insert 전부
-- update 전부
-- delete 전부





