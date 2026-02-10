create database project_sql;

use project_sql;

drop table if exists Emp;

create table Emp (
   Empno int primary key,
   Ename varchar(10) default null,
   Job varchar(9) default null,
   Mgr int default null,
   Hiredate date default null,
   Sal decimal(7,2) default null,
   Comm	decimal(7,2) default null,
   Deptno int default null,
   Index (Deptno)
);

insert into Emp (Empno, Ename, Job, Mgr, Hiredate, Sal, Comm, Deptno)
values 
   (7369, 'SMITH',  'CLERK',     7902, '1980-12-17',  800.00,  NULL, 20),
   (7499, 'ALLEN',  'SALESMAN',  7698, '1981-02-20', 1600.00, 300.00, 30),
   (7521, 'WARD',   'SALESMAN',  7698, '1981-02-22', 1250.00, 500.00, 30),
   (7566, 'JONES',  'MANAGER',   7839, '1981-04-02', 2975.00,  NULL, 20),
   (7654, 'MARTIN', 'SALESMAN',  7698, '1981-09-28', 1250.00, 1400.00, 30),
   (7698, 'BLAKE',  'MANAGER',   7839, '1981-05-01', 2850.00,  NULL, 30),
   (7782, 'CLARK',  'MANAGER',   7839, '1981-06-09', 2450.00,  NULL, 10),
   (7788, 'SCOTT',  'ANALYST',   7566, '1987-06-11', 3000.00,  NULL, 20),
   (7839, 'KING',   'PRESIDENT', NULL, '1981-11-17', 5000.00,  NULL, 10),
   (7844, 'TURNER', 'SALESMAN',  7698, '1981-08-09', 1500.00,    0.00, 30),
   (7876, 'ADAMS',  'CLERK',     7788, '1987-07-13', 1100.00,  NULL, 20),
   (7900, 'JAMES',  'CLERK',     7698, '1981-03-12',  950.00,  NULL, 30),
   (7902, 'FORD',   'ANALYST',   7566, '1981-03-12', 3000.00,  NULL, 20),
   (7934, 'MILLER', 'CLERK',     7782, '1982-01-23', 1300.00,  NULL, 10);
   
select * from Emp;

create table Dept (
   Deptno int primary key,
   Dname varchar(14) default null,
   Loc varchar(13) default null
);

INSERT INTO Dept (Deptno, Dname, Loc) 
VALUES
   (10, 'ACCOUNTING', 'NEW YORK'),
   (20, 'RESEARCH',   'DALLAS'),
   (30, 'SALES',      'CHICAGO'),
   (40, 'OPERATIONS', 'BOSTON');

select * from Dept;

create table Student (
   Rno int,
   Sname varchar(14) default null,
   City varchar(20) default null,
   State varchar(20) default null
);

select * from Student;

create table Emp_log (
   Emp_id int,
   Log_date date default null,
   New_Salary int default null,
   Action varchar(20) default null
);

select * from Emp_log;

-- [1] Select unique job from EMP table.

select distinct Job from Emp;

-- [2.] List the details of the emps in asc order of the Dptnos and desc of Jobs?

select * from Emp
order by Deptno asc, Job desc;

-- [3.] Display all the unique job groups in the descending order?

select distinct Job from Emp
order by Job desc;

-- [4.] List the emps who joined before 1981.

select * from Emp
where Hiredate < '1981-01-01';

-- or 

select * from Emp
where year(Hiredate) < 1981;

-- [5.] List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal.

select Empno,
       Ename, 
       Sal,
       Sal / 30 as Daily_Sal
from Emp
order by sal * 12 desc;

-- [6.] List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369.
select * from Emp;

-- Here, Empno 7369 is not a manager, he is a clerk
select Empno, Ename, Job from Emp
where Empno = 7369;

-- The employees who are managers are 7566 (JONES), 7698 (BLAKE), and 7782 (CLARK). 
select Empno, Ename from Emp
where Job = 'Manager';

-- List the Empno, Ename, Sal, Exp of all emps working for Mgr 7566
select Empno, 
       Ename, 
       Sal,
       timestampdiff(year, Hiredate, curdate()) as Exp
from Emp
where Empno = 7566;

-- [7.] Display all the details of the emps who’s Comm. Is more than their Sal?

select * from Emp
where Comm > Sal;

-- [8.] List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.

select * from Emp
where Job in ('CLERK','ANALYST')
order by job desc;

-- [9.] List the emps Who Annual sal ranging from 22000 and 45000.

select Empno,Ename, Job, Hiredate ,Deptno,
       Sal * 12 as Annual_Sal
from Emp
where Sal * 12 between 22000 and 45000
order by Annual_Sal;

-- [10.] List the Enames those are starting with ‘S’ and with five characters.

select * from Emp
where Ename like 'S____';

-- [11.] List the emps whose Empno not starting with digit78.

select * from Emp
where Empno not like '78%';

-- [12.] List all the Clerks of Deptno 20.

select * from Emp
where Deptno = 20 
and Job = "CLERK";

-- [13.] List the Emps who are senior to their own MGRS.

select e.Ename as Emp_Name, e.Job, e.Hiredate as Emp_Hiredate,
       m.Ename as Mgr_Name, m.Hiredate as Mgr_Hiredate
from Emp as e
join Emp as m
on e.Mgr = m.Empno
where e.Hiredate < m.Hiredate;

-- [14.] List the Emps of Deptno 20 who’s Jobs are same as Deptno10

select distinct e.*
from Emp as e 
join Emp as d
on e.Job = d.Job
where e.Deptno = 20 
and d.Deptno = 10 ;

-- or

select * from Emp
where Deptno = 20 
and Job in 
(select job from Emp
where Deptno = 10);
 
-- [15.] List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal.

select distinct e.*
from Emp as e
join Emp as fs
on e.Sal = fs.Sal
where fs.Ename in ('FORD','SMITH')
order by e.Sal desc;

-- or
select * from Emp
where Sal in 
(select Sal from Emp
where Ename in ('FORD','SMITH'))
order by Sal desc;

-- [16.] List the emps whose jobs same as SMITH or ALLEN.

select distinct e.*
from Emp as e
join Emp as j
on e.Job = j.Job
where j.Ename in ('SMITH','ALLEN')
order by Job;

-- or

select * from Emp
where Job in
(select Job from Emp
where Ename in ("SMITH","ALLEN"))
order by Job;

-- [17.] Any jobs of deptno 10 those that are not found in deptno 20.

select distinct e.Job
from Emp as e
left join Emp as d
on e.Job = d.Job and d.Deptno = 20
where e.Deptno = 10 and d.Job is null;

-- or

select distinct Job from Emp
where Deptno = 10 
and Job not in 
(select Job from Emp
where Deptno = 20);

-- [18.] Find the highest sal of EMP table.

select max(Sal) from Emp;

-- [19.] Find details of highest paid employee.

select * from Emp
where Sal in
(select max(Sal) from Emp);

-- [20.] Find the total sal given to the MGR.

select sum(Sal) as Total_Manager_Salary from Emp
where Job = 'MANAGER';

-- [21.] List the emps whose names contains ‘A’.

select * from Emp
where Ename like '%A%';

-- [22.] Find all the emps who earn the minimum Salary for each job wise in ascending order. 

select * from Emp
where (Job, Sal) in
(select Job, min(Sal) from Emp
group by Job)
order by Sal asc;

-- or

select e.* 
from Emp e
join (
select Job, min(Sal) as MinSal from Emp
group by Job) m
on e.Job = m.Job and e.Sal = m.MinSal
order by e.Sal asc;

-- [23.] List the emps whose sal greater than Blake’s sal. 

select * from Emp
where Ename = "BLAKE";

select * from Emp
where Sal > (
    select Sal from Emp
    where Ename = 'BLAKE'
);

-- [24.] Create view v1 to select ename, job, dname, loc whose deptno are same. 

create view V1 as
select e.Ename, e.Job, d.dname, d.loc
from Emp e
join Dept d
on e.Deptno = d.deptno;

select * from v1;

-- [25.] Create a procedure with dno as input parameter to fetch ename and dname. 

delimiter $$

create procedure GetEmpDept(in dno int)
begin
     select e.Ename, d.Dname
     from Emp e
     join Dept d
     on e.Deptno = d.Deptno
     where e.Deptno = dno;
end $$

delimiter ;

call GetEmpDept(10);

-- [26.] Add column Pin with bigint data type in table student. 

alter table student
add Pin bigint;

select * from student;

-- [27.] Modify the student table to change the sname length from 14 to 40. 

alter table student
modify Sname varchar(40);

describe student;

-- [27.] trigger to insert data in emp_log table whenever any update of sal in EMP table. You can set action as ‘New Salary’. 

DROP TRIGGER IF EXISTS trg_salary_update;

DELIMITER $$

CREATE TRIGGER trg_salary_update
AFTER UPDATE ON Emp
FOR EACH ROW
BEGIN
    IF OLD.Sal <> NEW.Sal THEN
        INSERT INTO Emp_log (Emp_id, New_Salary, Action)
        VALUES (OLD.Empno, NEW.Sal, 'New Salary');
    END IF;
END$$

DELIMITER ;

UPDATE Emp
SET Sal = Sal + 100
WHERE Empno = 7369;

SELECT * FROM Emp_log;

