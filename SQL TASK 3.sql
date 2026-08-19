use my_deepika;
create table students_table(
Student_ID int,
Name varchar(90),
Course varchar(80),
Age int,
Marks int,
City varchar(100)
);
select*from students_table;
insert into students_table values(21,'deepika','bca',21,90,'kochi'),(22,'alriya','BBA',18,63,'chennai'),(23,'andrea','bcom',25,56,'mangalore'),(24,'jenevia','bca',54,90,'mangalore'),(25,'sweedal','bca',25,93,'bangalore');
select*from students_table;

update students_table
set Course='bcom(ai)' 
where Student_ID=5;
update students_table
set Age=45
where Student_ID=25;
update students_table
set Age=23
where Student_ID=12;
update students_table
set Course='bca(AI)'
where Student_ID=16;
update students_table
set Marks=100
where Age=26;
select*from students_table;
delete from students_table where course='bca';
delete from students_table where course='bcom';
delete from students_table where marks=100;
delete from students_table where age=26;
delete from students_table where course='BCA';
select*from students_table;