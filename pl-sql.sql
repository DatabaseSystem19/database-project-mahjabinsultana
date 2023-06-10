-- 1. if payment is increased 5k for each course 
-- then print increased payement and course id

set serveroutput on
declare
	inc payment_info%rowtype;
	
begin
	for x in 1..10 
	loop
		select * into inc from payment_info where payment_id=x;
		inc.amount := inc.amount + 5000;
		dbms_output.put_line('Course id : '||inc.course_id||' Increased payment : '||inc.amount);
	end loop;
end;
/


-- 2. use an array to store trainers who will be paid more than 40k
-- print the names

set serveroutput on
declare 
    counter number;
	trainer trainer_info.trainer_name%type;
	amount payment_info.amount%type;
	type trainer_name_array is varray(10) of trainer_info.trainer_name%type;
	names trainer_name_array := trainer_name_array();
begin
    counter := 1;
	for x in 101..111
	loop
        select trainer_name into trainer from trainer_info where trainer_id=x;
		select amount into amount from payment_info where course_id=(select course_id from trainer_info where trainer_id=x);
		
		if amount>40000
			then 
                names.extend();
                names(counter) := trainer;
		    counter := counter+1;
		end if;
		
	end loop;
	
	counter := 1;
	while counter<=names.count
	loop
        dbms_output.put_line(names(counter));
        counter := counter+1;
       end loop;
end;
/
				 


-- 3. write a procedure which will print names of courses
-- if number of trainee is greater than var1


create or replace procedure proc11(
	var1 in course_info.no_of_trainee%type
)
as
var2 course_info.course_name%type;
cursor c is select course_name from course_info where
no_of_trainee>var1;

begin
	open c;
	fetch c into var2;
	while c%found loop
	dbms_output.put_line('Course name is '||var2);
	fetch c into var2;
	end loop;
	close c;
end;
/
	
set serveroutput on
declare
begin
	proc11(50);
end;
/
	

-- 4. write a function which will take payment_id as
-- argument and return corresponding course_name

create or replace function fun11(var1 in payment_info.payment_id%type)
return course_info.course_name%type 
as
var2 course_info.course_name%type; 

begin 
	select course_name into var2 from course_info 
	where
	course_id=(select course_id from payment_info where payment_id=var1);
	return var2;
end;
/

set serveroutput on
declare
	name course_info.course_name%type;
begin
	name:= fun11(2);
	dbms_output.put_line('Course name is '||name);
end;
/


-- 5. insert a trainer info into the trainer_info table

set serveroutput on
declare
	id trainer_info.trainer_id%type := 115;
	name trainer_info.trainer_name%type := 'MAH';
	email trainer_info.trainer_email%type := 'mah@gmail.com';
	address trainer_info.trainer_address%type := 'Bangladesh';
	course_id course_info.course_id%type := 9;
begin
	insert into trainer_info values(id, name, email, address, course_id);
end;
/

select * from trainer_info;



-- 6. create a procedure to print how many trainee info is there for each course


create or replace procedure proc12(
	var1 out course_info.course_id%type
)
as
counter integer := 0;

begin
	
	for x in 1..10
	loop
		var1 := x;
		select count(*) into counter from trainee_info where course_id=x;
		dbms_output.put_line('Course id: '||var1||' No of trainee info available: '||counter);
	end loop;
end;
/
	
set serveroutput on
declare
	out course_info.course_id%type;
begin
	proc12(out);
end;
/


-- 7. if no_of_trainee is less than 30 it is a small course,
-- if it is less than 50 it is a medium course,
-- if it is less than 80 it is a big course. Print course size for each course using procedure.

create or replace procedure proc13(id out course_info.course_id%type)
as
var1 course_info.no_of_trainee%type;

begin
	
	for x in 1..10
	loop
        id := x;
		select no_of_trainee into var1 from course_info where course_id=x;
		if var1<=30 then
			dbms_output.put_line('Course id: '||id||' is a small course');
		elsif var1<=50 then
			dbms_output.put_line('Course id: '||id||' is a medium course');
		else 
			dbms_output.put_line('Course id: '||id||' is a big course');
		end if;
	end loop;
end;
/
	
	
set serveroutput on
declare
	out course_info.course_id%type;
begin
	proc13(out);
end;
/


-- 8. create a function which will return average amount of payment. compare the average with another
-- amount using procedure.

create or replace function fun12(var1 out payment_info.amount%type)
return payment_info.amount%type
as
var2 payment_info.amount%type;
begin
	select avg(amount) into var2 from payment_info;
	return var2;
end;
/

create or replace procedure proc14(var1 in payment_info.amount%type, var2 in payment_info.payment_id%type)
as
var3 varchar(20) := 'higher';
var4 varchar(20) := 'lower';
var5 varchar(20) := 'equal';
amount payment_info.amount%type;
begin
	select amount into amount from payment_info where payment_id=var2;
	if(var1>amount) then
		dbms_output.put_line('Amount is '||var4||' than average.');
	elsif(var1<amount) then
		dbms_output.put_line('Amount is '||var3||' than average.');
	else
		dbms_output.put_line('Amount is '||var5||' to average.');
	end if;
end;
/

set serveroutput on
declare
	var1 payment_info.amount%type;
      var2 payment_info.amount%type;
begin
	var1 := fun12(var1);
	proc14(var1, 3);
end;
/ 


--- trigger with insert

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trigger1
after insert ON relation1 
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
Enable
BEGIN
insert into trainer_info values(:n.trainer_id, null, null, null, null );
insert into course_info values(:n.course_id, null, null, null, null );
END;
/

insert into relation1 values(301, 301);
select * from relation1;
select * from course_info;
select * from trainer_info;


--- trigger with delete
--- this trigger won't work as i've used on delete cascade

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trigger2
BEFORE delete ON course_info 
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
Enable
BEGIN
delete from trainer_info where course_id=:o.course_id;
delete from trainee_info where course_id=:o.course_id;
END;
/

delete from course_info where course_id=9; 

--- trigger with update

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trigger3
AFTER update ON course_info 
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
Enable
BEGIN
update payment_info set amount=90000 where course_id=:o.course_id;
END;
/

update course_info set course_name='new course' where course_id=8;

