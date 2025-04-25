CREATE  INDEX ix_book ON book(bookname);

CREATE INDEX ix_book2 ON book(publisher,price);

DROP INDEX ix_book2;

CREATE INDEX ix_book2 ON book(publisher asc,price desc);


SELECT *
  FROM book
 WHERE publisher = '대한미디어' 
   AND price >= 30000;

--인덱스 재구성 : 데이터 변경주기를 고려하여 주기적으로 재구성해주어야 검색성능을 유지할수 있다.
ALTER INDEX ix_book rebuild;


CREATE TABLE unique_test (
	column1 varchar2(10) PRIMARY KEY,
	column2 varchar2(10) unique, --널 이외의 값은 중복허용 한함
	column3 varchar2(10)
);
SELECT * FROM unique_test;
INSERT INTO unique_test values('c1','c2','c3');
--INSERT INTO unique_test values(null,'c3','c3');
INSERT INTO unique_test values('c2',null,'c3');
INSERT INTO unique_test values('c3',null,'c3');
INSERT INTO unique_test values('c4',null,'c3');
INSERT INTO unique_test values('c5','c','c3');
INSERT INTO unique_test values('c6','c','c3');
COMMIT;

SELECT name
  FROM customer
 where name LIKE '박세리'; 

CREATE INDEX ix_customer_name ON customer(name);

DROP INDEX ix_customer_name;






