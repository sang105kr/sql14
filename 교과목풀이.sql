--테이블삭제
drop table department;
drop table employee;
drop table project;
drop table works;

--문제1) 테이블 생성
  
--1) department
create table department(
    deptno      number(2) PRIMARY KEY ,
    deptname    varchar2(20)  NOT NULL UNIQUE,
    manager     number(4)
--    FOREIGN key(manager) REFERENCES employee(empno)
);

--2) employee
create table employee(
    empno       number(4) PRIMARY KEY,
    name        varchar2(20) NOT NULL ,
    phoneno     varchar2(20),
    address     varchar2(20),
    sex         char(3) CHECK (sex IN('남','여')),
    position    varchar2(20),
    salary      number(7) DEFAULT 0,
    deptno      number(2),
    FOREIGN key(deptno) REFERENCES department(deptno)
);

--3) project
create table project(
    projno      number(3) PRIMARY KEY,
    projname    varchar2(20) NOT null,
    deptno      number(2),
    FOREIGN key(deptno) REFERENCES department(deptno)
);

--4) works
create table works(
    projno      number(3),
    empno       number(4),
    hoursworked number(3) CHECK (hoursworked > 0),
    PRIMARY KEY (projno, empno),
    FOREIGN key(projno) REFERENCES project(projno),
    FOREIGN key(empno) REFERENCES employee(empno)
);


--문제5)
drop sequence employee_empno_seq;
drop sequence department_deptno_seq;
drop sequence project_projno_seq;

create sequence employee_empno_seq start with 1001;
create sequence department_deptno_seq start with 10 INCREMENT BY 10;
create sequence project_projno_seq start with 101;


--문제6) 데이터 insert
--샘플 데이터 생성
insert into department (deptno, deptname) values (department_deptno_seq.nextval, '전산팀');
insert into department (deptno, deptname) values (department_deptno_seq.nextval, '회계팀');
insert into department (deptno, deptname) values (department_deptno_seq.nextval,'영업팀');
insert into department (deptno, deptname) values (department_deptno_seq.nextval, '총무팀');
insert into department (deptno, deptname) values (department_deptno_seq.nextval,'인사팀');

insert into project values (project_projno_seq.nextval, '빅데이터구축', 10);
insert into project values (project_projno_seq.nextval, 'IFRS', 20);
insert into project values (project_projno_seq.nextval, '마케팅', 30);

insert into employee values (employee_empno_seq.nextval,'홍길동1','010-111-1001','울산1','남','팀장',7000000,10);
insert into employee values (employee_empno_seq.nextval,'홍길동2','010-111-1002','울산2','남','팀원1',4000000,10);
insert into employee values (employee_empno_seq.nextval,'홍길동3','010-111-1003','울산3','남','팀원2',3000000,10);
insert into employee values (employee_empno_seq.nextval,'홍길동4','010-111-1004','부산1','여','팀장',6000000,20);
insert into employee values (employee_empno_seq.nextval,'홍길동5','010-111-1005','부산2','남','팀원1',3500000,20);
insert into employee values (employee_empno_seq.nextval,'홍길동6','010-111-1006','부산3','남','팀원2',2500000,20);
insert into employee values (employee_empno_seq.nextval,'홍길동7','010-111-1007','서울1','남','팀장',5000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동8','010-111-1008','서울2','남','팀원1',4000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동9','010-111-1009','서울3','남','팀원2',3000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동10',null,'서울4','남','팀원3',2000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동11','010-111-1011','대구1','여','팀장',5500000,40);
insert into employee values (employee_empno_seq.nextval,'홍길동12','010-111-1012','대구2','남','팀원1',2000000,40);
insert into employee values (employee_empno_seq.nextval,'홍길동13','010-111-1013','제주1','남','팀장',6500000,50);
insert into employee values (employee_empno_seq.nextval,'홍길동14','010-111-1014','제주2','남','팀원1',3500000,50);

insert into works values (101, 1001, 800);
insert into works values (101, 1002, 400);
insert into works values (101, 1003, 300);
insert into works values (102, 1004, 700);
insert into works values (102, 1005, 500);
insert into works values (102, 1006, 200);
insert into works values (103, 1007, 500);
insert into works values (103, 1008, 400);
insert into works values (103, 1009, 300);
insert into works values (103, 1010, 200);

--부서 데이터 insert-> 사원 데이터 insert-> update 부서 테이블
update department set manager = 1001 where deptno = 10;
update department set manager = 1004 where deptno = 20;
update department set manager = 1007 where deptno = 30;
update department set manager = 1011 where deptno = 40;
update department set manager = 1013 where deptno = 50;
commit;

--7. 사원 중 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
    select substr(name,1,1) "성", count(*) "인원수"
      from employee
  group by substr(name,1,1);  

--8. ‘영업팀’ 부서에서 일하는 사원의 이름, 연락처, 주소를 보이시오. (단 연락처 없으면 ‘연락처 없음’ , 연락처 끝4자리 중 앞2자리는 별표 * 로 표시하시오. 예) 010-111-**78 )
    select t1.name, nvl2(t1.phoneno,substr(t1.phoneno,1,8) || '**' || substr(t1.phoneno,11,2),'연락처없음')   , t1.address
      from employee t1 join department t2 on t1.deptno = t2.deptno
     where t2.deptname = '영업팀' ;

--9. ‘홍길동7’ 팀장(manager) 부서에서 일하는 팀원의 수를 보이시오. 
select count(*) "팀원수"
  from employee
 where deptno = ( select t1.deptno
                    from employee t1 join department t2 on t1.empno = t2.manager
                   where t1.name = '홍길동7' )
  and name != '홍길동7';   

--10. 프로젝트에 참여하지 않은 사원의 이름을 보이시오.
--case1) 외부조인
select t1.name
  from employee t1 left outer join works t2 on t1.empno = t2.empno
 where t2.projno is null;
--case2) 집합연산자
 select name
   from employee 
  where empno not in ( select distinct empno
                         from works );
 --case3) 차집합
 select name
   from employee
  where empno in ( select empno
                     from employee 
                    minus
                    select distinct empno
                      from works);
 --case4) 상관쿼리이용                     
 select t1.name
   from employee t1
  where not exists ( select t1.empno
                       from works
                      where empno = t1.empno );

--11. 급여 상위 TOP 3를 순위와 함께 보이시오.
--case1)
select t1.empno "사번", t1.name "이름", t1.salary "급여", 
       rank() over(order by salary desc) as "순위" 
  from employee t1
fetch first 3 rows only;
--case2)  
select t1.* ,rownum 
  from (select *
          from employee
        order by salary desc ) t1
fetch first 3 rows only;    

--12. 사원들이 일한 시간 수를 부서별, 사원 이름별 오름차순으로 보이시오. 
    select t3.deptname "부서명", t2.name "사워명", sum(t1.hoursworked) "일한시간"
      from works t1 join employee t2 on t1.empno = t2.empno
                    join department t3 on t2.deptno = t3.deptno
  group by t3.deptname, t2.name
  order by t3.deptname, t2.name;

--13. 부서별로 급여가 부서평균 급여 보다 높은 사원의 이름과 월급을 보이시오.
select t3.name, t3.salary
  from employee t3
 where t3.salary > (    select avg(t1.salary)
                          from employee t1 join department t2 on t1.deptno = t2.deptno
                      group by t2.deptno
                        having t2.deptno = t3.deptno );

--14. 2명 이상의 사원이 참여한 프로젝트의 번호, 프로젝트명, 사원의 수를 보이시오. 
    select t1.projno "프로젝트 번호",t2.projname "프로젝트명", count(*) "사원수"
      from works t1 join project t2 on t1.projno = t2.projno
  group by t1.projno, t2.projname
    having count(*) >= 2;     
  
  select t3.projno "프로젝트 번호", t3.projname "프로젝트명", count(*) "사원수"
    from employee t1 join works t2 on t1.empno = t2.empno
                     join project t3 on t2.projno = t3.projno   
   where t3.projno in ( select projno
                          from works 
                      group by projno
                      having count(*) >= 2 )     
group by  t3.projno, t3.projname;

--15. 프로젝트에 참여시간이 가장 많은 사원과 적은 사원의 이름을 보이시오.
--case1) 합집합
select (select name from employee where empno = t1.empno),
       sum(hoursworked)
  from works t1
group by empno
having sum(hoursworked) = ( select max(sum(hoursworked))
                              from works
                          group by empno)   
union
select (select name from employee where empno = t1.empno),
        sum(hoursworked)
  from works t1
group by empno
having sum(hoursworked) = ( select min(sum(hoursworked))
                              from works
                          group by empno); 

--case2) 집합연산자 
  select (select name from employee where empno = t1.empno) "이름",
          sum(hoursworked) "프로젝트참여시간"
    from works t1
group by empno
  having sum(hoursworked) in (( select min(sum(hoursworked))
                                  from works
                              group by empno),
                             (select max(sum(hoursworked))
                                from works
                            group by empno));     

--16. 팀장의 급여를 10%인상하고 인상된 결과를 보이시오. (단, department테이블을 활용할 것)
update employee
   set salary = salary * 1.1
 where empno in ( select manager
                    from department );
select name,position,salary from employee  
 where empno in ( select manager
                    from department );

--17. 사원이 참여한 프로젝트에 대해 사원명, 프로젝트명, 참여시간을 보이는 뷰를 작성하시오.
create view project_vw as
    select t1.name, t3.projname, t2.hoursworked
      from employee t1 join works t2 on t1.empno = t2.empno
                       join project t3 on t2.projno = t3.projno;
select * from project_vw;

--18. employee 테이블의 name 열을 대상으로 인덱스를 생성하시오. 
DROP INDEX idx_employee_name;
create index idx_employee_name on employee(name);
select *
  from user_indexes
 where table_name = 'EMPLOYEE'
   and index_name = 'IDX_EMPLOYEE_NAME';  






