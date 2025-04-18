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


--(7) 박지성이 구매하지 않은 도서의 이름


--2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
--(8) 주문하지 않은 고객의 이름(부속질의 사용)


--(9) 주문 금액의 총액과 주문의 평균 금액


--(10) 고객의 이름과 고객별 구매액


--(11) 고객의 이름과 고객이 구매한 도서 목록


--(12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문


--(13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름