--
-- Copyright (c) Oracle Corporation 1988, 1999.  All Rights Reserved.
--
--  NAME
--    demobld.sql
--
-- DESCRIPTION
--   This script creates the SQL*Plus demonstration tables in the
--   current schema.  It should be STARTed by each user wishing to
--   access the tables.  To remove the tables use the demodrop.sql
--   script.
--
--  USAGE
--       SQL> START demobld.sql
--
--

SET TERMOUT ON
PROMPT Building demonstration tables.  Please wait.
SET TERMOUT OFF

DROP TABLE EMP;
DROP TABLE DEPT;
DROP TABLE BONUS;
DROP TABLE SALGRADE;
DROP TABLE DUMMY;

CREATE TABLE EMP
       (EMPNO NUMBER(4) NOT NULL,
        ENAME VARCHAR2(10),
        JOB VARCHAR2(9),
        MGR NUMBER(4),
        HIREDATE DATE,
        SAL NUMBER(7, 2),
        COMM NUMBER(7, 2),
        DEPTNO NUMBER(2));

INSERT INTO EMP VALUES
        (7369, 'SMITH',  'CLERK',     7902,
        TO_DATE('17-DEC-1980', 'DD-MON-YYYY'),  800, NULL, 20);
INSERT INTO EMP VALUES
        (7499, 'ALLEN',  'SALESMAN',  7698,
        TO_DATE('20-FEB-1981', 'DD-MON-YYYY'), 1600,  300, 30);
INSERT INTO EMP VALUES
        (7521, 'WARD',   'SALESMAN',  7698,
        TO_DATE('22-FEB-1981', 'DD-MON-YYYY'), 1250,  500, 30);
INSERT INTO EMP VALUES
        (7566, 'JONES',  'MANAGER',   7839,
        TO_DATE('2-APR-1981', 'DD-MON-YYYY'),  2975, NULL, 20);
INSERT INTO EMP VALUES
        (7654, 'MARTIN', 'SALESMAN',  7698,
        TO_DATE('28-SEP-1981', 'DD-MON-YYYY'), 1250, 1400, 30);
INSERT INTO EMP VALUES
        (7698, 'BLAKE',  'MANAGER',   7839,
        TO_DATE('1-MAY-1981', 'DD-MON-YYYY'),  2850, NULL, 30);
INSERT INTO EMP VALUES
        (7782, 'CLARK',  'MANAGER',   7839,
        TO_DATE('9-JUN-1981', 'DD-MON-YYYY'),  2450, NULL, 10);
INSERT INTO EMP VALUES
        (7788, 'SCOTT',  'ANALYST',   7566,
        TO_DATE('09-DEC-1982', 'DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO EMP VALUES
        (7839, 'KING',   'PRESIDENT', NULL,
        TO_DATE('17-NOV-1981', 'DD-MON-YYYY'), 5000, NULL, 10);
INSERT INTO EMP VALUES
        (7844, 'TURNER', 'SALESMAN',  7698,
        TO_DATE('8-SEP-1981', 'DD-MON-YYYY'),  1500,    0, 30);
INSERT INTO EMP VALUES
        (7876, 'ADAMS',  'CLERK',     7788,
        TO_DATE('12-JAN-1983', 'DD-MON-YYYY'), 1100, NULL, 20);
INSERT INTO EMP VALUES
        (7900, 'JAMES',  'CLERK',     7698,
        TO_DATE('3-DEC-1981', 'DD-MON-YYYY'),   950, NULL, 30);
INSERT INTO EMP VALUES
        (7902, 'FORD',   'ANALYST',   7566,
        TO_DATE('3-DEC-1981', 'DD-MON-YYYY'),  3000, NULL, 20);
INSERT INTO EMP VALUES
        (7934, 'MILLER', 'CLERK',     7782,
        TO_DATE('23-JAN-1982', 'DD-MON-YYYY'), 1300, NULL, 10);

CREATE TABLE DEPT
       (DEPTNO NUMBER(2),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE BONUS
        (ENAME VARCHAR2(10),
         JOB   VARCHAR2(9),
         SAL   NUMBER,
         COMM  NUMBER);

CREATE TABLE SALGRADE
        (GRADE NUMBER,
         LOSAL NUMBER,
         HISAL NUMBER);

INSERT INTO SALGRADE VALUES (1,  700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

CREATE TABLE DUMMY
        (DUMMY NUMBER);

INSERT INTO DUMMY VALUES (0);

COMMIT;

SET TERMOUT ON
PROMPT Demonstration table build is complete.

EXIT

select * from emp;
select * from dept;
select * from bonus;
select * from salgrade;
*************************************************************************************************************************************

create table suppl(
supno varchar(10) primary key,
sname varchar(20) not null,
status number(4) check(status<50),
city varchar(20)
);

create table pts(
partno varchar(10) primary key,
pname varchar(20) not null,
color varchar(20) check(color='red' or color='blue' or color='green'),
weight number(4),
city varchar(20)
);

create table shpts(
supno varchar(10),
partno varchar(10),
qty number(4),
constraint abc primary key (supno,partno),
constraint pqr foreign key (supno) references suppl(supno),
constraint xyz foreign key (partno) references pts(partno)
);

insert into suppl values('&supno','&sname','&status','&city');

SELECT * FROM suppl;

insert into pts values('&partno','&pname','&color','&weight','&city');

SELECT * FROM pts;

insert into shpts values('&supno','&partno','&qty');

select * from shpts;

**********************************************************************************************************************************

# Oracle as calculator

select 5+6*9 from dual;

select power(5,5) from dual;

select log(10,100) from dual;

*********************************************************************************************************************************

# Date Display

select sysdate from dual;

select sysdate , to_char(sysdate,'dd day dy mm mon month yy yyyy hh hh24 mi ss q ddspth') from dual;

select sysdate, to_char( sysdate,' w ww ddd syear') from dual;


# Date Function

* Add date & months

select add_months(sysdate,7) from dual;

select add_months(sysdate,-7) from dual;

select add_months(sysdate,1.5) from dual;

select add_months(sysdate,0)+45 from dual;

select add_months(sysdate,1)+15 from dual;

select to_char(to_date('20-jan-2020'),'day') from dual;

* Months Between

select 30-months_between(sysdate,'20-jan-2019')/12 from dual;

* Last day

select last_day('1-FEB-2020') from dual;

select last_day('1-feb-2020') - to_date('21-feb-2020') as answer from dual\;

* Next day

select next_day(Sysdate,'wed') from dual;

select sysdate+100 from dual;

**************************************************************************************************************************************

# Aggregate Function

Sum
Avg
Min
Max
Count

Select max(sal) from emp;

Select min(sal) from emp;

Select avg(sal) from emp;

Select sum(sal) from emp;

Select count(sal) from emp;

Select round(avg(sal),2) , avg(sal) from emp;

Select count(empno) from emp;

Select * from emp where comm=0;

Select * from emp where comm<>0;

Select * from emp where comm is null;

Select * from emp where comm is not null;

Select count(empno), count(*), count(sal), count(comm), count(job) from emp;

Select count(ename), count(hiredate), count(comm), count(job) from emp;

Select count(job) from emp;

Select distinct(job) from emp;

Select count(job),count(distinct job) from emp;

**********************************************************************************************************************************

# String Function

Create table temp(
name varchar(10),
name2 char(10)
);

Insert into temp values('&n','&m');

Select * from temp

1. Length -

Select name,length(name), name2,length(name2) from temp;

2. LTRIM/RTRIM -

Select name,LTRIM(name,'ab') from temp;

Select ename,sal,RTRIM(Sal,'0') from emp;

Select name2,length(RTRIM(name2,' ')) from temp;

3. LPAD/RPAD -

Select ename, sal,LPAD(sal,10,'*') from emp;

Select ename, sal,RPAD(LPAD(sal,10,'*'),20,'*') from emp;

Select ename, sal,LPAD(sal,10,'*'),RPAD(LPAD(sal,10,'*'),20,'P') from emp;

Select ename, sal,LPAD(sal,10,'*'),RPAD(LPAD(sal,10,'*'),20,'o') from emp;

Select ename, sal,RPAD(LPAD(sal,10,'*'),2,'*') from emp;

Select ename,sal,RPAD(sal,3,'*') from emp;

Select ename,sal,LPAD(sal,3,'*') from emp;

4. Decode -

Select ename,job,sal,DECODE(job,'PRESIDENT',1,'MANAGER',2,'ANALYST',3,4) as grade from emp;

5. INSTR -

Select ename,INSTR(ename,'A'),INSTR(ename,'A',3) from emp where INSTR(ename,'A')<>0;

Select ename,INSTR(ename,'A') from emp;

Select ename,INSTR(ename,'A',3) from emp;

Select ename,INSTR(ename,'A',3) from emp where INSTR(ename,'A',3)=3;

Select ename,INSTR(ename,'A') from emp where INSTR(ename,'A')<>0;

6. Upper/Lower -

Select ename,lower(ename),job,upper(job) from emp;

7. INITCAP -

Select ename,INITCAP(ename) from emp;

***************************************************************************************************************************************

# Sequence

********************************   NO CYCLE ******************************

Create sequence Nitesh
start with 1
maxvalue 10
nocycle
increment by 1;

select nitesh.nextval from dual;

alter sequence nitesh  maxvalue 100

select * from user_sequences;                                                                          

Create sequence Ramola;

select ramola.nextval from dual;

select ename,job,sal,ename||' '||job||' '||sal as mix from emp;

select * from suppl;

Insert into suppl values('s'||nitesh.nextval,'&sname','&status','&city');

****************************************** CYCLE **********************************

Create sequence NR
start with 5
maxvalue 10
minvalue 4
increment by 1
cycle
cache 3;

select NR.nextval from dual;

***********************************************************************************************************************************

# SUB_QUERIES -

Q- Display the name of the emp who do same job as Smith ?
Ans.
        Select ename from emp where job=(Select job from emp where ename='SMITH');
        
Q- Display the name of emp working in the same department as Miller ?
Ans.
        Select ename from emp where deptno=(Select deptno from emp where ename='MILLER');
        
Q- Display the name,job,sal of all the emp getting the same salary as that of Martin ?
Ans.
        Select ename,job,sal from emp where sal=(Select sal from emp where ename='MARTIN');
        
Q- Display the name of the emp getting the same salary as Ford ?
Ans.
        Select ename from emp where sal=(Select sal from emp where ename='FORD');
        
Q- Display the name of the emp working in same Department as King ?
Ans.
        Select ename from emp where deptno=(Select deptno from emp where ename='KING');
        
Q- Display the name of emp who have joined in same month as Ford ?
Ans.
        Select ename,to_char(hiredate,'MON') from emp where to_char(hiredate,'MON')=(Select to_char(hiredate,'MON') from emp where ename='FORD');
        
Q- Display the name of emp working under King ?
Ans.
        Select ename from emp where mgr=(Select empno from emp where ename='KING');
        
Q- Find out the Longest emp name ?
Ans.
        Select ename from emp where length(ename)=(Select max(length(ename)) from emp);
        
Q- Find out the second highest salary ?
Ans.
        Select max(sal) from emp where sal<(Select max(sal) from emp);
    
# Rownum & Rowid -

Select rownum,rowid from emp;

# Danger of usnig the rownum -

Select * from emp where rownum=3;

Select * from emp where rownum<=3;

Select * from emp where rownum>=3;

Select * from (select ename,job,sal,rownum r,deptno,comm,hiredate from emp) where r=3;

# Sorting -

Select ename,job,sal from emp order by sal;

Select ename,job,sal from emp order by sal desc;

Select ename, job,sal,deptno from emp order by 4,3 ; 

############################################ Where clause has higher priorty than the order by #################################################

Select ename,sal from emp order by sal where rownum<=5;

Select ename,sal,job from (Select ename,job,sal from emp order by sal desc) where rownum<=5;

###### How we display the alternate row in table #######################

Select * from emp where (rowid,1) in( select rowid,MOD(Rownum,2) from emp);

Select ename,job from (Select ename,job,sal,mod(rownum,2) as a from emp) where a=0;

Select mod(rownum,2),rownum from emp;

Select mod(17,6) from dual;

***************************************************************************************************************************************

# Join -

    Join allow us to extract the meanigful data from more than one table based on some coloumn which is common to them.
    
Q. Display a supplier no ,supname & qty supplied by each supplier ?
Ans.
        Select s.supno,sname,qty from suppl s,shpts t where s.supno=t.supno;
        
Q. Display the supplier no., supplier name & partno, partname,qty of each part supplied by each supplier ?
Ans.
        Select s.supno,s.sname,p.partno,p.pname,qty from suppl s,shpts t, pts p where s.supno=t.supno and t.partno=p.partno;

Q. Display the empno,ename,sal, deptno, deptname & loc for all the emp ?
Ans. 
        Select ename ,job,sal,e.deptno,dname,loc from emp e, dept d where e.deptno=d.deptno;
        
Q. Display the emp name along with bosses name ?
Ans.
        Select e.ename as subordinate,b.ename as boss , e.empno,b.empno from emp e, emp b where e.empno=b.empno;
        
Q. Display the different pairs of employee doing the same job but at different dept ?
Ans.
        Select a.ename,b.ename,a.deptno,b.deptno from emp a, emp b where a.job=b.job and a.deptno>b.deptno;
        
Q. Display the total amount of salary paid to each department ?
Ans.
        Select deptno,sum(sal) from emp group by deptno;
        
Q. Find out the no. of temp join in each month ?
Ans.
        Select to_char(hiredate,'mon'),count(empno) from emp group by to_char(hiredate,'mon');
        Select to_char(hiredate,'mon'),count(empno) from emp group by rollup(to_char(hiredate,'mon'));

Q. Find out no. of emp in each category of job ?
Ans. 
        Select job,count(empno) from emp group by job;
        Select job,count(empno) from emp group by rollup(job);
        
Q. Find out the min & max sal in each category of job ?
Ans. 
        Select min(sal),max(sal),job from emp group by job;
        Select min(sal),max(sal),job from emp group by rollup(job);
        
Q. Find out the no. of emp working in each department ?
Ans.
        Select deptno,count(empno) from emp group by deptno;
        
Q. Find out the total amount of sal paid to each dept but it should include only those dept whose total sal is more than 10,000 ?
Ans.
        Select deptno,total from (Select deptno ,sum(sal) as total from emp group by deptno) where total>10000;
        Select deptno , sum(sal) from emp group by deptno having sum(sal)>10000;
        
Q. Display the deptno,deptname,loc & the no. of emp in each dept ?
Ans.
        Select d.deptno,dname,loc, count(empno) from emp e,dept d where e.deptno=d.deptno group by d.deptno,dname,loc;

Q. Display the deptno,dname,loc & no. of emp in each dept, it should also include those dept in which no body is working with zero in front of it?
Ans.
        Select d.deptno,dname,loc,count(empno) from emp e,dept d where e.deptno(+)=d.deptno group by d.deptno,dname,loc;

*************************************************************************************************************************************

# Making Changes to the str of the table -

Create table tdf
(
supno varchar(4),
sname varchar(10) not null,
status number(4),
city varchar(10),
constraint abc2 primary key(supno),
constraint xyz2 check (status<50)
)

insert into tdf values('s1','sham',20,'mum')
insert into tdf values('s2','ram',25,'kol')
insert into tdf values('s3','sham',20,'mum')

Select * from tdf;

Select * from user_constraints;
Select * from user_constraints where table_name='tdf';

Select * from user_cons_columns;
Select * from user_cons_columns where table_name='tdf';

Select a.constraint_name,a.constraint_type,b.column_name from user_constraints a,user_cons_columns b                     //Error//////////////////////////
where a.constraint_name=b.constraint_name and a.table_name='tdf';

alter table tdf modify sname varchar(4);
desc tdf;

create table ppp(
rollno number(4) not null,
name varchar(10)
)

insert into ppp values(1001,'ajay')
insert into ppp values(1001,'sanjay')
insert into ppp values(1002,'vijay')

Select * from ppp;

delete from ppp where name='sanjay';

alter table ppp add constraint yul primary key(rollno);

alter table ppp drop constraint yul;

alter table ppp add contraint xyz3 not null(name);

Select a.constraint_name,a.constraint_type,b.column_name from user_constraints a, user_cons_columns b                        //Error///////////////////
where a.constraint_name=b.constraint_name and a.table_name='ppp';

create table adf(
name varchar(10),
rollno varchar(10)
)

insert into adf values('nitesh',1000)

alter table adf drop column rollno;

alter table adf add bdt date;

insert into adf values('sohan',sysdate)
insert into adf values('ram',sysdate)

alter table adf drop column bdt;

alter table adf add bdt date default sysdate;

alter table adf add grade varchar(10) default 'b';

alter table adf rename column grade to nitesh;

Select * from adf;

**********************************************************************************************************************************

# Making changes to the content of the table -

Q. Give a commision of Rs.200 to all clerk ?
Ans.
        Update emp set comm=200 where job='CLERK';
        Select * from emp;
        Rollback;
        
Q. Increment the salary of all the emp by 105 of existing salary ?
Ans.
        Update emp set sal=sal*1.1;
        Select * from emp;
        Rollback;
        
Q. Make the salary of Smith same as that of Ford ?
Ans.
        Update emp set Sal=(Select sal from emp where ename='FORD') where ename='SMITH';
        Select * from emp;
        Rollback;
        
        Update emp set ename=lower(ename);
        Select * from(Select ename,rownum r from emp) where r between 3 and 5;
        
Q. Display the 5th highest paid emp ?
Ans.
        Select rownum,ename,job,sal from emp order by sal desc;
        
        Select min(sal) from(Select rownum,ename,job,sal from emp order by sal desc) where rownum<=2;
        
        Select min(sal) from(Select distinct sal from emp order by sal desc) where rownum<=&N;
        
        Select ename,job,sal,rownum,rowid from emp where rownum<=5 order by sal desc;
        
        Select ename,job,sal,r from(select ename,job,sal,rownum as r from emp order by sal desc) where rownum<=5;
        
        Select min(sal) from(Select ename,job,sal,r from(Select ename,job,sal,rownum as r from emp order by sal desc)) where rownum<=&N;

*************************************************************************************************************************************

# View -

Create view v1 as
select ename,job,sal from emp;

Select * from v1;

Create view v2 as 
Select ename,dname,job from emp,dept where emp.deptno=dept.deptno;

Select * from v2;

commit;
************************************************************************************************************************************

Q. Display date 26-January-2020 and also week of year ?
Ans.
        Select to_char(sysdate,'dd month yyyy hh') from dual;
        
Q. Assign grade to emp as follows 
    President=1,Manager=2,Analyst=3,other=4 ?
Ans.`
        Select ename,job,sal,DECODE(job,'PRESIDENT',1,'MANAGER',2,'ANALYST',3,4) as grade from emp;
        
Q. Display all the emp whose name start with 'A' but not with like operator ?
Ans.
        Select ename from emp where Ascii(ename)=65
        
        Select ename,Instr(Ename,'A',1) from emp where Instr(Ename,'A',1)=1;
        
Q. Cycle sequence with example ?
Ans.
        Create Sequence Panipat
        Start with 1
        Cycle
        Increment by 1
        Maxvalue 5
        Minvalue 0
        cache 3;
        
        select Panipat.nextval from dual;
        
Q. Display all the emp working in same dept as Miller ?
Ans.
        Select * from emp where deptno=(Select deptno from emp where ename='MILLER');
        
Q. Display all the emp working under the King ?
Ans.
        Select * from emp where mgr=(Select empno from emp where ename='KING');
        
Q. Display all the emp who Joined as same month of Ford ?
Ans.
        Select ename,to_char(hiredate,'MON') from emp where to_char(hiredate,'MON')=(Select to_char(hiredate,'MON') from emp where ename='FORD');
        
Q. Display the 2nd highest salary of emp ?
Ans.
        Select max(sal) from emp where sal<(Select max(sal) from emp);
        
Q. Display longest emp name ?
Ans.
        Select ename from emp where length(ename)=(Select max(length(ename)) from emp);
                
Q. Assuming that a table has n-duplicate rows & delete all other duplicate & keep only 1 ?
Ans. 
        Create table temporary(
        rollno number(5) not null,
        sname varchar(10)
        );
    
        Insert into temporary values('1','Nitesh')
        
        Select * from temporary
        
        Delete from temporary where rowid not in(Select max(rowid) from TEMPORARY);

Q. Display the 5 highest paid emp ?
Ans.
        Select * from (Select ename from emp order by sal desc) where rownum<=5;
        
Q. Display name ,job,sal where job is equal to clerk,salesman,manager ?
Ans.
        Select ename,job,sal from emp where job in('CLERK' ,'SALESMAN','MANAGER');
        
Q. Display the name end with 's' with like operator ?
Ans.
        Select ename from emp where ename  like '%S';
        
Q. Display the emp name with boss name ?
Ans.
        Select e.ename,b.ename, e.empno,b.empno from emp e, emp b where e.empno=b.mgr;
        
Q. Find out the number of emp joined in each month ?
Ans.
        Select to_char(hiredate,'mon') as months,count(empno) as numberOfEmp from emp group by to_char(hiredate,'mon');
        
Q. Find out the total salary paid to each department and only include those department whose total sal is greater than 10000 ?
Ans.
        Select deptno,sum(sal) from emp group by deptno having sum(sal)>10000;
        
Q. Display the deptno,deptname,location and number of emp working in each dept it also include those dept in which no body is working with zero in front of it ?
Ans.
        Select d.deptno,dname,loc,count(empno) from emp e,dept d where e.deptno(+)=d.deptno group by d.deptno,dname,loc;
        
Q. Give a commision of rs.200 to all clerk ?
Ans. 
        Update emp set comm=200 where job='CLERK';
            
        Select * from emp;
        
        rollback;
        
Q. Display the 5th highest sal of the emp ?
Ans. 
        Select min(sal) from(Select sal from emp order by sal desc) where rownum<=5;
        
        Select min(sal) from( Select distinct sal  from emp order by sal desc) where rownum<=5;
        
Q. Write the PL/SQL code to increment the sal of an emp 
    As follows
    For President increment by 10%
    For Manager increment by 15%
    For Analyst increment by 20%
    For all other 2000 Rs
Ans.
        Set Serveroutput on;
    
        Declare
                eno emp.empno%type:=&empno;
                ejob emp.job%type;
                esal emp.sal%type;
        Begin
                Select job,sal into ejob, esal from emp where empno=eno;
                
                dbms_output.put_line('Old Salary = '|| esal);
                
                if ejob='PRESIDENT' then
                    esal:=esal*1.1;
                elsif ejob='MANAGER' then
                    esal:=esal*1.15;
                elsif ejob='ANALYST' then
                    esal:=esal*1.20;
                else
                    esal:=esal+2000;
                    
                end if;
                
                dbms_output.put_line('New Salary = '|| esal);
                
                update emp
                Set sal=esal where empno=eno;
                
                End;
                 
Q. Write a PL/SQL code to accept a name & convert every alternate alphabet into upper case ?
Ans.
        Declare
            name varchar(10):=&name;
        Begin
            while (len(name)<10)
            if(len(name)%2) then
             name:=upper(name);
            else
             name:=lower(name);
            
            end if;
            dbms_output.put_line('name=',name);
            end;
            