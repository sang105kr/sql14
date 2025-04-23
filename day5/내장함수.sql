SELECT abs(-4.5)
  FROM dual;

SELECT power(2,3)
  FROM dual;

SELECT ceil(4.1)
  FROM dual;

SELECT floor(4.1)
  FROM dual;

SELECT round(3.14,1)
  FROM dual;

SELECT round(3215,-2)
  FROM dual;

SELECT round(3255,-2)
  FROM dual;

SELECT chr(65),chr(90)
  FROM dual;

SELECT lpad('Page',10,' ')
  FROM dual;

SELECT ltrim('<==>BROWNING<==>','<>=')
  FROM dual;

SELECT rtrim('<==>BROWNING<==>','<>=')
  FROM dual;

SELECT substr('ABCDEFG',3,4)
  FROM dual;

SELECT trim(' abc ')
  FROM dual;

SELECT trim( '=' FROM '==>BROWNING<==')
  FROM dual;

SELECT instr('corporate floor', 'or',1,1)
  FROM dual;

SELECT length('candide')
  FROM dual;

SELECT substr(name,1,1) || ' ' || substr(name,2,2)
  FROM CUSTOMER; 

  SELECT substr(name,1,1) "성", count(*) "인원수"
    FROM customer
GROUP BY substr(name,1,1);  
  
SELECT *
  FROM orders
 WHERE to_char(orderdate,'yyyy-mm-dd') = '2020-07-01';

SELECT *
  FROM orders
 WHERE orderdate = to_date('2020-07-01','yyyy-mm-dd'); 

SELECT add_months(to_date('2025-12-01','yyyy-mm-dd'),-12*3)
  FROM dual;

SELECT last_day(to_date('2025-02-01','yyyy-mm-dd'))
  FROM dual;

SELECT to_char(sysdate,'day')
  FROM dual;

SELECT to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')
  FROM dual;

SELECT to_char(sysdate,'mon'),to_char(sysdate,'month')
  FROM dual;
 
SELECT orderdate, orderdate + 7   
  FROM orders

SELECT sysdate, systimestamp
  FROM dual;

-- 매개값보다 같거나 큰 정수
SELECT ceil(15.7) --// 16
  FROM dual;

SELECT ceil(-15.7) --// -15
  FROM dual;

-- 매개값보다 같거나 작은 정수
SELECT floor(15.7) --// 15
  FROM dual;

SELECT floor(-15.7) --// -16
  FROM dual;

-- 소수점 절사
SELECT trunc(15.7) --// 15
  FROM dual;

SELECT trunc(-15.7) --// -15
  FROM dual;

SELECT TRIM(LEADING 0 FROM '00AA00'), ltrim('00AA00','0'),
       TRIM(TRAILING 0 FROM '00AA00'), rtrim('00AA00','0')
  FROM dual;

-- 첫번째 매개값이 null이면 두번째 매개값으로 평가
SELECT name "이름",nvl(phone,'연락처없음') "연락처"
  FROM customer;

-- 첫번째 매개값이 null이면 세번째 매개값으로 평가 null이 아니면 두번째 매개값으로 평가
SELECT name "이름",nvl2(phone,'연락처있음','연락처없음') "연락처"
  FROM customer;

-- 첫번째 매개값이 두번째 매개값(원하지 않는 값)으로 평가되면 null을 반환
-- 첫번째 매개값과 두번째 매개값이 같으면 null을 반환 같지않으면 첫번째 매개값 반환
SELECT NULLIF(원하는값, 원하지 않는값)
  FROM dual;

SELECT 10 / nullif(0,0)
  FROM dual;

SELECT decode(1,1,'aa','bb')
  FROM dual;

SELECT * FROM courses;
UPDATE COURSES
   SET credit = 1
 where course_id = 'C001';  
COMMIT;

SELECT DECODE(credit,3,'선택과목',
										 4,'필수과목',
										 1,'교양','기타')
  FROM courses;

-- 단순 case
SELECT CASE credit
				 WHEN 1 THEN '교양'
				 WHEN 2 THEN '선택'
				 WHEN 3 THEN '필수'
				 ELSE '기타'
				end "교양/선택/필수"
  FROM courses;

SELECT CASE  
					WHEN price < 10000 THEN '저가'
					WHEN price BETWEEN 10000 AND 30000 THEN '중가'
					WHEN price > 30000 THEN '고가'
					ELSE '기타'
				END "분류" 					
  FROM book;w

