-- 테이블 이름 변경
-- RENAME 기존테이블명 TO 기존테이블명_old;
DROP TABLE CUSTOMERS;
DROP TABLE MOVIES;
DROP TABLE THEATERS;
DROP TABLE RESERVATIONS;

--고객
CREATE TABLE customers(
	customer_id 	NUMBER(10) PRIMARY KEY,  		--고객ID
	customer_name varchar2(30),								--고객명
	contact 			char(13),										--연락처
	email					varchar2(50),								--이메일
	reward_points	NUMBER	DEFAULT 0 NOT NULL  --적립포인트
);
--영화
CREATE TABLE movies(
	movie_id			NUMBER(10) PRIMARY KEY,		--영화ID
	title					varchar2(100) NOT NULL,	  --제목
	director			varchar2(30), 						--감독
	genre					varchar2(30), 						--장르
	duration			NUMBER(3), 								--상영시간(총 상영시간, ex) 130분), 
	release_date	DATE											--개봉일
);
--극장
CREATE TABLE theaters(
	theater_id		NUMBER(10) PRIMARY KEY,						--극장ID 
	theater_name	varchar2(100),										--극장명 
	location			varchar2(100),										--위치
	capacity			NUMBER(3)	check(capacity BETWEEN 0 AND 300)	-- 수용인원
);
--예약
CREATE TABLE reservations(
	reservation_id	 NUMBER(10),	--예약ID
	customer_id			 NUMBER(10),	--고객ID
	movie_id				 number(10),  --영화ID
	theater_id			 number(10),	--극장ID
	reservation_date DATE,				--예약일
	showtime				 NUMBER(4),		--상영시간(시작시간 ex)2430)
	seat						 varchar2(10),-- 좌석
	PRIMARY KEY (reservation_id),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (movie_id) 		REFERENCES movies(movie_id),
	FOREIGN KEY (theater_id) 	REFERENCES theaters(theater_id)
);

-- 시퀀스 삭제
DROP SEQUENCE CUSTOMERS_CUSTOMER_ID_SEQ;
DROP SEQUENCE MOVIES_MOVIE_ID_SEQ;
DROP SEQUENCE THEATERS_THEATER_ID_SEQ;
DROP SEQUENCE RESERVATIONS_RESERVATION_ID_SEQ;

-- 시퀀스 생성
CREATE SEQUENCE CUSTOMERS_CUSTOMER_ID_SEQ;
CREATE SEQUENCE MOVIES_MOVIE_ID_SEQ;
CREATE SEQUENCE THEATERS_THEATER_ID_SEQ;
CREATE SEQUENCE RESERVATIONS_RESERVATION_ID_SEQ;

--고객
SELECT * FROM CUSTOMERS;
DELETE FROM CUSTOMERS;
COMMIT;
INSERT INTO customers (customer_id,customer_name,contact,email)
		 VALUES (CUSTOMERS_CUSTOMER_ID_SEQ.NEXTVAL, '홍길동1','010-1234-1111','hong1@example.com');
INSERT INTO customers (customer_id,customer_name,contact,email)
		 VALUES (CUSTOMERS_CUSTOMER_ID_SEQ.NEXTVAL, '홍길동2','010-1234-2222','hong2@example.com');
INSERT INTO customers (customer_id,customer_name,contact,email)
		 VALUES (CUSTOMERS_CUSTOMER_ID_SEQ.NEXTVAL, '홍길동3','010-1234-3333','hong3@example.com');
INSERT INTO customers (customer_id,customer_name,contact,email)
		 VALUES (CUSTOMERS_CUSTOMER_ID_SEQ.NEXTVAL, '홍길동4','010-1234-4444','hong4@example.com');
INSERT INTO customers (customer_id,customer_name,contact,email)
		 VALUES (CUSTOMERS_CUSTOMER_ID_SEQ.NEXTVAL, '홍길동5','010-1234-5555','hong5@example.com');
ROLLBACK;
COMMIT;

--영화
SELECT * FROM MOVIES;
DELETE FROM MOVIES;
COMMIT;
INSERT INTO MOVIES 
		 VALUES (MOVIES_MOVIE_ID_SEQ.nextval,'제목1','감독1','장르1',110,to_date('2025-01-01','YYYY-MM-DD'));
INSERT INTO MOVIES 
		 VALUES (MOVIES_MOVIE_ID_SEQ.nextval,'제목2','감독2','장르2',120,to_date('2025-01-02','YYYY-MM-DD'));
INSERT INTO MOVIES 
		 VALUES (MOVIES_MOVIE_ID_SEQ.nextval,'제목3','감독3','장르3',130,to_date('2025-01-03','YYYY-MM-DD'));
INSERT INTO MOVIES 
		 VALUES (MOVIES_MOVIE_ID_SEQ.nextval,'제목4','감독4','장르4',140,to_date('2025-01-04','YYYY-MM-DD'));
INSERT INTO MOVIES 
		 VALUES (MOVIES_MOVIE_ID_SEQ.nextval,'제목5','감독5','장르5',150,to_date('2025-01-05','YYYY-MM-DD'));
ROLLBACK;

--극장
SELECT * FROM THEATERS;
INSERT INTO THEATERS 
		 VALUES (THEATERS_THEATER_ID_SEQ.NEXTVAL,'극장명1','위치1',100);
INSERT INTO THEATERS 
		 VALUES (THEATERS_THEATER_ID_SEQ.NEXTVAL,'극장명2','위치2',200);
INSERT INTO THEATERS 
		 VALUES (THEATERS_THEATER_ID_SEQ.NEXTVAL,'극장명3','위치3',200);
INSERT INTO THEATERS 
		 VALUES (THEATERS_THEATER_ID_SEQ.NEXTVAL,'극장명4','위치4',300);
INSERT INTO THEATERS 
		 VALUES (THEATERS_THEATER_ID_SEQ.NEXTVAL,'극장명5','위치5',300);









