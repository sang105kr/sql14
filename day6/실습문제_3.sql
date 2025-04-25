DROP TABLE orders;
DROP TABLE salesperson;
DROP TABLE customer;


CREATE TABLE salesperson(
	name 		VARCHAR2(30) PRIMARY KEY,
	age 		NUMBER(3) NOT null,
	salary 	NUMBER(8) NOT null
);

CREATE TABLE customer(
  name 					VARCHAR2(30) PRIMARY KEY,
  city 					VARCHAR2(15) NOT null,
  industrytype 	VARCHAR2(15) NOT null
);

CREATE TABLE orders (
	num 				NUMBER(3) PRIMARY KEY,
	custname 		VARCHAR2(30) NOT null,
	salesperson VARCHAR2(30) NOT null,
	amount			NUMBER(8) NOT null,
	FOREIGN KEY(custname) 		REFERENCES customer(name),
	FOREIGN KEY(salesperson) 	REFERENCES salesperson(name)
);

INSERT INTO salesperson values('홍길동1',20,3000000);
INSERT INTO salesperson values('홍길동2',31,4000000);
INSERT INTO salesperson values('홍길동3',32,5000000);

INSERT INTO customer values('홍길순1','서울','교사');
INSERT INTO customer values('홍길순2','부산','금융');
INSERT INTO customer values('홍길순3','울산','철강');
INSERT INTO customer values('홍길순4','부산','금융');
INSERT INTO customer values('홍길순5','울산','공무원');
INSERT INTO customer values('홍길순6','부산','금융');

INSERT INTO orders values(1,'홍길순1','홍길동1',1000000);
INSERT INTO orders values(2,'홍길순1','홍길동1',2000000);
INSERT INTO orders values(3,'홍길순1','홍길동2',3000000);
INSERT INTO orders values(4,'홍길순2','홍길동2',4000000);
INSERT INTO orders values(5,'홍길순2','홍길동2',5000000);
INSERT INTO orders values(6,'홍길순2','홍길동2',6000000);
INSERT INTO orders values(7,'홍길순3','홍길동3',1000000);
INSERT INTO orders values(8,'홍길순3','홍길동3',2000000);
INSERT INTO orders values(9,'홍길순3','홍길동3',3000000);
INSERT INTO orders values(10,'홍길순3','홍길동3',4000000);

COMMIT;

--1. 테이블을 생성하는 CREATE 문을 보이시오.
--2. 샘플 데이터를 삽입하는 INSERT 문을 보이시오.
--(레코드 건수 - Salesperson: 3 , Customer: 6, order : 10)
--3. 나이가 30미만인 판매원의 이름을 보이시오.
	SELECT s.name
	  FROM SALESPERSON s 
   WHERE s.AGE < 30;  
--4. ‘산’로 끝나는 도시에 사는 고객의 이름을 보이시오.
	SELECT c.name
	  FROM CUSTOMER c 
	 WHERE c.CITY LIKE '%산';
--5. 주문을 한 고객 수(서로 다른 고객만)를 구하시오.
   SELECT count(DISTINCT o.custname)
     FROM ORDERS o ;
--6. 판매원 각각에 대하여 주문의 수를 계산하시오.
	 SELECT o.SALESPERSON, count(*)
	   FROM orders o
 GROUP by	o.SALESPERSON;
--7. ‘울산’에 사는 고객으로부터 주문을 받은 판매원의 이름과 나이를 보이시오(부속질의를 사용)
	-- 비상관 쿼리1
	 SELECT s.name, s.age
	   FROM SALESPERSON s 
    WHERE s.name IN (  SELECT o.SALESPERSON
											   FROM ORDERS o 
										    WHERE o.CUSTNAME IN (SELECT name
																						   FROM customer c
																						  WHERE city = '울산') ); 
	-- 비상관 쿼리2
	 SELECT s.name, s.age
	   FROM SALESPERSON s 
    WHERE s.name IN (  SELECT o.SALESPERSON
											   FROM ORDERS o INNER JOIN customer c ON o.CUSTNAME = c.NAME
												WHERE city = '울산'); 
   -- 상관 쿼리
	 SELECT s.name, s.age
	   FROM SALESPERSON s 
    WHERE exists ( SELECT o.SALESPERSON
									   FROM ORDERS o INNER JOIN customer c ON o.CUSTNAME = c.NAME
										WHERE city = '울산' AND s.name = o.SALESPERSON ); 


--8. ‘울산’에 사는 고객으로부터 주문을 받은 판매원의 이름과 나이를 보이시오(조인사용)
	SELECT DISTINCT s.name "이름", s.age "나이"
	  FROM SALESPERSON s INNER JOIN ORDERS o ON s.name = o.SALESPERSON
	  									 INNER JOIN customer c ON c.NAME = o.CUSTNAME
	 WHERE c.CITY = '울산';	  									 

--9. 두 번 이상 주문을 받은 판매원의 이름을 보이시오
	SELECT o.SALESPERSON, count(*)
	  FROM orders o
GROUP by o.SALESPERSON
	HAVING count(*) >= 2

--10. 판매원 “홍길동1”의 봉급을 4,500,000으로 변경하는 SQL문을 작성하시오
	UPDATE SALESPERSON 
	   SET salay = 4500000
	 WHERE name = '홍길동1'  ;
  SELECT * FROM SALESPERSON;
	COMMIT;

--11. 각 판매원별로 총 주문 금액을 계산하고, 판매원 이름과 총 주문 금액을 함께 조회하세요. 
--결과는 총 주문 금액을 기준으로 내림차순으로 정렬하고, 총 주문 금액이 500 만원 이상인 판매원만 출력하세요.
	SELECT s.name, sum(o.AMOUNT)
	  FROM SALESPERSON s INNER JOIN ORDERS o ON s.NAME = o.SALESPERSON
GROUP BY s.name
	HAVING sum(o.AMOUNT) >= 5000000
ORDER BY sum(o.amount) desc;	  

--12. 각 고객별로 주문 횟수를 계산하고, 고객 이름과 주문 횟수를 함께 조회하세요. 
--단, 주문 횟수가 2회 이상인 고객만 출력하고, 결과는 주문 횟수를 기준으로 내림차순으로 정렬하세요.
	SELECT c.NAME, count(*)
	  FROM CUSTOMER c INNER JOIN ORDERS o ON c.NAME = o.CUSTNAME
GROUP BY c.NAME	  
  HAVING count(*) >= 2
ORDER BY count(*) DESC;  





