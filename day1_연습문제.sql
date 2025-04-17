--1.마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
--  (1) 도서번호가 1인 도서의 이름
    select bookname "도서 이름"
      from book 
     where bookid = 1;
--  (2) 가격이 20,000원 이상인 도서의 이름
    select bookname "도서 이름"
      from book 
     where price >= 20000;
--  (3) 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
    select sum(saleprice) "총구매액"
      from orders 
     where custid = 1;
--  (4) 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성)
    select count(*) "도서수"
      from orders
     where custid = 1; 
--
-- 
--2.마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
--(1) 마당서점 도서의 총 개수
    select count(*) "도서건수"
      from book;
--(2) 마당서점에 도서를 출고하는 출판사의 총 개수
    select count(distinct publisher) "출판사 총개수"
      from book;
--(3) 모든 고객의 이름, 주소
    select name "이름",address "주소"
      from customer;
--(4) 2020년 7월 4일~7월 7일 사이에 주문 받은 도서의 주문번호
    select orderid "주문번호"
      from orders
     where orderdate between '20200704' and '20200707';

    select orderid "주문번호"
      from orders
     where orderdate >= '20200704' 
       and orderdate <= '20200707';
     
--(5) 2020년 7월 4일~7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호
    select orderid "주문번호"
      from orders
     where orderdate not between '20200704' and '20200707';

    select orderid "주문번호"
      from orders
     where not(orderdate >= '20200704' 
       and orderdate <= '20200707');
       
    select orderid "주문번호"
      from orders
     where orderdate < '20200704' 
        or orderdate > '20200707';       
        
--(6) 성이 ‘김’ 씨인 고객의 이름과 주소
    select name "이름", address "주소"
      from customer
     where name like '김%'; 

--(7) 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 이름과 주소
    select name "이름", address "주소"
      from customer
     where name like '김%아'; 
