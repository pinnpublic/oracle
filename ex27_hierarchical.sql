-- ex27_hierarchical.sql

/*
    계층형 쿼리, Hierarchical Query
    - 오라클 전용 쿼리
    - 레코드의 관계가 서로 상하관계인 테이블을 조회
    - 자기 참조를 하는 경우에 발생
    
    구문
    1. start with절
    2. connect by절
    3. 의사 컬럼
        - prior: 부모테이블의 레코드
        - level
        - 함수들..
    
*/
select * from tblSelf;

select
    seq as 직원번호,
    lpad(' ', level * 3) || name as 직원명,
    boss as 상사번호,
    prior name as 상사명,
    level,
    
    connect_by_root name as 사장,
    connect_by_isleaf,
    sys_connect_by_path(name, '>')
    
from tblSelf
    start with seq = 1
        connect by prior seq = boss;




select
    직원.name,
    상사.name
from tblSelf 상사
    inner join tblSelf 직원
        on 상사.seq = 직원.boss;


----------------------------------------- ANSI-SQL
















