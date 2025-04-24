SELECT rownum, c.*
  FROM customer c
 WHERE rownum < 3;


SELECT * FROM book;

SELECT rownum, b.*
  FROM book b
 WHERE rownum <=5;

  SELECT rownum, b.*
    FROM book b
   WHERE rownum <=5
ORDER BY b.price;

SELECT rownum, b.*
  FROM ( SELECT *
	         FROM book
	     ORDER BY price ) b
 WHERE rownum <= 5;	     

SELECT rownum, b.*
  FROM ( SELECT *
			 	   FROM BOOK
        	 WHERE rownum <= 5 ) b
ORDER BY price; 

 SELECT rownum, b.* 
   FROM ( SELECT *
				    FROM BOOK
				   WHERE rownum <= 5 
  		  ORDER BY price ) b;
 
 SELECT *
   FROM ( SELECT *
            FROM BOOK
        ORDER BY price DESC) b
  WHERE rownum <= 3;        
 
 SELECT rownum r2, b.*
   FROM (
			 SELECT rownum r1, b.*
            FROM BOOK b
        ORDER BY price DESC ) b;
 
 
 SELECT orderid, saleprice
   FROM ORDERS 
  where saleprice > ALL ( SELECT SALEPRICE 
                            FROM ORDERS 
                           WHERE custid = 3); 
 
  SELECT orderid, saleprice
   FROM ORDERS 
  where saleprice > ( SELECT max(SALEPRICE) 
                        FROM ORDERS 
                       WHERE custid = 3); 
  
 SELECT orderid, saleprice
   FROM ORDERS 
  where saleprice > some ( SELECT SALEPRICE 
                            FROM ORDERS 
                           WHERE custid = 3); 

 SELECT orderid, saleprice
   FROM ORDERS 
  where saleprice > ( SELECT min(SALEPRICE) 
                        FROM ORDERS 
                       WHERE custid = 3); 


  SELECT ( SELECT name 
             from customer c 
            WHERE c.custid = o.custid) "이름",
         sum(saleprice) 							 "판매총액"
    FROM orders o
GROUP BY custid;   
   
 
  SELECT c.NAME , sum(o.saleprice)
    FROM orders o INNER JOIN customer c ON o.custid=c.custid
GROUP BY o.custid,c.name;   
 
--컬럼추가 
ALTER TABLE orders ADD bookname varchar2(40);
SELECT * FROM orders;

UPDATE orders o
   SET o.bookname = ( SELECT bookname 
                        FROM BOOK b
                       WHERE b.bookid = o.bookid);
ROLLBACK;

--컬럼삭제
ALTER TABLE orders DROP COLUMN bookname;

--none ansi
	 SELECT t1.name, sum(t2.saleprice) "total"
	   FROM ( SELECT custid, name
	            FROM CUSTOMER  
	           WHERE custid <= 2 ) t1,
	         orders t2
 		WHERE t1.custid = t2.custid       
 GROUP BY t1.name;

--ansi
	 SELECT t1.name, sum(t2.saleprice) "total"
	   FROM ( SELECT custid, name
	            FROM CUSTOMER  
	           WHERE custid <= 2 ) t1	
	  INNER JOIN orders t2 ON t1.custid = t2.custid
 GROUP BY t1.name;


CREATE VIEW vendors AS
SELECT o.orderid, c.name, b.bookname, b.price, o.saleprice, o.orderdate
  FROM ORDERS o INNER JOIN CUSTOMER c ON o.custid = c.CUSTID
  							INNER JOIN BOOK b 		ON o.bookid = b.bookid;


SELECT sum(saleprice) 
  from vendors;

-- 뷰 생성
CREATE VIEW vw_customer
AS SELECT *
   	 FROM customer
   	WHERE address LIKE '%대한민국%';

CREATE VIEW vw_customer ("c","n","a","p")
AS SELECT *
   	 FROM customer
   	WHERE address LIKE '%대한민국%';

SELECT *
  FROM vw_customer;

-- 뷰 삭제
DROP VIEW vw_customer;


--질의 4-21)
DROP view vw_orders;
CREATE VIEW vw_orders AS 
SELECT o.orderid,c.name, b.bookname, o.saleprice
  FROM orders o INNER JOIN customer c ON o.custid = c.CUSTID
  							INNER JOIN BOOK b   	ON o.bookid = b.bookid;

SELECT orderid "주문번호", bookname "도서이름", saleprice "주문액"
  FROM vw_orders
 WHERE name = '김연아';


CREATE OR REPLACE VIEW vw_customer ("c","n","a") AS
 SELECT custid , name, address
   FROM customer
  WHERE address LIKE '%영국%';

SELECT *
  FROM vw_customer;

DROP VIEW vw_customer;

--8. 마당서점 데이터베이스를 이용해 다음에 해당하는 뷰를 작성하시오.
--(1) 판매가격이 20,000원 이상인 도서의 도서번호, 도서이름, 고객이름, 출판사, 판매가격을
--보여주는 highorders 뷰를 생성하시오.
CREATE VIEW highorders as 	
SELECT b.bookid, b.bookname, c.name, b.publisher, o.SALEPRICE
  FROM ORDERS o INNER JOIN CUSTOMER c ON o.custid = c.CUSTID
  							INNER JOIN BOOK b 		ON o.bookid = b.BOOKID
 WHERE o.SALEPRICE >= 20000;	  							

--(2) 생성한 뷰를 이용하여 판매된 도서의 이름과 고객의 이름을 출력하는 SQL 문을 작성하시오.
	SELECT bookname, name
	  FROM highorders;
	 
--(3) highorders 뷰를 변경하고자 한다. 판매가격 속성을 삭제하는 명령을 수행하시오.

CREATE OR REPLACE VIEW highorders as 	
SELECT b.bookid, b.bookname, c.name, b.publisher
  FROM ORDERS o INNER JOIN CUSTOMER c ON o.custid = c.CUSTID
  							INNER JOIN BOOK b 		ON o.bookid = b.BOOKID
 WHERE o.SALEPRICE >= 20000;	 

	SELECT bookname, name
	  FROM highorders;
	
--삭제 후 (2)번 SQL 문을 다시 수행하시오.
	DROP VIEW HIGHORDERS ;
	SELECT bookname, name
	  FROM highorders;
	
	
	






  SELECT name, sum(saleprice)
    FROM VENDORS
GROUP BY name
ORDER BY sum(saleprice) DESC;  






