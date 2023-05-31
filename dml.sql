insert into course_info values(1, 'Skill Development-1', 1, 'Training on computer skills', 50);
insert into course_info values(2, 'Skill Development-2', 2, 'Training on culinery skills', 60);
insert into course_info values(3, 'Skill Development-3', 1, 'Training on sewing skills', 45);
insert into course_info values(4, 'First Aid-1', 2, 'Demonstrating and teaching first aid skills', 70);
insert into course_info values(5, 'First Aid-2', 1, 'Demonstrating and teaching first aid skills', 30);
insert into course_info values(6, 'First Aid-3', 3, 'Demonstrating and teaching first aid skills', 60);
insert into course_info values(7, 'Smart Farming-1', 2, 'Training on smart farming skills', 30);
insert into course_info values(8, 'Smart Farming-2', 3, 'Training on smart farming skills', 20);
insert into course_info values(9, 'Smart Farming-3', 4, 'Training on smart farming skills', 20);
insert into course_info values(10, 'Basic Electric Work', 1, 'Teaching basic electric works', 30);

insert into trainer_info values(101, 'Mr. XYZ', 'xyz@gmail.com', 'Detroit', 1); 
insert into trainer_info values(102, 'Mr. ABC', 'abc@gmail.com', 'Michigan', 1);
insert into trainer_info values(103, 'Mr. DEF', 'def@gmail.com', 'LA', 5);
insert into trainer_info values(104, 'Mr. GHI', 'ghi@gmail.com', 'Detroit', 2);
insert into trainer_info values(105, 'Mr. MNO', 'mno@gmail.com', 'Seattle', 3);
insert into trainer_info values(106, 'Mr. PQR', 'pqr@gmail.com', 'California', 5);
insert into trainer_info values(107, 'Mr. RST', 'rst@gmail.com', 'Florida', 1);
insert into trainer_info values(108, 'Mr. JKL', 'jkl@gmail.com', 'LA', 4);
insert into trainer_info values(109, 'Mr. KLM', 'klm@gmail.com', 'California', 3);
insert into trainer_info values(110, 'Mr. CDE', 'cde@gmail.com', 'Florida', 4);
insert into trainer_info values(111, 'Mr. EFG', 'efg@gmail.com', 'LA', 10);

insert into trainee_info values(1001, 'Jane', 'jane@gmail.com', 'Michigan', 1);
insert into trainee_info values(1002, 'Joe', 'joe@gmail.com', 'Detroit', 1);
insert into trainee_info values(1003, 'Janice', 'janice@gmail.com', 'Michigan', 3);
insert into trainee_info values(1004, 'Jack', 'jack@gmail.com', 'Seattle', 3);
insert into trainee_info values(1005, 'Jeffery', 'jaffery@gmail.com', 'Seattle', 2);
insert into trainee_info values(1006, 'Fred', 'fred@gmail.com', 'LA', 2);
insert into trainee_info values(1007, 'Fredric', 'fredric@gmail.com', 'LA', 2);
insert into trainee_info values(1008, 'Harry', 'harry@gmail.com', 'Michigan', 5);
insert into trainee_info values(1009, 'Ginny', 'ginny@gmail.com', 'LA', 5);
insert into trainee_info values(1010, 'Ron', 'ron@gmail.com', 'Detroit', 4);
insert into trainee_info values(1011, 'Rachel', 'rachel@gmail.com', 'Seattle', 5);
insert into trainee_info values(1012, 'Ryan', 'ryan@gmail.com', 'Detroit', 5);
insert into trainee_info values(1013, 'Rob', 'rob@gmail.com', 'Detroit', 9);

insert into payment_info values(1, 1, 20000);
insert into payment_info values(2, 2, 30000);
insert into payment_info values(3, 3, 25000);
insert into payment_info values(4, 4, 40000);
insert into payment_info values(5, 5, 45000);
insert into payment_info values(6, 6, 25000);
insert into payment_info values(7, 7, 25000);
insert into payment_info values(8, 8, 35000);
insert into payment_info values(9, 9, 35000);
insert into payment_info values(10, 10, 50000);

-- 1. use of where-> show trainer's info who takes course-4.

select * from trainer_info where course_id=4;

-- 2. updating data in a table-> update course-5's course name

update course_info set course_name='First Aid-4' where course_id=5;
select * from course_info;

-- 3. select course that has maximum number of trainee

with max_trainee(val) as (select max(no_of_trainee) from course_info)
select * from course_info, max_trainee where course_info.no_of_trainee=max_trainee.val;   

-- 4. show how many trainee infos are there for each course

select course_id, count(*) from trainee_info group by course_id;

-- 5. nested query-> show trainer's info whose salary is 20000.

select * from trainer_info where course_id=(select course_id from payment_info where amount=20000);

-- 6. show course names containing 'll'

select course_name from course_info where course_name like '%ll%';

-- 7. show how much each trainer is paid

select * from trainer_info natural join payment_info;

-- 8. Find courses which have less than 40 trainees and duration is less than three months

select course_name from course_info where course_duration<3 and no_of_trainee in (select no_of_trainee from course_info where no_of_trainee>=40); 

-- 9. if there exists a payment amount 45k then show all payment amount above 45k

select payment_id, amount from payment_info where amount>45000 and exists(select * from payment_info where amount=45000);

-- 10. show which trainee will get which trainer

select trainee_id, trainee_name, trainer_id, trainer_name from trainee_info left outer join trainer_info using(course_id);





