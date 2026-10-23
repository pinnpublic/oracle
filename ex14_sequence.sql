-- ex14_sequence.sql

/*
    시퀀스, Sequence
    - DB Object(테이블, 제약사항, 시퀀스 등)
    - DB Object > 생성/수정/삭제 > DDL(create, drop, alter)
    - 일련 번호를 생성하는 객체(***)
    - 오라클 전용
    - 주로 식별자를 만드는데 사용(PK)
    
    시퀀스 객체 생성하기
    - create sequence 시퀀스명;
    
    시퀀스 객체 삭제하기
    - drop sequence 시퀀스명
    
    시퀀스 객체 사용하기
    - 시퀀스명.nextVal
    - 시퀀스명.currVal
    
*/

create sequence seqNum;

select seqNum.nextVal from dual;



create sequence seqMemo;

insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모입니다.메모입니다.', sysdate);

select * from tblMemo;


select seqMemo.nextVal from dual; --pop()

-- ORA-08002: 시퀀스 SEQMEMO.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다
select seqMemo.currVal from dual; --peek()



------------------------

/*

    시퀀스 객체 생성하기
    - create sequence 시퀀스명;
    
    - create sequence 시퀀스명 
                        increment by n  --증감치
                        start with n    --시작값
                        maxvalue n      --최댓값
                        minvalue n      --최솟값
                        cycle           --순환구조
                        cache n;        --캐시

*/
drop sequence seqTest;
create sequence seqTest;

select seqTest.nextVal from dual; --공회전

insert into tblMemo (seq, name, memo, regdate)
    values (seqTest.nextVal, '홍길동', '메모입니다.메모입니다.', sysdate);

select * from tblMemo;




drop sequence seqTest;

create sequence seqTest
            --increment by -1
            --start with 11;
            --maxvalue 10
            --minvalue -10;
            --cycle
            cache 20;

-- 정전
select seqTest.nextVal from dual; --5 > 6 > 10 > 11 or 21(?)


select * from tblComedian;












