-- 테이블 이름 변경
-- RENAME 기존테이블명 TO 기존테이블명_old;
DROP TABLE RESERVATIONS;
DROP TABLE CUSTOMERS;
DROP TABLE MOVIES;
DROP TABLE THEATERS;

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
COMMIT;

--극장
SELECT * FROM THEATERS;
DELETE FROM THEATERS;
COMMIT;
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
COMMIT;

--예약
SELECT * FROM RESERVATIONS;
DELETE FROM RESERVATIONS;
COMMIT;
INSERT INTO RESERVATIONS 
		 VALUES(RESERVATIONS_RESERVATION_ID_SEQ.NEXTVAL,1,1,1,TO_DATE('2024-12-24','YYYY-MM-DD'),1300,'A1');
INSERT INTO RESERVATIONS 
		 VALUES(RESERVATIONS_RESERVATION_ID_SEQ.NEXTVAL,2,1,1,TO_DATE('2024-12-24','YYYY-MM-DD'),1400,'B1');
INSERT INTO RESERVATIONS 
		 VALUES(RESERVATIONS_RESERVATION_ID_SEQ.NEXTVAL,3,2,2,TO_DATE('2024-12-24','YYYY-MM-DD'),1500,'C1');
INSERT INTO RESERVATIONS 
		 VALUES(RESERVATIONS_RESERVATION_ID_SEQ.NEXTVAL,4,2,2,TO_DATE('2024-12-24','YYYY-MM-DD'),1600,'D1');
INSERT INTO RESERVATIONS 
		 VALUES(RESERVATIONS_RESERVATION_ID_SEQ.NEXTVAL,5,2,2,TO_DATE('2024-12-24','YYYY-MM-DD'),1700,'E1');
COMMIT;

--1.영화 테이블의 개봉일 컬럼을 사용하여 현재 상영 중인 영화를 찾는 쿼리를 작성합니다.
	SELECT *
	  FROM MOVIES m 
	 WHERE m.RELEASE_DATE  <= sysdate;

	SELECT *
	  FROM MOVIES m 
	 WHERE m.RELEASE_DATE  <= to_date('2025-01-03','YYYY-MM-DD');

--2.극장 테이블에서 특정 위치에 있는 극장을 찾고, 해당 극장에서 상영하는 영화 목록을 가져오는 쿼리를 작성합니다.
	--case1)
	SELECT *
	  FROM MOVIES m 
   WHERE m.movie_id IN (	SELECT r.MOVIE_ID
													  FROM RESERVATIONS r 
													 WHERE r.THEATER_ID IN ( SELECT t.THEATER_ID
																								 	   FROM THEATERS t 
												  	                        WHERE t.LOCATION ='위치1')) ;

	--case2)
		SELECT DISTINCT m.*
		  FROM RESERVATIONS r INNER JOIN THEATERS t ON r.THEATER_ID = t.THEATER_ID
		  										INNER JOIN MOVIES m   ON r.MOVIE_ID = m.MOVIE_ID
 		 WHERE t.LOCATION = '위치1';		  										

--3.예약 테이블을 사용하여 특정 고객의 예약 내역과 예약한 영화의 정보를 함께 제공하는 쿼리를 작성합니다.	
		SELECT c.CUSTOMER_NAME , m.TITLE
		  FROM RESERVATIONS r INNER JOIN CUSTOMERS c ON r.CUSTOMER_ID = c.CUSTOMER_ID
		  										INNER JOIN MOVIES m 	 ON r.MOVIE_ID    = m.MOVIE_ID
		 WHERE c.CUSTOMER_NAME = '홍길동2';
	
--4.예약과 극장을 조인하여, 각 극장별로 예약된 좌석 수를 계산하는 쿼리를 작성합니다.
		SELECT t.THEATER_NAME "극장명", count(*) "예약 좌석수"
		  FROM RESERVATIONS r INNER JOIN THEATERS t ON r.THEATER_ID = t.THEATER_ID
  GROUP BY t.THEATER_ID,t.THEATER_NAME;

--5.가장 인기 있는 영화 장르를 결정하는 쿼리를 작성합니다. (예: 예약 수 기준)
  SELECT m.GENRE "장르", count(*) "예약건수"
    FROM RESERVATIONS r INNER JOIN MOVIES m ON r.MOVIE_ID = m.MOVIE_ID
GROUP BY m.GENRE
	HAVING count(*) = ( SELECT max(cnt)
											  FROM (	SELECT m.GENRE , count(*) cnt
													      	FROM RESERVATIONS r INNER JOIN MOVIES m ON r.MOVIE_ID = m.MOVIE_ID
											      	GROUP BY m.GENRE) t1 );
     
--6.위의 쿼리말고 필요로하는 쿼리문을 3건 작성합니다. (SQL문이 아닌 한글질의문)

--7.예약이 한건도 없는 영화 제목은?
	--case1) 상관쿼리
	SELECT m.title
	  FROM MOVIES m 
	 WHERE NOT EXISTS (SELECT *
	                     FROM RESERVATIONS r 
	                    WHERE r.MOVIE_ID = m.MOVIE_ID )  ;
	--case2) left outer join
	SELECT m.title
	  FROM movies m LEFT OUTER JOIN RESERVATIONS r ON m.MOVIE_ID = r.MOVIE_ID
   WHERE r.reservation_id IS null;
	  
  --case3) 차집합
	SELECT m.title
	  FROM movies m
  MINUS
	SELECT m.title
    FROM MOVIES m 
   WHERE EXISTS (SELECT *
                   FROM RESERVATIONS r 
                  WHERE r.MOVIE_ID = m.MOVIE_ID ) ;
  
--8.예약을 한번도 하지 않은 고객이름?









