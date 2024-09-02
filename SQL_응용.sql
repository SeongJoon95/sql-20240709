SHOW CREATE TABLE user;
ALTER TABLE table_name DROP foreign key 




-- 1. 사용자로부터 이메일(email) : 'email@email.com', 패스워드(password) : 'P!ssw0rd', 닉네임(nickanme) : 'rose', 전화번호(tel_number) : '010-1234-5678', 
-- 주소(address) : '부산광역시 사하구', 주소상세(address_detail) : '낙동대로', 개인정보 수집 동의(agreed_personal): true 를 입력받아 user 테이블에 삽입하는 SQL을 작성하시오.

INSERT INTO user (email, password, nickname, tel_number, address, address_detail, agreed_personal) values('email@email.com','P!ssw0rd','rose','010-1234-56783','부산광역시 사하구','낙동대로',true);


-- 2. 사용자로부터 이메일(email) : 'email@email.com', 프로필 이미지(profile_image) : 'https://cdn.onews.tv/news/photo/202103/62559_62563_456.jpg' 를 입력받아 user 테이블의 해당 email을 
-- 가지는 레코드의 profile_image를 입력받은 profile_image로 변경하는 SQL을 작성하시오.

UPDATE user SET profile_image = 'https://cdn.onews.tv/news/photo/202103/62559_62563_456.jpg' WHERE email = 'email@email.com';

-- 3. 사용자로부터 게시물 제목(title): 첫번째 게시물, 게시물 내용(contents): '반갑습니다. 처음뵙겠습니다.', 작성자 이메일(writer_email): 'email2@email.com'을 입력받아 board 테이블에 삽입하는 SQL을 작성하시오. 
-- 만약 삽입에 실패한다면 실패하는 이유에 대하여 설명하시오.

INSERT INTO board (title, contents, writer_email) VALUES ('첫번째 게시물','반갑습니다. 처음뵙겠습니다.','email2@email.com');

-- 4. 사용자로부터 게시물 제목(title): 첫번째 게시물, 게시물 내용(contents): '반갑습니다. 처음뵙겠습니다.', 작성자 이메일(writer_email): 'email@email.com'을 입력받아 board 테이블에 삽입하는 SQL을 작성하시오. 
-- 만약 삽입에 실패한다면 실패하는 이유에 대하여 설명하시오.

INSERT INTO board (title, contents, writer_email) VALUES ('첫번째 게시물','반갑습니다. 처음뵙겠습니다.','email@email.com');


-- 5.사용자로부터 게시물 번호(board_number): 1, 이미지 URL(image_url): 'https://image.van-go.co.kr/place_main/2022/04/04/12217/035e1737735049018a2ed2964dda596c_750S.jpg' 
-- 를 입력받아 board_image 테이블에 삽입하는 SQL을 작성하시오.

INSERT INTO board_image (board_number, image_url) values(1,'https://image.van-go.co.kr/place_main/2022/04/04/12217/035e1737735049018a2ed2964dda596c_750S.jpg');

delete from favorite;
-- 6. 사용자 email@email.com가 1번 게시물에 좋아요를 누르는 기능을 SQL로 작성하시오.
-- 1. 조건에 부합하는 값이 있는지 조회
select * from favorite;
-- 2. 조건에 부합하는 값이 없을경우 서브 쿼리를 이용하여 해당 조건값을 삽입 해준다
INSERT INTO favorite value('email@email.com',2); 
-- 3. board 테이블을 수정하기 위해 서브쿼리를 사용하여 조건이 일치할 경우 좋아요 수를 증가 시킨다.
UPDATE board SET favorite_count = favorite_count + 1 WHERE board_number = 2 AND EXISTS(
SELECT * FROM favorite WHERE user_email = 'email@email.com' AND board_board_number = 2
);
-- 4. 중복 방지

START TRANSACTION;

-- 1. 좋아요 추가 (중복을 허용하지 않음)
INSERT INTO favorite (user_email, board_board_number)
SELECT 'email@email.com', 1
FROM board
WHERE board_number = 1
ON DUPLICATE KEY UPDATE user_email = user_email;

-- 2. 게시물의 좋아요 수 증가
UPDATE board
SET favorite_count = favorite_count + 1
WHERE board_number = 1
AND EXISTS (
    SELECT 1
    FROM favorite
    WHERE user_email = 'email@email.com'
    AND board_board_number = 1
);

-- 성공적으로 모든 작업을 마쳤으면 커밋
COMMIT;


delete board_number from board where board_number = 1;

select * from board;

-- 7.게시물번호(board_number), 게시물 제목(title), 게시물 내용(contents), 조회수(view_count), 댓글수(comment_count), 좋아요수(favorite_count), 게시물 작성일(write_datetime), 작성자 이메일(writer_email), 
-- 작성자 프로필 사진(writer_profile_image), 작성자 닉네임(writer_nickname)을 모두 조회하는 SQL을 작성하시오. (user 테이블과 board 테이블을 모두 이용하시오)

select board_number, title,contents, view_count, comment_count, favorite_count, write_datetime, writer_email, profile_image 'writer_profile_image', nickname 'writer_nickname' from user inner join board;

-- 8. 7번 문제에서 작성한 SQL을 board_view라는 이름의 가상의 테이블로 생성하는 SQL을 작성하시오.
CREATE VIEW board_view AS select board_number, title,contents, view_count, comment_count, favorite_count, write_datetime, writer_email, profile_image 'writer_profile_image', nickname 'writer_nickname' from user inner join board;

SELECT * FROM board_view;
-- 9. 사용자로 부터 '반갑'이라는 문자열을 입력받아 board_view 가상 테이블에서 제목(title) 또는 내용(contents)에 포함되어 있는 레코드를 조회하는 SQL을 작성하시오.
SELECT * FROM board_view WHERE title OR contents LIKE '%반갑%';

-- 10. board 테이블에서 title 컬럼에 대한 조회 속도를 높이기 위한 기능을 board_title_idx 라는 이름으로 생성하는 SQL을 작성하시오.
CREATE INDEX board_title_idx ON board(title);

-- 11. board 테이블에서 작성자 별로 작성한 게시물의 수를 구하는 SQL을 작성하시오.
select count(title) from board group by writer_email;