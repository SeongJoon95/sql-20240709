# 주석 종류 : # 주석,  -- 주석

-- 데이터 정의어 (DDL)
-- 데이터베이스, 테이블, 사용자 등(스키마)을 정의하는데 사용되는 언어alter

-- CREATE : 구조를 생성하는 명령어
-- CREATE 생성할구조 구조이름 [... 구조의 정의];

-- 데이터베이스 생성
CREATE DATABASE practice_sql;

-- 데이터베이스 사용 : 데이터베이스 작업을 수행하기 전에 반드시 작업할 데이터베이스를 선택해야함
USE practice_sql;

-- 테이블 생성
CREATE TABLE example_table (
	example_column1 INT,
    example_column2 BOOLEAN
);

-- 컬럼 데이터 타입
cREATE TABLE data_type(
	-- INT : 정수타입
    int_column INT,
    -- DOUBLE : 실수 타입
    double_column DOUBLE,
    -- FLOAT : 실수 타입
    float_column FLOAT,
    -- BOOLEAN : 논리 타입
    boolean_column BOOLEAN,
    -- VARCHAR(문자열길이) : 가변길이 문자열
    String_column VARCHAR(10),
    -- TEXT : 단순 장문 문자열
    text_column TEXT,
    -- DATE : 날자 타입
    tate_colum DATE,
    -- DATETIME : 날짜 및 시간
    datetime_colum DATETIME
);

-- 사용자 생성
-- CREATE USER '사용자명'@'접속IP' IDENTIFIED BY '비밀번호'
-- 접속 IP 위치에 %를 하면 와일드카드로 접속되어 어떠한 위치에서든 할수 있도록 만들어 준다.
CREATE USER 'developer'@'127.0.0.1' IDENTIFIED BY 'P!ssw0rd';









