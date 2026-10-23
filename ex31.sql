-- ex31.sql
/*
    
    근태(출결) 관리
    - 근태 상태 관리(정상, 지각, 조퇴)
    - 2026월 8월 > 한달분 데이터(1~31)
    - 달력 > 출력
    
*/
--근태 테이블
create table tblDate (
    seq number primary key,     --PK
    state varchar2(30) not null,--정상|지각|조퇴
    regdate date not null       --날짜
    --student_seq number references tblStudent(seq)
);

--5.1: 노동자
--insert into tblDate values (1, '', '2026-05-');

--5.2: 토요일
--5.3: 일요일

insert into tblDate values (2, '정상', '2026-05-04');
--insert into tblDate values (3, '', '2026-05-05');
insert into tblDate values (4, '정상', '2026-05-06');
insert into tblDate values (5, '지각', '2026-05-07');
insert into tblDate values (6, '정상', '2026-05-08');

--5.9: 토요일
--5.10: 일요일

insert into tblDate values (7, '정상', '2026-05-11');
insert into tblDate values (8, '조퇴', '2026-05-12');
insert into tblDate values (9, '정상', '2026-05-13');
--결석
--insert into tblDate values (10, '', '2026-05-14');
insert into tblDate values (11, '정상', '2026-05-15');

--5.16: 토요일
--5.17: 일요일

insert into tblDate values (12, '정상', '2026-05-18');
insert into tblDate values (13, '정상', '2026-05-19');
insert into tblDate values (14, '지각', '2026-05-20');
insert into tblDate values (15, '정상', '2026-05-21');
insert into tblDate values (16, '정상', '2026-05-22');

--5.23: 토요일
--5.24: 일요일

--대체 휴일
--insert into tblDate values (17, '', '2026-05-25');
insert into tblDate values (18, '정상', '2026-05-26');
--결석
--insert into tblDate values (19, '', '2026-05-27');
insert into tblDate values (20, '정상', '2026-05-28');
insert into tblDate values (21, '정상', '2026-05-29');

--5.30: 토요일
--5.31: 일요일

select * from tblDate;

--근태 조회 > select
--*** 5월 1일 ~ 5월 31일 > 모든 날짜와 함께 근태 상황
--기록이 남아있는 날짜 + 없는 날짜

--1. ANSI-SQL
--2. PL/SQL
--3. Java


--1. 2026년 5월 1일 ~ 2026년 5월 31일 > 날짜 데이터 생성하기
--ANSI-SQL > 반복문(X) > 계층형 쿼리: 일련번호 생성용

select
    level,
    sysdate + (level - 1)
from dual
    connect by level <= 10;


create or replace view vwDate
as
select
    to_date('2026-05-01', 'yyyy-mm-dd') + (level - 1) as regdate
from dual
    connect by level <= 31;
 

select * from vwDate;  --5월 한달 날짜(regdate)
select * from tblDate; --5월 한달 근태(seq, state, regdate)


select
    v.regdate,
    d.state
from vwDate v
    left outer join tblDate d    
        on v.regdate = d.regdate
            order by v.regdate;

--주말(토,일)
select
    v.regdate,
    --d.state,
    --to_char(v.regdate, 'dy')
    case
        when to_char(v.regdate, 'dy') in ('토', '일') then '주말'
        else d.state
    end as state
from vwDate v
    left outer join tblDate d    
        on v.regdate = d.regdate
            order by v.regdate;


--공휴일 > 공식/패턴 없음
create table tblHoliday (
    seq number primary key,
    regdate date not null,
    name varchar2(50) not null
);

insert into tblHoliday values (1, '2026-05-01', '노동절');
insert into tblHoliday values (2, '2026-05-05', '어린이날');
insert into tblHoliday values (3, '2026-05-25', '석가탄신일');

select * from tblHoliday;



select
    v.regdate,
    case
        when to_char(v.regdate, 'dy') in ('토', '일') then '주말'
        when h.seq is not null then h.name
        when h.seq is null and d.seq is null then '결석'
        else d.state
    end as state
from vwDate v
    left outer join tblDate d    
        on v.regdate = d.regdate
            left outer join tblHoliday h
                on v.regdate = h.regdate           
                    order by v.regdate;










