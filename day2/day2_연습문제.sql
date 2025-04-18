--1. 마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
--(5) 박지성이 구매한 도서의 출판사 수
--case1) 비표준 SQL
	SELECT count(DISTINCT t3.publisher) "출판사 수"
	  FROM customer t1, orders t2, book t3
	 WHERE t1.custid = t2.custid
	   AND t2.bookid = t3.bookid
     AND t1.name = '박지성'; 

--case2) ANSI(American National Standards Institute)표준 SQL
	SELECT count(DISTINCT t3.publisher) "출판사 수"
	  FROM customer t1 INNER JOIN	orders t2 On t1.custid = t2.custid
	                   INNER JOIN	book t3   ON t2.bookid = t3.bookid
	 WHERE t1.name = '박지성'; 

--case3) sub-query(부속질의)-비상관 쿼리
	SELECT count(DISTINCT publisher)
	  FROM book
   WHERE bookid IN ( 	SELECT bookid 
											  FROM orders
											 WHERE custid  IN ( SELECT custid
																			 	   FROM customer
																				 WHERE name = '박지성') );		
--case4) sub-query(부속질의)-상관쿼리(exists)
	SELECT count(DISTINCT t3.publisher)
	  FROM book t3
	 WHERE exists (	SELECT *
								  	FROM orders t1 INNER JOIN  customer t2 ON t1.custid = t2.custid
									 WHERE t2.name = '박지성' 
	                   AND t3.bookid = t1.bookid); 

--(6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
	SELECT t3.bookname "이름", t3.price "가격", t3.price - t2.saleprice "정가와 판매가격의 차이"
	  FROM customer t1 INNER JOIN	orders t2 On t1.custid = t2.custid
	                   INNER JOIN	book t3   ON t2.bookid = t3.bookid
	 WHERE t1.name = '박지성'; 

--(7) 박지성이 구매하지 않은 도서의 이름
--case1) 차집합
   SELECT bookname
     FROM book
	 MINUS
	SELECT t3.bookname
	  FROM customer t1, orders t2, book t3
	 WHERE t1.custid = t2.custid
	   AND t2.bookid = t3.bookid
     AND t1.name = '박지성'; 

--case2) sub-query 비상관쿼리 not in
	SELECT bookname
	  FROM book
	 WHERE bookid NOT IN ( SELECT t1.bookid
	                         FROM orders t1 INNER JOIN customer t2 ON t1.custid = t2.CUSTID 
	                        WHERE t2.name = '박지성' );
--case3) sub-query 상관쿼리 not exists
	SELECT bookname
	  FROM book t3
	 WHERE NOT EXISTS	( SELECT *
                        FROM orders t1 INNER JOIN customer t2 ON t1.custid = t2.CUSTID 
                       WHERE t2.name = '박지성'
                         AND t3.bookid = t1.bookid);
--case4) left outer join
	SELECT DISTINCT t1.bookname
	  FROM BOOK t1 LEFT OUTER JOIN orders t2   ON t1.bookid = t2.bookid
                 LEFT OUTER JOIN customer t3 ON t2.custid = t3.CUSTID
   WHERE t3.name != '박지성' OR t3.name IS null;
	 
--2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
--(8) 주문하지 않은 고객의 이름(부속질의 사용)
--case1) 비상관 쿼리
	SELECT name
	  FROM customer
	 WHERE custid NOT IN  ( SELECT custid
	                          FROM ORDERS );
--case2) 상관쿼리
	SELECT name
	  FROM customer t1
	 WHERE NOT exists  ( SELECT *
	                       FROM ORDERS t2
											  WHERE t1.custid = t2.custid );

--case3) left outer join
	SELECT t1.name
	  FROM customer t1 LEFT OUTER JOIN orders t2 ON t1.custid = t2.custid
	 WHERE t2.orderid IS NULL;

--(9) 주문 금액의 총액과 주문의 평균 금액
	SELECT sum(SALEPRICE) "총액", avg(SALEPRICE) "평균", sum(SALEPRICE)/count(*) "평균2"
	  FROM orders;
	  
--(10) 고객의 이름과 고객별 구매액
--case1)
	SELECT t1.name, sum(t2.SALEPRICE)
	  FROM customer t1 INNER JOIN orders t2 ON t1.custid = t2.custid
GROUP BY t1.custid, t1.name;	  

--case2)
	SELECT (SELECT name 
	          FROM customer 
	         WHERE custid=t1.custid) "이름", sum(t2.SALEPRICE) "구매액"
	  FROM customer t1 INNER JOIN orders t2 ON t1.custid = t2.custid
GROUP BY t1.custid;	  

--(11) 고객의 이름과 고객이 구매한 도서 목록
	SELECT t1.name, t3.BOOKNAME
	  FROM customer t1 INNER JOIN	orders t2 On t1.custid = t2.custid
	                   INNER JOIN	book t3   ON t2.bookid = t3.bookid;

--(12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
	SELECT t2.orderid "주문번호"
	  FROM book t1 INNER JOIN orders t2 ON t1.bookid = t2.bookid
   WHERE (t1.price-t2.saleprice) = ( 	SELECT max(t1.price - t2.saleprice)
																			  FROM book t1 INNER JOIN orders t2 ON t1.bookid = t2.bookid );

--(13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
-- 도서 판매액 평균
SELECT avg(SALEPRICE)
  FROM orders;
-- 자신의 구매액
  SELECT custid, avg(saleprice)
    FROM orders
GROUP by custid;
  
  SELECT custid, avg(saleprice)
    FROM orders
GROUP by custid
  HAVING avg(saleprice) > (SELECT avg(SALEPRICE)
													   FROM orders ); 
--case1)
  SELECT (SELECT name 
  					FROM customer 
  			 	 WHERE custid=t1.custid ) "고객이름"
    FROM orders t1
GROUP by t1.custid
  HAVING avg(t1.saleprice) > (SELECT avg(SALEPRICE)
                                FROM orders);
  
--case2)  
  SELECT t2.name
    FROM orders t1 INNER JOIN customer t2 ON t1.custid = t2.custid
GROUP by t2.custid, t2.name
  HAVING avg(t1.saleprice) > (SELECT avg(SALEPRICE)  
													      FROM orders ); 
