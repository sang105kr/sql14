SELECT name AS "이름" , address AS "주소"
  FROM customer;
SELECT name "이름" , address "주소" 
  FROM customer; 
SELECT phone
  FROM CUSTOMER
 WHERE name = '김연아';

--고객별 도서수량, 판매총액
  SELECT custid, count(*) "도서수량", sum(saleprice) "총액"
    FROM ORDERS
GROUP BY custid;

--도서별 판매 총액
  SELECT bookid "도서",sum(saleprice) "판매총액"
    FROM ORDERS
GROUP BY bookid;
--도서별 판매 총액을 내림차순
  SELECT bookid "도서",sum(saleprice) "판매총액"
    FROM ORDERS
GROUP BY bookid
ORDER BY sum(saleprice) desc;

SELECT * FROM book;

-- group by절과 함께 사용될때, 
-- select절에는 group by절에 나열된 컬럼 또는 집계함수만 올 수 있다.
  SELECT publisher,sum(price)
    FROM book
GROUP BY publisher ; 

