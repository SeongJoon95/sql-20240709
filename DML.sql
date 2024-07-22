USE practice_sql;

-- 데이터 조작어 (DML)
-- 테이블에 레코드를 삽입, 조회, 수정, 삭제 할때 사용0
-- 레코드 : 여러 가지 데이터 타입을 가질 수 있는 복합형 구조의 데이터 타입


-- INSERT : 테이블에 레코드를 삽입하는 명령어
-- INSERT --
-- 1. 모든 컬럼에 대하여 삽입
-- INSERT INTO 테이블명 VALUES(데이터1, 데이터2, ...);
-- 테이블 구조의 컬럼 순서에 맞게 모든 데이터를 입력해야함
INSERT INTO example_table VALUES('데이터1','데이터2');

-- 2. 특정 컬럼을 선택하여 삽입
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2,...) VALUES (데이터1, 데이터2, ...)
-- 지정한 컬럼의 순서와 데이터의 순서가 일치해야함
INSERT INTO example_table(column1) VALUES('안성준');
insert into example_table(example_column2) values ('30');

-- SELECT --
-- 테이블에서 레코드를 조회'할 때 사용하는 명령어
-- 1. 모든 데이터 조회
-- SELECT * FROM 테이블명;
select * from example_table;

-- 2. 특정 컬럼 선택 조회
-- SELECT 컬럼명1, 컬럼명2, ... FROM 테이블명;
select column1 from example_table;

-- 3. 특정 레코드 선택 조회
-- SELECT 조회할컬럼 FROM 테이블명 WHERE 조건;
SELECT * FROM example_table WHERE column1 = '안성준';


-- UPDATE -- 
-- 테이블에서 레코드를 수정할 때 사용하는 명렁어
-- UPDATE 테이블명 SET 컬럼명1 = 데이터1, ...; // 전체수정시
UPDATE example_table SET column1 = '수정데이터';

-- UPDATE 테이믈병 SET 컬럼명1 = 데이터1, ... WHERE 조건; // 조건에 해당하는부분만 수정시
UPDATE example_table SET column1 = '선택 수정 데이터' WHERE column1 = '수정데이터';

-- DELETE --
-- 테이블에서 레코드를 삭제할 때 사용하는 명령어
-- DELETE FROM 테이블명 WHERE  조건;
DELETE from example_table WHERE column1 = '데이터1';

-- DELETE FROM 테이블명
DELETE FROM example_table;

CREATE TABLE auto_table(
	idx INT PRIMARY KEY AUTO_INCREMENT,
    num INT
);

select * from auto_table;

insert into auto_table (num) values (0);

-- 레코드만 초기값으로 돌림
delete from auto_table;
delete from example_table;
-- primary key 값을 제거해준다.
-- 데이터 테이블의 구조를 처음으로 돌려줌
truncate table auto_table;

-- DROP TABLE : DDL 테이블 구조 전체를 제거
-- TRUNCATE TABLE : DDL 테이블 구조만 남기고 상태를 초기화alter
-- DELETE FROM : DML 테이블 레코드만 제거

-- INSERT INTO SELECT : 삽입 작업시에 조회 결과를 사용하여 삽입
INSERT INTO example_table 
select * from example_table 
where column1 is null;

select * from example_table;

-- UPDATE SELECT : 수정 작업시 조회 결과를 사용하여 수정(수정 값에 대하여)
update example_table A set A.column1 = (
select B.num 
from auto_table B 
where B.idx= 1
);

select example_column2 
from example_table 
where example_column2='데이터2';

select * from example_table;









