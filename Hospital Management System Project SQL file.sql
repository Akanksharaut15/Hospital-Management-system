--1) Write a query in SQL to find all the 
--information of the nurses who are yet to be registered. 
select * from nurse;
select name from nurse
where registered ='f';

--2) Write a query in SQL to find the name of
--the nurse who are the head of their department.
select * from nurse;
select name from nurse
where position like '%Head%';

3) Write a query in SQL to obtain the name of 
the physicians who are the head of each department.
select * from physician;
select * from department;
select ph.name as physician_name, d.name as department_name
from physician ph 
inner join department d 
on ph.employeeid= d.department_id;

4)Write a query in SQL to count the number of patients 
who taken appointment with at least one physician.
select * from appointment;
select count(patient),physician
from appointment
group by physician
limit 1;

5)Write a query in SQL to find the floor and 
block where the room number 212 belongs to.
select * from room;
select roomnumber, blockfloor, blockcode
from room 
where roomnumber=212;

6)Write a query in SQL to count the number available rooms
select * from room;
select count(roomnumber)
from room
where unavailable='f';

7)Write a query in SQL to count the number of unavailable rooms.
select count(roomnumber)
from room
where unavailable='t';

8)Write a query in SQL to obtain the name of the physician 
--and the departments they are affiliated with. 
select * from physician;
select * from department;
select * from affiliated_with;
select ph.employeeid as employeeid, ph.name as physician_name ,
d.department_id as departmentid,d.name as department_name
from physician ph 
inner join department d 
on ph.employeeid=d.department_id
inner join affiliated_with aw 
on aw.physician=d.department_id
where primaryaffiliation='t';

9)Write a query in SQL to obtain the name of the 
physicians who are trained for a special treatement.
select * from trained_in;
select ph.name as physician_name, tr.treatment
from physician ph 
inner join trained_in tr 
on tr.treatment=ph.employeeid;

select employeeid,name
from physician 
where employeeid in (select distinct(physician)
                 from trained_in);
                 
10)Write a query in SQL to obtain the name of the physicians 
with department who are yet to be affiliated.
select * from physician;
select * from department;
select * from affiliated_with;
select  ph.employeeid as employeeid,ph.name as physician_name, d.name as department_name
from physician ph 
inner join department d 
on ph.employeeid=d.department_id 
inner join affiliated_with aw 
on aw.physician=d.department_id
where primaryaffiliation='f';

11)Write a query in SQL to obtain the name of the 
physicians who are not a specialized physician.
select name as not_specialized_physicians
from physician
where employeeid not in(select distinct physician
                        from trained_in);

12)Write a query in SQL to obtain the name of the patients with their physicians 
 by whom they got their preliminary treatement
 select * from patient;
 select * from physician;
select p.name as patient_name , ph.name as preliminary_treatment
from patient p 
inner join physician ph 
on p.pcp= ph.employeeid;

13)Write a query in SQL to find the name of the patients and 
 the number of physicians they have taken appointment.
select * from patient;
select * from appointment;
select p.name as patient_name , count(distinct physician) as no_of_physician
from patient p 
inner join appointment a 
on p.pcp=a.physician
group by p.name;

14)Write a query in SQL to count number of unique patients 
who got an appointment for examination room C. 
select * from appointment;
select examinationroom,count(distinct patient)
from appointment 
group by examinationroom
having examinationroom= 'C';

15)Write a query in SQL to find the name of the patients and the number of the 
room where they have to go for their treatment. 
select * from patient;
select * from room;
select * from stay;
select p.name as patient_name, s.patient_room as room_number
from patient p 
inner join stay s 
on p.ssn=s.stayid
inner join room r 
on s.stayid= r.roomnumber 
limit 0,1000;

16)Write a query in SQL to find the name of the nurses and the room scheduled, 
-where they will assist the physicians
select * from nurse;
select * from undergoes;
select * from stay;
select n.employeeid as employeeid, n.name as nurse_name ,s.patient_room as room_no
from nurse n 
inner join undergoes u 
on u.assistingnurse=n.employeeid
inner join stay s 
on u.stay=s.stayid;

17)Write a query in SQL to find the name of the patients who taken 
the appointment on the 25th of April at 10 am, and also display 
their physician, assisting nurses and room no.
select p.name as patient_name,
       ph.name as physician_name,
       n.name as nurse_name,
       a.examinationroom
from patient p
left outer join appointment a
on p.ssn = a.patient
left outer join physician ph
on a.physician = ph.employeeid
left outer join nurse n
on a.prepnurse = n.employeeid
where start_dt = '25-04-08';

18)Write a query in SQL to find the name of patients and their physicians 
who does not require any assistance of a nurse.
select p.name as patient_name, ph.name as physician_name
from patient p 
inner join physician ph 
on p.pcp=ph.employeeid
inner join undergoes u 
on u.patient= p.ssn
where assistingnurse is null;

19)Write a query in SQL to find the name of the patients,
 their treating physicians and medication
 select p.name as patient_name, ph.name as physician_name, m.name as medication_name
 from patient p
 inner join physician ph 
 on p.pcp= ph.employeeid
 inner join medication m 
 on m.code =ph.employeeid
 inner join undergoes u 
 on u.patient= p.ssn
 inner join prescribes ps
 on ps.patient=u.patient;
 
 20)Write a query in SQL to find the name of the patients who taken an advanced 
 appointment, and also display their physicians and medication.
 select p.ssn,p.name as patient_name, ph.name as physician_name, m.name as medicine_name
 from patient p 
 left join appointment a 
 on a.patient=p.ssn
 left join prescribes ps 
 on ps.patient=a.patient
 left join physician ph 
 on ph.employeeid=ps.physician
 left join medication m 
 on m.code=ph.employeeid;
 
 21)Write a query in SQL to find the name and medication for 
 those patients who did not take any appointment.
  select p.name as patient_name , m.name as medicine_name
  from patient p
  inner join medication m 
  on m.code =p.pcp
  inner join appointment a
  on a.patient= p.ssn
  where appointmentid is  not null;
  
  22)Write a query in SQL to count the number of available rooms in each block.  
 select blockcode, count(*) as no_of_aval_room
 from room
 where unavailable='f'
 group by blockcode;
 
23)Write a query in SQL to count the number of available rooms in each floor.
 select blockfloor, count(*) as no_of_aval_room
 from room
 where unavailable='f'
 group by blockfloor;
 
 24)Write a query in SQL to count the number 
 of available rooms for each block in each floor. 
 select blockcode, blockfloor,count(*) as no_of_avl_room
 from room
 group by blockcode, blockfloor;

25)Write a query in SQL to count the number 
of unavailable rooms for each block in each floor. 
 select blockcode, blockfloor,count(*) as no_of_avl_room
 from room
 where unavailable='f'
 group by blockcode, blockfloor; 
 
 26)Write a query in SQL to find out the floor 
 where the maximum no of rooms are available. 
  select blockfloor, count(unavailable)as max_no_of_room
  from room
  where unavailable='f'
  group by blockfloor
  order  by count(unavailable) desc;
  
  27)Write a query in SQL to find out the floor 
  where the minimum no of rooms are available
  select blockfloor, count(unavailable)as min_no_of_room
  from room
  where unavailable='t'
  group by blockfloor
  order  by count(unavailable) asc;
  
  28)Write a query in SQL to obtain the name of the patients, their block, 
  floor, and room number where they are admitted. 
  select * from patient;
  select * from room;
  select * from stay;
  select p.name as patient_name, blockfloor, blockcode, roomnumber
  from patient p 
  inner join stay s 
  on p.ssn= s.patient_room
  inner join room r 
  on r.roomnumber=s.patient_room
  
  29)Write a query in SQL to obtain the nurses and the block where they are 
  booked for attending the patients on call.
  select * from nurse;
  select * from on_call;
  select n.name as nurse_name, blockcode, oncall
  from nurse n
  inner join on_call oc
  on n.employeeid=oc.nurse;
  
  31) Write a SQL query to obtain the names of all the physicians performed a 
  medical procedure but they are not ceritifed to perform
  select * from physician;
  select * from medical_procedure;
  select * from trained_in;
  select * from undergoes;
  select ph.name as physician_name
  from physician ph 
  inner join undergoes u 
  on u.physicians=ph.employeeid 
  inner join trained_in ti 
  on ti.treatment= u.physicians 
  where treatment is null;
  
