-- ex02_datatype.sql

/*

    오라클 자료형
    - 변수(X), 제어문(X) > SQL은 프로그래밍 언어가 아니다.
    - 테이블 선언 > 컬럼에 적용
    
    1. 숫자형
        - 정수/실수
        a. number
            - (유효숫자)38개까지 표현
            - 1~22byte
            - 1x10^-130 ~ 9.9999x10^125
            - number: 정수/실수
            - number(precision): 전체 자릿수, 정수형
            - number(precision, scale): 소수이하 자릿수 > 정수형, 실수형
    
    2. 문자형 > varchar2
        - 문자 + 문자열 = String(Java)
        - char vs varchar > var의 의미?
        - char vs nchar > n의 의미?
        
        a. char
            - 고정 자릿수 문자열 > 공간(컬럼)의 크기 불변
            - char(n): 최대 n자리 문자열, n(바이트)
                - 최소 크기: 1바이트
                - 최대 크기: 2000바이트
            - 데이터 삽입 후 > 남은 공객을 공백 문자로 채운다. > 항상 10자리로 만든다.
            - 고정 문자열 > 전화번호, 우편번호, 이름
        
        b. nchar
            - n: national > 오라클 인코딩(UTF-8)과 상관없이 해당 컬럼을 UTF-16으로 적용
            - nchar(n): 최대 n자리 문자열, n(문자수)
                - 최소 크기: 1문자
                - 최대 크기: 1000문자
        
        c. varchar2(varchar)
            - 가변 자릿수 문자열 > 공간(컬럼)의 크기 가변
            - varchar2(n): 최대 n자리 문자열, n(바이트)
                - 최소 크기: 1바이트
                - 최대 크기: 4000바이트
            - 데이터 삽입 후 > 남은 공간을 버린다.(trim)
            - 가변 문자열 > 주소, 자기 소개
        
        d. nvarchar2
            - n: national > 오라클 인코딩(UTF-8)과 상관없이 해당 컬럼을 UTF-16으로 적용
            - nvarchar2(n): 최대 n자리 문자열, n(문자수)
                - 최소 크기: 1문자
                - 최대 크기: 2000문자
                
        e. clob, nclob
            - Character Large Object
            - 대용량 텍스트
            - 4TB
            - 느림
    
    3. 날짜/시간형 > date
        a. date
            - 년월일시분초
        
        b. timestamp
            - 년월일시분초 + 밀리초 + 나노초
        
        c. interval
            - 시간
            - 틱값
    
    4. 이진 데이터형
        - 비 텍스트 데이터
        - 이미지, 영상, 음악, 실행 파일, 압축 파일 등..
        - 잘 사용 안함
        ex) 게시판(+첨부파일) > DB에는 첨부파일의 이름을 저장(문자열)
        a. blob
        
    5. boolean
        - SQL(X)

    결론
    1. 숫자 > number
    2. 문자열 > varchar2
    3. 날짜/시간 > date



    DDL
    
    create table 테이블명 ( 
        컬럼 선언, 
        컬럼 선언, 
        컬럼 선언,
        컬럼명 자료형
    );
    
*/

-- 캐멀 표기법 + 헝가리언 표기법
drop table tblType;

create table tblType (
    --num number
    --num number(3) --3자리, -999 ~ +999
    --num number(4,2)--4자리(정수2자리, 소수2자리), -99.99 ~ +99.99
    
    --txt char(10) -- 10바이트 == 몇글자? > 인코딩(UTF-8) > 영어(1), 한글(3)
    --txt varchar2(10) -- 10바이트 == 몇글자? > 인코딩(UTF-8) > 영어(1), 한글(3)
    
    --txt1 char(10),
    --txt2 varchar2(10)
    
    txt nchar(10) --10글자
    
);

-- 테이블의 데이터 확인하기
select * from tblType;

-- 테이블에 데이터(행(row), 레코드(record)) 추가하기
-- insert into 테이블명 (컬럼명) values (값);
insert into tblType (num) values (100); --오라클의 정수형 리터럴
insert into tblType (num) values (3.14);--오라클의 실수형 리터럴
insert into tblType (num) values (3.56);--반올림(O)
insert into tblType (num) values (999);
insert into tblType (num) values (1000);
insert into tblType (num) values (-999);
insert into tblType (num) values (-1000);
insert into tblType (num) values (99.99);
insert into tblType (num) values (-99.99);
insert into tblType (num) values (99.999999);
insert into tblType (num) values (10);
insert into tblType (num) values (12345678901234567890123456789012345678);
insert into tblType (num) values (1234567890123456789012345678901234567890123456789);

select * from tblType;
insert into tblType (txt) values ('ABC'); --문자 리터럴
insert into tblType (txt) values ('ABCDEFGHIJ');
insert into tblType (txt) values ('ABCDEFGHIJK');
insert into tblType (txt) values ('홍길동');
insert into tblType (txt) values ('홍길동님');
insert into tblType (txt) values ('홍길동!');
insert into tblType (txt) values ('홍길동님안녕하세요요');
insert into tblType (txt) values ('홍길동님안녕하세요요.');

insert into tblType (txt1, txt2) values ('ABC', 'ABC');


insert into hr.tblType (hr.tblType.txt) values ('홍길동');





