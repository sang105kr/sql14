SELECT * FROM customer;
-- 행의 갯수
SELECT count(*) FROM customer;

SELECT count(name) FROM customer;

SELECT count(phone) FROM customer;

-- select 수행 순서!  
-- from -> where(테이블 행 필터링) -> group by(컬럼내 동일값 그루핑) -> select -> having(집계결과 행 필터링) -> order by

--step1)
SELECT *
  FROM BOOK t1;
 
--step2)
SELECT *
  FROM BOOK t1
 WHERE t1.price >= 8000;

--step3~4) step3: group by 수행, step4 : select수행
  SELECT t1.publisher,sum(t1.PRICE) 
    FROM BOOK t1
   WHERE t1.price >= 8000
group by t1.publisher;


--step5)
  SELECT t1.publisher,sum(t1.PRICE) 
    FROM BOOK t1
   WHERE t1.price >= 8000
group by t1.publisher
  HAVING sum(t1.PRICE) > 10000;

--step6)
  SELECT t1.publisher,sum(t1.PRICE) 
    FROM BOOK t1
   WHERE t1.price >= 8000
group by t1.publisher
  HAVING sum(t1.PRICE) > 10000
ORDER BY sum(t1.PRICE) desc;  