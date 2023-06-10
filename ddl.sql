drop table payment_info;
drop table trainer_info;
drop table trainee_info;
drop table course_info; 

create table course_info(
    course_id number,
    course_name varchar(30),
    course_duration number,
    course_description varchar(100),
    no_of_trainee number,
    primary key(course_id));

 create table trainer_info(
    trainer_id number,
    trainer_name varchar(20),
    trainer_email varchar(20),
    trainer_address varchar(20),
    course_id number,
    primary key(trainer_id),
    foreign key(course_id) references course_info(course_id)on delete cascade);

create table trainee_info(
    trainee_id number,
    trainee_name varchar(20),
    trainee_email varchar(20),
    trainee_address varchar(20),
    course_id number,
    primary key(trainee_id),
    foreign key(course_id) references course_info(course_id)on delete cascade);


create table payment_info(
    payment_id number,
    course_id number,
    amount integer,
    primary key(payment_id),
    foreign key(course_id) references course_info(course_id)on delete cascade);

create table relation1(
    Trainer_id number,
    course_id number,
    foreign key(course_id) references course_info(course_id)on delete cascade,
    foreign key(trainer_id) references trainer_info(trainer_id)on delete cascade);

-- 1. adding a column in the table

alter table payment_info add payment_date date;
describe payment_info;

-- 2. modify column definition in the table

alter table payment_info modify payment_date varchar(10);
describe payment_info;

-- 3. rename a column name

alter table payment_info rename column payment_date to pay_date;
describe payment_info;

-- 4. drop a column from table

alter table payment_info drop column pay_date;
describe payment_info;


