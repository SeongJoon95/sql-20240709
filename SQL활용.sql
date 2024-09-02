CREATE database SQLTEST;
use SQLTEST;

CREATE TABLE user (
	email VARCHAR(50) PRIMARY KEY NOT NULL,
    password VARCHAR(100) NOT NULL,
    nickname VARCHAR(20) NOT NULL UNIQUE,
    tel_number VARCHAR(15) NOT NULL UNIQUE,
    address TEXT NOT NULL,
    address_detail TEXT,
    profile_image TEXT,
    agreed_personal TINYINT NOT NULL
);

CREATE TABLE board (
	board_number INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	title VARCHAR(255) NOT NULL,
    contents TEXT NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT now(),
    favorite_count INT NOT NULL DEFAULT 0,
    comment_count INT NOT NULL DEFAULT 0,
    view_count INT NOT NULL DEFAULT 0,
    writer_email VARCHAR(50) NOT NULL,
    CONSTRAINT writer FOREIGN KEY (writer_email) REFERENCES user(email)
);

CREATE TABLE comment (
	comment_number INT PRIMARY KEY NOT NULL,
	contents TEXT NOT NULL,
	write_datetime DATETIME NOT NULL DEFAULT now(),
    user_email VARCHAR(50) NOT NULL,
    board_number INT NOT NULL,
    CONSTRAINT writer_2 FOREIGN KEY (user_email) REFERENCES user(email),
    CONSTRAINT board_comment FOREIGN KEY(board_number) REFERENCES board(board_number)
);
ALTER TABLE comment MODIFY COLUMN comment_number INT AUTO_INCREMENT;

CREATE TABLE favorite(
	user_email VARCHAR(50) NOT NULL,
    board_board_number INT NOT NULL,
    PRIMARY KEY (user_email,board_board_number),
    CONSTRAINT user_favorite FOREIGN KEY (user_email) REFERENCES user(email),
    CONSTRAINT board_favorite FOREIGN KEY (board_board_number) REFERENCES board(board_number)
);

CREATE TABLE board_image (
	sequence INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    board_number INT NOT NULL,
    image_url TEXT,
    CONSTRAINT board_image FOREIGN KEY (board_number) REFERENCES board(board_number)
);

CREATE TABLE search_log (
	sequence INT PRIMARY KEY NOT NULL,
    search_word TEXT NOT NULL,
    relation_word TEXT,
    relation TINYINT NOT NULL
);
ALTER TABLE search_log MODIFY COLUMN sequence INT AUTO_INCREMENT;


board 테이블의 외래키 name 과 comment 테이블의 외래키 네임이 중복되어 오류 발생!!
comment 테이블의 외래키네임을 writer_2로 생성.

1. DBMS란 무엇인지 설명하시오.
 - Database Management System 데이터 베이스를 관리하고 운영하기 위한 소프트웨어 시스템
 - 데이터의 저장, 검색, 수정, 삭제 및 관리 작업을 수행
 - 데이터 무결성 유지하고 다중 사용자 접근을 지원
 - DBMS는 데이터베이스를 추상화하여 개발자와 사용자에게 효율적이고 일관된 데이터 관리를 제공
  

2. DBMS의 필요성에 대해 나열하고 설명하시오.
 - 데이터 뮤결성 유지 : DBMS는 데이터의 정확성과 일관성을 보장. 데이터 입력 및 수정 시 제약 조건을 설정하여 오류를 줄이고 일관성을 유지
 - 중복 데이터 최소화 : DBMS는 데이터 중복을 줄이기 위해 정규화 과정을 통해 데이터의 중복 저장을 방지
 - 데이터 보안 및 접근 제어 : DBMS는 사용자 권한을 관리하고 데이터 접근을 제어하여 보안을 강화. 데이터에 대한 접근 권한을 세밀하게 설정할 수 있다.
 

3. DBMS의 종류에 대해 나열하고 설명하시오.
 - 관계형 데이터베이스 관리 시스템(RDBMS) : 데이터를 테이블 형태로 저장하고, SQL(Structured Query Language)을 사용하여 데이터에 접근합니다. ex) MySQL, PostgreSQL.
 - 문서 지향 데이터베이스 : 데이터가 문서 형태로 저장되며, JSON이나 BSON 형식을 사용. 
ex) MongoDB, CouchDB.
 - 키-값 저장소 (Key-Value Store): 데이터가 키와 값의 쌍으로 저장됨. 높은 성능과 확장성을 제공한다. ex) Redis, DynamoDB.

4. RDBMS의 구성요소에 대해 나열하고 설명하시오.
- 테이블(Table) : 데이터를 행과 열의 형태로 저장하는 기본 단위. 각 행은 레코드, 각 열은 필드를 의미
- 스키마(Schema) : 데이터베이스의 구조를 정의하는 메타데이터로 테이블, 필드, 관계 등을 정의
- 쿼리 언어(Query Language) : 데이터베이스에 대한 질의, 수정, 삭제 작업을 수행하는 언어로써 SQL이 대표적이다.

5. RDBMS에서 SQL의 종류에 대해 나열하고 설명하시오.
 1. DML (Data Manipulation Language) : 데이터베이스의 데이터를 조작하는 명령어, SELECT,
	- SELECT : 데이터를 조회하는 명령어
	- INSERT : 테이블에 새로운 레코드를 삽입하는 명령어
	- UPDATE : 기존 레코드를 수정하는 명령어
	- DELETE : 레코드를 삭제하는 명령어
 2. DDL (Data Definition Language) : 데이터베이스 객체의 구조를 정의하거나 수정하는 명령어 집합
	- CREATE : 새로운 데이터베이스 객체를 생성하는 명령어
	- ALTER : 기존 데이터베이스 객체의 구조를 변경하는 명령어
	- DROP : 데이터베이스 객체를 삭제하는 명령어
 3. DCL (Data Control Language) : 데이터베이스 객체에 대한 권한과 접근 제어를 관리하는 명령어 집합
	- GRANT : 사용자에게 특정 권한을 부여하는 명령어
	- REVOKE : 사용자에게 부여된 권한을 취소하는 명령어
	- DENY : 특정 작업에 대한 접근을 명시적으로 차단하는 명령어


 4. 그외
	- BEGIN TRANSACTION or START TRANSACTION : 트랜잭션의 시작을 선언, 데이터베이스에서 일련의 작업이 트랜잭션으로 묶여서 실행
	- COMMIT : 현재 트랜잭션에서 수행된 모든 작업을 데이터베이스에 영구적으로 저장, 트랜잭션의 성공적인 완료를 의미
	- ROLLBACK :  현재 트랜잭션에서 수행된 모든 작업을 취소하고 데이터베이스를 트랜잭션 시작 전의 상태로 되돌린다. 트랜잭션이 실패했거나 오류가 발생한 경우 사용



