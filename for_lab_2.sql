/*создание базы данных*/
create database students;

/*установка базы данных*/
use students;

/*создание отношений*/
create table student_information
(gradebook_number int primary key,
FIO varchar(20),
year_of_admission int,
student_group varchar(7),
course int,
avarage_score decimal(3,1),
form_of_study varchar(8) default 'дневная',
academic_leave bool default false
);

alter table student_information
modify FIO varchar(50);

select * from student_information;

create table disciplines
(id int primary key,
name varchar(50)
);

select * from disciplines;

create table session
(student_group varchar(7),
/*Добавим атрибут курса*/
course int,
discipline_id int,
date_of_ex date,
time_of_ex time,
classroom int,
foreign key (discipline_id) references disciplines (id),
/*уникальность комбинации дата-время-аудитория*/
unique (date_of_ex,time_of_ex,classroom)
);

select *from session;

/*Добавим студентов*/
insert into student_information(gradebook_number,FIO,year_of_admission,student_group,course,avarage_score,academic_leave)
values
(345123,'Романов Алексей Денисович',2017,'БПМ-173',4,9.8,false),
(345104,'Кузнецов Сергей Алексеевич',2017,'БПМ-171',4,9.8,false),
(345116,'Кожев Юрий Андреевич',2017,'БПМ-173',4,9.5,true),
(345134,'Мышелова Елизавета Андреевна',2017,'БПМ-171',4,8.9,false),
(345172,'Майорова Анастасия Олеговна',2017,'БПМ-174',4,8.8,false),
(345163,'Кандалина Дарья Сергеевна',2017,'БПМ-174',4,9.2,false),
(345101,'Ярмухаметов Булат Вилевич',2017,'БПМ-172',4,8.6,false),
(345133,'Ремизова Анна Петровна',2017,'БПМ-174',4,8.8,false),
(345145,'Глотова Александра Андреевна',2017,'БПМ-172',4,8.1,true),
(345127,'Самоделкина Мария Владимировна',2017,'БПМ-174',4,9.7,false),
(347147,'Боброва Ксения Валерьевна',2019,'БПМ-192',2,9.7,false),
(347156,'Шевель Николай Максимович',2019,'БПМ-193',2,9.7,false),
(347134,'Билева Анна Андреевна',2019,'БПМ-191',2,9.7,false),
(347102,'Прокопьев Григорий Андреевич',2019,'БПМ-194',2,9.7,false),
(347110,'Забродина Татьяна Николаевна',2019,'БПМ-192',2,9.7,false),
(347117,'Петелина Ирина Григорьевна',2019,'БПМ-192',2,9.7,false),
(347133,'Савенко Дарья Андреевна',2019,'БПМ-194',2,9.7,false),
(347145,'Козлова Елизавета Романовна',2019,'БПМ-193',2,9.7,true),
(347184,'Мирошник Валерий Александрович',2019,'БПМ-191',2,9.7,false),
(347179,'Гаврильев Дмитрий Андреевич',2019,'БПМ-192',2,9.7,false);

select * from student_information
order by student_group;

/*Добавим дисциплины*/
insert into disciplines(id,name)
values
(1,'Математический анализ'),
(2,'Линейная алгебра'),
(3,'Физика'),
(4,'Программирование'),
(5,'Дифференциальные уравнения'),
(6,'Алгебра'),
(7,'Теоретическая механика'),
(8,'Функциональный анализ'),
(9,'Теория случайных процессов'),
(10,'Операционные системы'),
(11,'Методы оптимизации'),
(12,'Машинное обучение'),
(13,'Численные методы'),
(14,'Теория управления'),
(15,'Экономика предприятия'),
(16,'Филосовия науки');

select * from disciplines;

/*Создать расписание экзаменов*/
insert into session(student_group,course,discipline_id,date_of_ex,time_of_ex,classroom)
values
('БПМ-172',4,13,'2020-06-13','12:00','203'),
('БПМ-171',4,13,'2020-06-13','13:30','203'),
('БПМ-172',4,14,'2020-06-15','13:30','307'),
('БПМ-171',4,14,'2020-06-15','15:00','307'),
('БПМ-172',4,15,'2020-04-21','09:00','304'),
('БПМ-171',4,15,'2020-04-21','10:30','304'),
('БПМ-172',4,16,'2020-06-25','15:00','207'),
('БПМ-171',4,16,'2020-06-25','16:30','207');
insert into session(student_group,course,discipline_id,date_of_ex,time_of_ex,classroom)
values
('БПМ-192',2,13,'2020-06-12','12:00','203'),
('БПМ-191',2,13,'2020-06-12','13:30','203'),
('БПМ-194',2,5,'2020-06-10','13:30','307'),
('БПМ-193',2,6,'2020-06-18','15:00','307'),
('БПМ-193',2,8,'2020-04-23','09:00','304'),
('БПМ-191',2,7,'2020-04-09','10:30','304'),
('БПМ-192',2,10,'2020-06-21','15:00','207'),
('БПМ-194',2,16,'2020-06-21','16:30','207');
insert into session(student_group,discipline_id,date_of_ex,time_of_ex,classroom)
values
('Проект',1,'2020-06-01','12:00','307'),
('Проект',2,'2020-06-02','13:30','207'),
('Проект',3,'2020-06-03','13:30','307');
insert into session(student_group,discipline_id,date_of_ex,time_of_ex,classroom)
values
('Проект',4,'2020-06-07','13:30','207');

select * from session;

/*Найти в расписании сессии группы и найти такие адутории, в которых за время сессии они были больше 1 раза*/
select student_group as 'Группа', classroom as 'Аудитория', cnt as 'Количество' from
  (select student_group,classroom, count(classroom) as cnt from session group by student_group,classroom) as t
  where cnt>1;

/*Проверить уникальность комбинации "Дата", "Время", "Аудитория*/
select date_of_ex,time_of_ex,classroom from session
group by date_of_ex,time_of_ex,classroom
having count(*) > 1;

/*Найти в расписании сессии группы, в которых нет студентов*/
select session.student_group as 'Группы без студентов' from session
	left outer join student_information on
		session.student_group=student_information.student_group
	where student_information.FIO is null
    group by session.student_group;

/*Создать расписание экзаменов на сессию для произвольной группы.*/
select student_group as 'Группа', course as 'Курс', date_of_ex as 'Дата', time_of_ex as 'Время', 
classroom as 'Аудитория', disciplines.name as 'Дисциплина' from session
inner join disciplines on
session.discipline_id=disciplines.id
where student_group='БПМ-171'
order by date_of_ex;

/*Создать упорядоченные списки студентов групп второго курса (без находящихся в академическом отпуске)*/
select FIO as 'ФИО студента',student_group as 'Группа' from student_information
where  course=2 and academic_leave=0
order by student_group,FIO;

/*Создать упорядоченные списки студентов, имеющих наибольший средний бал в своей групп*/
select FIO as 'ФИО студента',student_group as 'Группа',avarage_score as 'Средний балл' from student_information
group by student_group
order by student_group,avarage_score;

/*"Списки групп" для дневной формы обучения (группа, фамилия, номер зачётной книжки, средний балл).*/
create view group_lists as
select student_group, FIO , gradebook_number, avarage_score from student_information
where form_of_study='дневная'
order by student_group, FIO;

select * from group_lists;

/*"Успеваемость" (группа, средний балл по группе, минимальный средний балл, максимальный средний балл, разница (max-min)).*/
create view academic_performance as
select student_group as student_group, min(avarage_score) as min_av_score, max(avarage_score) as max_av_score, avg(avarage_score) as avarage,
(max(avarage_score)-min(avarage_score)) as max_min from student_information
group by student_group;

select * from academic_performance
order by student_group;

/*"Количество экзаменов" (группа, количество экзаменов).*/
create view number_of_exams as
select student_group as student_group, count(1) as count from session
group by student_group
order by student_group;

select * from number_of_exams;

/*Написать не менее 5 сложных запросов с параметрами. Выполнить запросы, задав значения параметров.*/
/*Количество студентов course курса, которые сдавали discipline предмет*/
DELIMITER $$
create procedure proc1(course int,discipline varchar(50))
begin
select student_information.student_group as 'Группа', count(FIO) as 'Количество' from session
	inner join disciplines on
		session.discipline_id=disciplines.id
    inner join student_information on
		session.student_group=student_information.student_group
where name=discipline and session.course=course
group by student_information.student_group;
end$$
DELIMITER ;
call proc1(2,"Численные методы");

/*Вывести имена студентов и дисциплины, которые они сдавали на сессии в кабинетах cab1 и cab2. Отсортировать по дисицплине и студентам*/
DELIMITER $$
create procedure proc2(cab1 int,cab2 int)
begin
select student_information.FIO as 'Фио студента', disciplines.name as 'Дисциплина'  from session
	inner join disciplines on
		session.discipline_id=disciplines.id
    inner join student_information on
		session.student_group=student_information.student_group
where session.classroom=cab1 or session.classroom=cab2
order by student_information.FIO, disciplines.name;
end$$
DELIMITER ;
call proc2(207,307);

/*Вывести всех студентов группы gr1, у которых средний балл ниже среднего балла группы gr2 среди всех студентов*/
DELIMITER $$
create procedure proc3(gr1 varchar(7),gr2 varchar(7))
begin
select FIO as 'ФИО студента', student_group as 'Группа', avarage_score as 'Седний балл' from student_information
where student_group=gr1 and avarage_score<
(select avarage from academic_performance
where student_group=gr2);
end$$
DELIMITER ;
call proc3("БПМ-174","БПМ-171");

/*Вывести всех студентов y1 года поступления, у которых средий балл выше, чем срежний балл среди всех студентов y2 года. Отсортировать 
по студентам*/
DELIMITER $$
create procedure proc4(y1 int,y2 int)
begin
select FIO as 'ФИО студента', avarage_score as 'Средний балл' from student_information
where year_of_admission=y1 and avarage_score>
(select avg(avarage_score) from student_information
where year_of_admission=y2)
order by FIO;
end$$
DELIMITER ;
call proc4(2019,2017);

/*Вывести списки студентов n курса и дисциплины которые они сдавали на сессии, в том числе вывести студентов, 
которые не сдавали ни один предмет,*/
DELIMITER $$
create procedure proc5(n int)
begin
select student_information.FIO as 'Фио студента', disciplines.name as 'Дисциплина' from session
    right outer join student_information on
		session.student_group=student_information.student_group   
	left outer join disciplines on
		session.discipline_id=disciplines.id    
where student_information.course=n;
end$$
DELIMITER ;
call proc5(4);

/*Вывести средний бал группы gr*/
DELIMITER $$
create procedure proc6(gr varchar(7))
begin
select avarage as 'Средний балл' from academic_performance
where student_group=gr;
end$$
DELIMITER ;

call proc6('БПМ-171');