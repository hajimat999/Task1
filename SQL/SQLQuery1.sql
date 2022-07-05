create database P127
use P127
create table Books(
    Id int primary key identity,
	[Name] nvarchar(100) check(Len([Name]) >=2),
	[PageCount] int check([PageCount]>10),
	AuthorId int foreign key references Authors(Id)
)

create table Authors(
    Id int primary key identity,
	[Name] nvarchar(30),
	Surname nvarchar(50)
)
create view vw_selectAllInformation
as 
select b.Id, b.Name, b.PageCount, CONCAT(a.Name, ' ', a.Surname) as FullName from Books as b
join Authors as a
on b.AuthorId = a.Id 

create procedure usp_selectInformationBySearch
@Search nvarchar(80)
as
select *from vw_selectAllInformation where Name like '%' + @Search + '%' or FullName like '%' + @Search + '%'

create procedure usp_insertAuthors
@Name nvarchar(30),
@surname nvarchar(30)
as 
insert into Authors
values(@Name, @surname)

create procedure usp_updateAuthors
@Name nvarchar(30),
@Surname nvarchar(50)
as
update Authors 
set Name = @Name, Surname = @Surname

create procedure usp_deleteAuthors
@Id int
as
delete from Authors where Id = @Id



create view vw_selectAuthors
as
select a.Id, Concat(a.Name, ' ', a.Surname) as FullName, Count(b.Name) as Count, Max(b.PageCount) as MaxPageCount from Books as b
join Authors as a
on a.Id = b.AuthorId 
group by a.Id, a.Name, a.Surname




