-- ex32_plsql.sql

/*
    
     수업 진도
    
    1. 초반 DML (ex01 ~ ex12)
    2. DDL > 테이블
    3. 후반 DML
    ------------------------- ANSI-SQL
    4. 데이터 설계(모델링)
    5. 간단한 프로젝트: 1일 > 
    -------------------------
    6. PL/SQL
    ------------------------- PL/SQL
    7. DB 프로젝트: 4일
        - 주제: 쌍용 교육 센터 관리 시스템 > DB 구축
        - 팀: 랜덤


    PL/SQL
    1. 프로시저(변수, 제어문 등)
    2. 트리거
    3. 함수
    4. 인덱스 > 오늘 수업
    5. 기타 등등..
    
*/

/*

    인덱스, Index
    - 책: 인덱스(색인)
    - 검색을 빠른 속도로 하기 위해 사용하는 도구
    - 오라클의 인덱스 > B-Tree 구조
    - 검색할 컬럼값과 실제(테이블) 행 위치(ROWID) > 별도의 구조 저장 
    
    데이터베이스 > 데이터 검색 방식
    - 어떤 데이터를 검색 > 처음 ~ 끝까지 차례대로 검색 > Table Full Scan
    - 인덱스 사용: 특정 컬럼 선택 > 별도의 테이블(?) 복사 > 정렬 >> 인덱스(색인)
    
    *** 인덱스가 항상 좋은 것은 아니다.
        > 상황에 따라 좋을 수도 있고, 나쁠 수도 있다.
    
*/

-- 테스트용 데이터, CTAS
create table tblIndex
as
select
    level                                              as seq,
    'USER' || lpad(level, 7, '0')                     as user_id,
    '사용자' || lpad(mod(level, 10000), 4, '0')       as name,

    case
        when mod(trunc((level - 1) / 10), 1000) < 500 then '서울' -- 50%
        when mod(trunc((level - 1) / 10), 1000) < 700 then '경기' -- 20%
        when mod(trunc((level - 1) / 10), 1000) < 800 then '부산' -- 10%
        when mod(trunc((level - 1) / 10), 1000) < 880 then '인천' -- 8%
        when mod(trunc((level - 1) / 10), 1000) < 930 then '대전' -- 5%
        when mod(trunc((level - 1) / 10), 1000) < 998 then '광주' -- 6.8%
        else '제주'                                                -- 0.2%
    end                                                as hometown,

    case mod(level, 10)
        when 0 then '개발자'
        when 1 then '학생'
        when 2 then '회사원'
        when 3 then '자영업'
        when 4 then '공무원'
        when 5 then '교사'
        when 6 then '간호사'
        when 7 then '디자이너'
        when 8 then '영업'
        else '기타'
    end                                                as job,

    case
        when mod(level, 100) < 90 then 'ACTIVE' -- 약 90%
        when mod(level, 100) < 98 then 'REST'   -- 약 8%
        else 'QUIT'                              -- 약 2%
    end                                          as status,

    'user' || level ||
        case mod(level, 4)
            when 0 then '@naver.com'
            when 1 then '@gmail.com'
            when 2 then '@daum.net'
            else '@example.com'
        end                                            as email,
    date '2020-01-01' + mod(level, 2192)               as regdate,
    2500000 + mod(level * 7919, 7500000)               as salary,
    rpad('INDEX TEST ' || level, 200, '*')              as memo
from dual
connect by level <= 500000;

select count(*) from tblIndex; --500000

select * from tblIndex;


--** PK, Unique 제약을 만들면 > 해당 컬럼에 인덱스가 자동으로 생성된다.

--PK
alter table tblIndex
    add constraint tblindex_seq_pk primary key(seq);
    
--UQ
alter table tblIndex
    add constraint tblindex_user_id_uq unique(user_id);


/*
    SQL > 통계 정보
    
    오라클 > 옵티마이저 > SQL을 어떤 순서와 방법으로 실행할지 결정하는 기능
                         ex) 풀 스캔 or 인덱스 스캔
                         
    옵티마이저 판단 기준에 영향을 미치는 요소
    - 테이블에 행이 몇 건이 있는지?
    - 하나의 컬럼에 서로 다른 값이 몇 종류가 얼마나 있는지?
    - 특정 값에 데이터 몰려있는지?
    - 검색 대상(컬럼)에 인덱스가 존재하는지?
    
*/

begin
    dbms_stats.gather_table_stats(
        ownname => user,
        tabname => 'TBLINDEX',
        method_opt => 'FOR ALL COLUMNS SIZE AUTO',
        cascade => true
    );
end;
/




--지역별 인원수와 비율을 확인다.
--서울 많고, 제주 적음
select
    hometown, count(*) as person_count,
    round(count(*) / sum(count(*)) over() * 100, 2) as ratio
from tblIndex
    group by hometown
        order by person_count desc;


--직업별 분포
select
    job, count(*) as person_count
from tblIndex
    group by job
        order by job;


--회원 상태 분포
select
    status, count(*) as person_count
from tblIndex
    group by status
        order by status;


/*

    실행 계획
    - 오라클이 해당 SQL을 어떤 방식으로 실행할지?
    - 테이블을 어떻게 탐색하는지?
    
    explain plan
    - SQL을 실제로 실행하지 않고 오라클 예상한 실행 방법
    
    display_cursor + allstats last
    - display_cursor: SQL 영영에서 저장된 실행 계획을 출력하는 함수
    - allstats: 실행 계획 + 실제 실행 후 통계 > 함께 출력
    - last: 가장 마지막에 실행한 SQL만 가져와라~
    
    주요 항목
    - E-Rows: 오라클이 예상한 레코드 수, Estimated Rows
    - A-Rows: 실제 처리한 레코드 수, Actual Rows
    - Buffers: 메모리에서 읽은 데이터 블럭 수(데이터 블럭 = 레코드 집합)
    - TABLE ACCESS FULL: 테이블을 처음부터 끝까지 읽었다.(풀스캔)
    - INDEX RANGE SCAN: 인덱스 사용(여러개 검색)
    - INDEX UNIQUE SCAN: 인덱스 사용(1개 검색)
    - TABLE ACCESS BY INDEX ROWID: 인덱스에서 찾은 주소로 실제 테이블의 레코드를 검색

*/

--v$ 뷰
grant select any dictionary to hr;

set timing on; --SQL*Plus, SQL Developer

--힌트(/*+ gather_plan_statistics */) > A-Rows, Starts, Buffers 확인해달라
select /*+ gather_plan_statistics */
    seq, user_id, name, email, hometown, memo
from tblIndex
    where seq = 250000;

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));



/*

    일반 컬럼(PK,UQ X)을 검색하기
    1. 그냥 검색
    2. 인덱스 걸고 검색
    
    seq, user_id > 인덱스 자동 걸림
    name > 10,000 종류 반복 > 50개 결과 > 검색

*/

select count(distinct name) from tblIndex; --10,000

select /*+ gather_plan_statistics */
    seq, user_id, name, email, hometown, memo
from tblIndex
    where name = '사용자1234';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));


-- name으로 빠른 검색 > 인덱스 생성
create index idx_tblIndex_name on tblIndex(name);

-- 방금 인덱스를 옵티마이저가 확실하게 인식하라고
begin
    dbms_stats.gather_table_stats(
        ownname => user,
        tabname => 'TBLINDEX',
        cascade => true
    );
end;
/

select /*+ gather_plan_statistics */
    seq, user_id, name, email, hometown, memo
from tblIndex
    where name = '사용자1234';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));



/*
    
    선택도: 같은 인덱스도 검색값에 따로 효과가 다르다.
    
    500,000건 중 1,000건을 찾는 제주 조건은 결과 비율이 낮다.
    500,000건 중 250,000건을 찾는 서울 조건은 결과 비율이 높다.
    
*/
select /*+ gather_plan_statistics */
    count(*) as person_count,
    sum(length(memo)) as memo_length_sum
from tblIndex
    where hometown = '제주';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));



create index idx_tblIndex_hometown on tblIndex(hometown);

begin
    dbms_stats.gather_table_stats(
        ownname => user,
        tabname => 'TBLINDEX',
        method_opt => 'FOR COLUMNS SIZE 7 HOMETOWN',
        cascade => true
    );
end;
/

/*
    select 결과가 전체 데이터의 10~15% 이하면 인덱스가 유리하다.
*/


/*
     단순 인덱스
     - 인덱스를 만드는 사용한 컬럼이 1개
     
     복합 인덱스
     - 인덱스를 만드는 사용한 컬럼이 N개
     
*/
select /*+ gather_plan_statistics */
    seq, name, hometown, job, regdate
from tblIndex
    where hometown = '제주' and job = '학생' and regdate >= date '2025-01-01';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));


create index idx_tblIndex_home_job_date
    on tblIndex(hometown, job, regdate);


select /*+ gather_plan_statistics */
    seq, name, hometown, job, regdate
from tblIndex
    where job = '학생';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));





/*
    함수 기반 인덱스
*/
select /*+ gather_plan_statistics */
    seq, name, hometown, job, regdate
from tblIndex
    where user_id = 'USER0250000';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));



select /*+ gather_plan_statistics */
    seq, name, hometown, job, regdate
from tblIndex
    where upper(user_id) = 'USER0250000';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));


create index idx_tblIndex_upper_userid on tblIndex(upper(user_id));



select /*+ gather_plan_statistics */
    seq, name, hometown, job, regdate, email
from tblIndex
    where substr(email, instr(email, '@')) = '@naver.com';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));

create index idx_tblIndex_email on tblIndex(substr(email, instr(email, '@')));



/*
    
    인덱스 사용을 어렵게 만드는 SQL
    - WHERE 조건을 어떻게 만드느냐에 따라 효율/비효율
    
*/
select /*+ gather_plan_statistics */
    count(*)
from tblIndex
    where user_id like 'USER025%';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));


-- INDEX FAST FULL SCAN: 인덱스 검색(X) : 인덱스를 풀스캔(O)

select /*+ gather_plan_statistics */
    count(*)
from tblIndex
    where user_id like '%250000';

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));



create index idx_tblIndex_regdate on tblIndex(regdate);

select /*+ gather_plan_statistics */
    count(*)
from tblIndex
    where to_char(regdate, 'yyyy') = '2025'; --83220

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));



select /*+ gather_plan_statistics */
    count(*)
from tblIndex
    where regdate >= date '2025-01-01' and regdate < date '2026-01-01'; --83220

select * from table(dbms_xplan.display_cursor(null, null, 'ALLSTATS LAST'));

/*
    자료형도 일치시켜야 한다. > 인덱스 용이하게 사용
    
    where 문자컬럼 = 100; --암시적 형변환 //인덱스 안 탈 가능성 높음
    where 문자컬럼 = '100'; //인덱스 탈 가능성 높음
*/






/*

    from tblCustomer c
        inner join tblSales s
            on c.seq = s.cseq;
            on c.PK = s.FK;
            
    빈번하게 하는 조인 > 인덱스 사용 고려?      
    - create index idx_b_fk on tblSales(cseq);    

*/

----------------------------------------------

/*
    
    인덱스가 데이터 변경 작업에 주는 비용 확인
    
    insert, update, delete
    > 인덱스 갱신 비용 발생
    
    테이블
    1. 공지사항
        - 연당 글 10개
        - 조회수 100,000건 > 검색 빈번
    2. 문의사항
        - 연당 글 10,000개 > 수정/삭제 빈번
        - 조회수 50,000개
    
*/
commit;
rollback;

--1. memo > 인덱스 없는 상태 > 수정 > 00:00:01.669
update tblIndex set
    memo = rpad('MEMO CHANGED', 200, '*')
        where seq between 100001 and 300000;    

--2. 인덱스(memo) 생성
create index idx_tblIndex_memo on tblIndex(memo);
drop index idx_tblIndex_memo;

--3. memo > 인덱스 있는 상태 > 수정 > 경과 시간: 00:00:05.754
update tblIndex set
    memo = rpad('MEMO CHANGED', 200, '*')
        where seq between 100001 and 300000;      









/*

    인덱스를 고려할 상황    
    1. 테이블 데이터가 많다.
    2. WHERE 또는 JOIN(ON)서 자주 사용하는 컬럼이다.(*****)
    3. 조건에 맞는 결과 행이 전체 중 일부이다.(10~15%) ex)제주(*****)
    4. 날짜나 숫자 범위 검색을 자주한다.
    
    신중해야 할 상황
    1. 테이블이 작아서 전체를 읽어도 비용이 작은 경우.
    2. 조건에 맞는 결과 행이 너무 많다. ex)서울
    3. 값은 종류가 적은 경우.
    
*/














