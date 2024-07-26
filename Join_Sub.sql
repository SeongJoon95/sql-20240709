USE practice_sql;

CREATE TABLE employee(
	employee_number INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    age INT,
    department_code VARCHAR(2)
);

CREATE TABLE department(
	department_code VARCHAR(2) PRIMARY KEY,
    name VARCHAR(30),
    tel_number VARCHAR(15)
);

ALTER TABLE employee
ADD CONSTRAINT department_code_fk
FOREIGN KEY(department_code)
REFERENCES department(department_code);

ALTER TABLE employee
DROP CONSTRAINT department_code_fk;

INSERT INTO department VALUES ('A','영업부','123456');
INSERT INTO department VALUES ('B','재무부','123457');
INSERT INTO department VALUES ('C','행정부','123458');

SELECT * FROM department;

INSERT INTO employee (name, age, department_code) VALUES ('홍길동',23,'A');
INSERT INTO employee (name, age, department_code) VALUES ('이영희',15,'A');
INSERT INTO employee (name, age, department_code) VALUES ('고길동',34,'C');
INSERT INTO employee (name, age, department_code) VALUES ('김둘리',20,'D');
INSERT INTO employee (name, age, department_code) VALUES ('이도',17,'D');

SELECT * FROM employee;

-- Alias : 쿼리문에서 사용되는 별칭
-- 컬럼 및 테이블에서 사용가능
-- 사용하는 이름을 변경하고 싶을때 적용
SELECT 
	department_code AS '부서코드',
    name AS '부서명',
    tel_number AS '부서 전화번호'
FROM department AS dpt;

-- AS 키워드 생략 가능
SELECT 
	dpt.department_code '부서코드',
    dpt.name '부서명',
    dpt.tel_number '부서 전화번호'
FROM department dpt;

-- JOIN : 두 개 이상의 테이블을 특정 조건에 따라 조합하여 결과를 조회하고자 할때 사용하는 명령어

-- INNER JOIN : 두 테이블에서 조건이 일치하는 레코드만 반환
-- SELECT column, ... FROM 기준테이블 INNER JOIN 조합할테이블 ON 조인조건
SELECT
	E.employee_number '사번',
    E.name '사원이름',
    E.age '나이',
    D.department_code '부서코드', -- or  E.department_code
    D.name '부서명',
    D.tel_number '부서전화번호'
FROM employee E INNER JOIN department D
ON E.department_code = D.department_code;

-- LEFT OUTER JOIN (LEFT JOIN): 기준 테이블의 모든 레코드와 조합할 테이블 중 조건에 일치하는 레코드만 반환
-- 만약에 조합할 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 표현

SELECT
	E.employee_number '사번',
    E.name '사원이름',
    E.age '나이',
    E.department_code '부서코드', -- or  E.department_code
    D.name '부서명',
    D.tel_number '부서전화번호'
FROM employee E LEFT JOIN department D
ON E.department_code = D.department_code;

-- RIGHT OUTER JOIN (RIGHT JOIN) : 조합할 테이블의 모든 레코드와 기준 테이블 중 조건에 일치하는 레코드만 반환
-- 만약 기준 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 반환
SELECT
	E.employee_number '사번',
    E.name '사원이름',
    E.age '나이',
    D.department_code '부서코드', -- or  E.department_code
    D.name '부서명',
    D.tel_number '부서전화번호'
FROM employee E RIGHT JOIN department D
ON E.department_code = D.department_code;

-- FULL OUTER JOIN (FULL JOIN) : 기준테이블의 모든 레코드와 조합할 테이블의 모든 레코드를 반환
-- 만약 기준 테이블 혹은 조합할 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 반환
-- MySQL에서는 FULL OUTER JOIN을 문법상 제공하지 않음
-- FULL JOIN = LEFT JOIN + RIGHT JOIN
SELECT
	E.employee_number '사번',
    E.name '사원이름',
    E.age '나이',
    E.department_code '부서코드', -- or  E.department_code
    D.name '부서명',
    D.tel_number '부서전화번호'
FROM employee E LEFT JOIN department D
ON E.department_code = D.department_code
UNION -- UNION : 합집합에 대한 표현
SELECT
	E.employee_number '사번',
    E.name '사원이름',
    E.age '나이',
    D.department_code '부서코드', -- or  E.department_code
    D.name '부서명',
    D.tel_number '부서전화번호'
FROM employee E RIGHT JOIN department D
ON E.department_code = D.department_code; 

-- CROSS JOIN : 기준 테이블의 각 레코드를 조합할 테이블의 모든 레코드에 조합하여 반환
-- CROSS JOIN 결과 레코드 수 = 기준 테이블 레코드 수 x 조합할 레코드 수
SELECT * FROM
employee E CROSS JOIN department D;

-- MySQL에서 기본 조인이 CROSS JOIN 형태임
SELECT * FROM employee E JOIN department D;
-- or
SELECT * FROM employee E, department D;

-- 부서코드가 A 인 사원에 대해
-- 사번, 이름, 부서명을 조회하시오.
SELECT 
	E.employee_number '사번',
    E.name '이름',
    D.name '부서명'
FROM employee E INNER JOIN department D
ON E.department_code = D.department_code
WHERE E.department_code = 'A';

-- 부서명이 '영업부'인 사원에 대해
-- 사번, 이름, 나이를 조회하시오
SELECT
	E.employee_number '사번',
    E.name '이름',
    E.age '나이',
    E.department_code '부서'
FROM employee E INNER JOIN department D
ON E.department_code = D.department_code
WHERE D.name = '영업부';

-- 서브쿼리 : 쿼리 내부에 존재하는 또 다른 쿼리, 쿼리 결과를 조건이나 테이블로 사용할 수 있도록 함

-- WHERE 절에서 서브쿼리 : 조회 결과를 조건으로 사용하여 조건을 동적으로 지정할 수 있도록 함
-- WHERE 절에서 비교 연산등으로 사용할 때 조회하는 컬럼의 개수 및 레코드의 개수 주의
SELECT employee_number, name, age
FROM employee
WHERE department_code = (
	SELECT department_code
    FROM department
    WHERE name = '영업부'
);

SELECT employee_number, name, age
FROM employee
WHERE department_code = (
	SELECT *
    FROM department
    WHERE name = '영업부'
);

SELECT employee_number, name, age
FROM employee
WHERE department_code = (
	SELECT department_code
    FROM department
);

-- Error 1241 column이 하나가 아니다
SELECT employee_number, name, age
FROM employee
WHERE department_code IN (
	SELECT * -- 이부분
    FROM department
);

-- 부서명이 '영업부'인 사원에 대해
-- 사번, 이름, 나이를 조회하시오
SELECT employee_number, name, age
FROM employee
WHERE department_code = (
	SELECT department_code
	FROM department
	WHERE name = '영업부'
);

-- FROM 절에서 서브쿼리 : 조회결과 테이블을 다시 FROM 절에서 재사용
-- 복잡한 구성형태

-- 부서명이 '영업부'인 사원에 대해
-- 사번, 이름, 나이를 조회하시오
SELECT * FROM department
WHERE name = '영업부';

SELECT
	E.employee_number '사번',
    E.name '이름',
    E.age '나이',
    E.department_code '부서'
FROM employee E INNER JOIN (
	SELECT * FROM department
	WHERE name = '영업부'
) D
ON E.department_code = D.department_code;

-- 서브쿼리를 FROM  절에서 사용할경우 '반드시' 별칭을 사용해야함.
SELECT *
FROM(
	SELECT * FROM department
) A
WHERE name = '영업부';








