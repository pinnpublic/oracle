-- ex34_동시성.sql

/*
    
    어떤 업무 > DB단 or 응용프로그램단 > 되도록 DB에서 해결 > 먼저 해결

    동시성 처리 방식(DB단 or 응용프로그램단)
    1. ANSI-SQL
    2. PL/SQL
    3. 자바
    
    
    
    ANSI-SQL 기반 동시성 처리 방법
    
    1. 원자적 DML
    2. 낙관적 잠금 > 낙관적 락
    --------------------------
    3. 제약 조건
    --------------------------
    4. 트랜잭션 격리 수준 제어
    
*/

-- 1. 원자적 DML > 원자적 조건부 갱신

-- tblProduct(상품)

-- stock: 재고 수량
-- 홍길동 상품 구매 > 조회 > 1개
select stock from tblProduct where seq = 1;

-- 아무개 상품 구매 > 조회 > 1개
select stock from tblProduct where seq = 1;

-- 동시성 문제 발생!!! > 남아있는 수량이 1개인데 2명이 동시 구매

-- 홍길동 > 구매
update tblProduct set stock = stock - 1 where seq = 1; --자동으로 Lock

-- 아무개 > 구매
update tblProduct set stock = stock - 1 where seq = 1;


-- 해결
-- 재고를 동시에 확인하면서 구매 같이 진행
update tblProduct set 
    stock = stock - 1 
        where seq = 1 and stock > 0;





/*
    
    2. 낙관적 잠금 > 낙관적 락
    - 테이블 수정
    - 사용자가 값을 조회 후 다른 트랜잭션이 값을 수정했는지 확인하는 방법
    
*/
create table tblProduct (
    seq number primary key,
    stock number not null,
    --..
    version_no number default 0 not null
);

-- 홍길동 > 조회 > version_no 기억
select stock, version_no from tblProduct where seq = 1;

-- 구매
update tblProduct set 
    stock = stock - 1,
    version_no = version_no + 1
        where seq = 1 and version_no = 0;

--1, 마우스, 0, 1
--2, 키보드, 10, 0









-- 비관적 락
select stock from tblProduct where seq = 1 for update; --자동으로 락

update tblProduct set stock = stock - 1 where seq = 1;

commit;


-- 낙관적 락 > 충돌 발생할 확률이 적다고 예상 > 마지막 update를 하는 순간 점검하는 방식
-- 비관적 락 > 충돌 발생할 확률이 높다고 예상 > 처음에 조회할때 부터 락을 거는 방식













