CREATE TABLE NewBook (
	bookid 			NUMBER,
	bookname 		varchar2(20),
	publisher 	varchar2(20),
	price				NUMBER	
);

SELECT * FROM newbook;

DELETE FROM newbook;
COMMIT; -- 가장 최근에 commit한 이후의 트랜잭션을 최종 db에 반영하는 행위(insert,update,delete)

--데이터 삽입
INSERT INTO newbook (bookid, bookname,publisher,price) 
     VALUES (1,'도서명1','출판사명',10000);
COMMIT;
INSERT INTO newbook (bookid, bookname,publisher,price) 
     VALUES (2,'도서명2','출판사명2',20000);
COMMIT;
INSERT INTO newbook (bookid, bookname,publisher,price) 
     VALUES (3,'도서명3','출판사명3',30000);

INSERT INTO newbook (bookid, bookname,publisher,price) 
     VALUES (4,'도서명4','출판사명4',40000);
--가장최근에 commit한 이후의 변경작업(삽입,삭제,수정) 취소
ROLLBACK;
INSERT INTO newbook (bookid, bookname,publisher,price) 
     VALUES (2,'도서명2','출판사명2',20000);

--테이블 삭제
DROP TABLE NEWBOOK;

--기본키가 있는 테이블 생성 
CREATE TABLE NewBook (
	bookid 			NUMBER,
	bookname 		varchar2(20),
	publisher 	varchar2(20),
	price				NUMBER,
	PRIMARY KEY (bookid)    -- not null 이면서 unique 
);

--기본키의 컬럼이 2개가 있는 테이블 생성 
CREATE TABLE NewBook (
	bookname 		varchar2(20),
	publisher 	varchar2(20),
	price				NUMBER,
	PRIMARY KEY (bookname,publisher)    -- not null 이면서 unique 
);

SELECT * FROM newbook;
INSERT INTO newbook (bookname,publisher,price)
	   VALUES ('도서1','출판사1',10000);

INSERT INTO newbook (bookname,publisher,price)
	   VALUES ('도서2','출판사2',20000);

INSERT INTO newbook (bookname,publisher,price)
	   VALUES ('도서2','출판사2',30000);
ROLLBACK;
INSERT INTO newbook (bookname,publisher,price)
	   VALUES (null,null,30000);

INSERT INTO newbook (price)
	   VALUES (30000);

INSERT INTO newbook 
	   VALUES (null,null,30000);


DROP TABLE newbook;
CREATE TABLE NEWbook(
	bookname varchar2(20) NOT NULL,
	publisher varchar2(20) UNIQUE,
	price NUMBER DEFAULT 10000 check(price > 1000),
	PRIMARY KEY (bookname,publisher)
);

SELECT * FROM newbook;

INSERT INTO newbook (bookname,publisher,price)
 		 VALUES ('도서명1','출판사1',10000);

INSERT INTO newbook (bookname,publisher,price)
 		 VALUES ('도서명2','출판사1',20000);

INSERT INTO newbook (bookname,publisher,price)
 		 VALUES (null,'출판사2',20000);

INSERT INTO newbook (bookname,publisher)
 		 VALUES ('도서명3','출판사3');
INSERT INTO newbook (bookname,publisher,price)
 		 VALUES ('도서명4','출판사4',100);















