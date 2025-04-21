--1. 마당서점에서 다음의 심화된 질문에 대해 SQL 문을 작성하시오.
-- (1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
	SELECT DISTINCT t2.name
	  FROM orders t1 INNER JOIN customer t2 ON t1.custid = t2.custid
	  							 INNER JOIN book t3     ON t1.bookid = t3.bookid
 	 WHERE t3.publisher IN ( SELECT DISTINCT t3.publisher
													   FROM orders t1 INNER JOIN customer t2 ON t1.custid = t2.custid
	  							 													INNER JOIN book t3     ON t1.bookid = t3.bookid
	 													WHERE t2.name = '박지성')
		AND t2.name <> '박지성';  

-- (2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
  SELECT t2.name "고객명" --, count(DISTINCT t3.publisher) "서로다른 출판사 수"
    FROM orders t1 INNER JOIN customer t2 ON t1.custid = t2.custid
		               INNER JOIN book t3     ON t1.bookid = t3.bookid
GROUP BY t2.custid, t2.name
  HAVING count(DISTINCT t3.publisher) >= 2


-- (3) (생략) 전체 고객의 30% 이상이 구매한 도서

   SELECT t2.bookname --, count(DISTINCT t1.custid)
     FROM orders t1 INNER JOIN book t2 ON t1.bookid = t2.bookid
 GROUP BY t2.bookid, t2.bookname 
   HAVING count(DISTINCT t1.custid) >= (  SELECT count(*) * 0.3
																				    FROM customer );  
   
--2. 다음 질의에 대해 DML 문을 작성하시오.
--(1) 새로운 도서 (‘스포츠 세계’, ‘대한미디어’, 10000원)이 마당서점에 입고되었다.
		SELECT * FROM book;
		INSERT INTO book (bookname, publisher, price)
         VALUES ('스포츠 세계', '대한미디어', 10000);
--삽입이 안 될 경우 필요한 데이터가 더 있는지 찾아보자.

--(2) ‘삼성당’에서 출판한 도서를 삭제해야 한다.
		SELECT * FROM book;
		DELETE FROM book WHERE publisher = '삼성당';
	
--(3) ‘이상미디어’에서 출판한 도서를 삭제해야 한다. 삭제가 안 될 경우 원인을 생각해보자.
		DELETE FROM book WHERE publisher = '이상미디어';


--(4) 출판사 ‘대한미디어’가 ‘대한출판사’로 이름을 바꾸었다.
		UPDATE BOOK 
		   SET publisher = '대한출판사'
		 where publisher = '대한미디어';  
		
   ROLLBACK;
