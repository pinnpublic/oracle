-- ex30_relationship.sql

/*
    1. 기본키
        a. 단일키
        b. 복합키
        
    2. 관계
        a. 비식별 관계
        b. 식별 관계
    
    
    회원 테이블 : 게시판 테이블
    단일키(PK) > 1:N > 비식별관계
    
    회원 테이블 : 회원 상세 테이블
    단일키(PK) > 1:1 > 식별관계
    
*/
drop table tblUser;

--회원 테이블
create table tblUser (
    seq number primary key,
    id varchar2(30) unique not null,
    pw varchar2(30) not null,
    name varchar2(30) not null
);

--게시판 테이블
create table tblBoard (
    seq number primary key,
    subject varchar2(1000) not null,
    content varchar2(4000) not null,
    regdate date default sysdate not null,
    user_seq number not null references tblUser(seq)
);

--회원 상세 테이블
--1:1
--식별관계
create table tblUserDetails (
    seq number,
    tel varchar2(15) not null,
    email varchar2(50) not null,
    address varchar2(100) not null,
    
    constraint tbluserdetails_seq_pk primary key(seq),
    constraint tbluserdetails_seq_fk foreign key(seq) references tblUser(seq)
);

--tblUser                     tblUserDetails
--1, hong, 홍길동             1, 010, 서울시, hong@email.com
--                          





--학생 : 과목 : 수강
create table tblStudent (
    seq number primary key,
    name varchar2(30) not null
);

create table tblSubject (
    seq number primary key,
    name varchar2(30) not null
);

--테이블에는 하나의 기본 키만 가질 수 있습니다.
--복합키 선언: 컬럼수준(X), 테이블/외부(O)
create table tblRegistration (
    student_seq number not null,
    subject_seq number not null,
    score number not null,
    
    constraint tblregistration_student_seq_pk 
                    primary key(student_seq, subject_seq),
    constraint tblregistration_student_seq_fk
                    foreign key(student_seq) references tblStudent(seq),
    constraint tblregistration_subject_seq_fk
                    foreign key(subject_seq) references tblSubject(seq)                
);

insert into tblStudent values (1, '홍길동');
insert into tblStudent values (2, '강아지');
insert into tblStudent values (3, '고양이');

insert into tblSubject values (1, '자바');
insert into tblSubject values (2, '오라클');
insert into tblSubject values (3, '스프링');

insert into tblRegistration values (1, 1, 0);
insert into tblRegistration values (1, 2, 0);
insert into tblRegistration values (1, 3, 0);
insert into tblRegistration values (2, 1, 0);
insert into tblRegistration values (2, 2, 0);
insert into tblRegistration values (3, 2, 0);
insert into tblRegistration values (3, 3, 0);

--점검

--홍길동 + 자바 > 점수?
--홍길동 > 어떤 과목?
--자바 > 수강 신청 학생?

--홍길동(tblStudent) + 자바(tblSubject) > 점수(tblRegistration)?

select seq from tblStudent where name = '홍길동';
select seq from tblSubject where name = '자바';

select score from tblRegistration
    where student_seq = (select seq from tblStudent where name = '홍길동')
        and subject_seq = (select seq from tblSubject where name = '자바');

select r.score from tblStudent st
    inner join tblRegistration r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq
                    where st.name = '홍길동' and sj.name = '자바';

--홍길동 > 어떤 과목?
select sj.name from tblStudent st
    inner join tblRegistration r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq
                    where st.name = '홍길동';

select name from tblSubject
    where seq in (select subject_seq from tblRegistration 
        where student_seq = (select seq from tblStudent where name = '홍길동'));
    
select subject_seq from tblRegistration 
    where student_seq = (select seq from tblStudent where name = '홍길동');

select seq from tblStudent where name = '홍길동';


--보충수업 테이블
create table tblExtra (
    seq number primary key,
    regdate date not null,
    student_seq number, --references tblRegistration(student_seq),
    subject_seq number, --references tblRegistration(subject_seq)
    
    constraint tblextra_fk foreign key(student_seq, subject_seq) 
        references tblRegistration(student_seq, subject_seq)
);

insert into tblExtra values (1, sysdate, 1, 1);
insert into tblExtra values (2, sysdate + 1, 1, 2);

--홍길동 > 어떤 과목명 + 언제 보충 수업?
select 
    sj.name as 과목명,
    to_char(ex.regdate, 'yyyy-mm-dd') as 보충수업일
from tblStudent st
    inner join tblRegistration r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq
                    inner join tblExtra ex
                        on r.student_seq = ex.student_seq
                            and r.subject_seq = ex.subject_seq;


















