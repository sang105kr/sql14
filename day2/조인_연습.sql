SELECT t1.* , t2.*
  FROM CUSTOMER t1, ORDERS t2;

-- inner join (내부조인) : 두 테이블에서 같은 컬럼값을 찾아 레코드 필터링이 이뤄짐
SELECT t1.* , t2.*
  FROM CUSTOMER t1, ORDERS t2
 WHERE t1.custid = t2.custid;

SELECT t1.* , t2.*
  FROM CUSTOMER t1 INNER JOIN ORDERS t2
                   ON t1.custid = t2.custid;

SELECT *
  FROM CUSTOMER t1, ORDERS t2, BOOK t3
 WHERE t1.custid = t2.custid
   AND t2.bookid = t3.bookid;
--	 AND t1.name = '박지성';


SELECT *
  FROM CUSTOMER t1 INNER JOIN ORDERS t2
                   ON t1.custid = t2.custid
									 INNER JOIN BOOK T3
									 ON t2.bookid = t3.bookid
 WHERE t1.name = '박지성';									 


--left outer join : 왼쪽 테이블의 모든 레코드를 표시하고 오른쪽테이블은 매칭되는 레코드는 표시하고 매칭되지 않는 레코드는 null로 표시
SELECT *
  FROM customer t1, orders t2
 WHERE t1.custid = t2.custid(+); 

SELECT *
  FROM customer t1 LEFT OUTER join orders t2
                   ON t1.custid = t2.custid;

--right outer join
SELECT *
  FROM customer t1 , orders t2
 WHERE t2.custid(+) = t1.custid; 

SELECT *
  FROM orders t2 right OUTER join CUSTOMER t1
                    ON t1.custid = t2.custid;


--full outer join : lefter outer join 과 right outer join의 합집합
SELECT *
  FROM customer t1 , orders t2
 WHERE t2.custid = t1.custid(+)
UNION 
SELECT *
  FROM customer t1 , orders t2
 WHERE t2.custid(+) = t1.custid; 

SELECT t1.*, t2.*
  FROM orders t2 full OUTER join CUSTOMER t1
                    ON t1.custid = t2.custid;

 


