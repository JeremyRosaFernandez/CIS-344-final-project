create database  hospital_portal;

use hospital_portal;

create table patients (
    patient_id int not null auto_increment primary key,
    patient_name varchar(45) not null,
    age int not null,
    admission_date date,
    discharge_date date
);

create table appointments (
    appointment_id int not null auto_increment primary key,
    patient_id int not null,
    doctor_id int not null,
    appointment_date date not null,
    appointment_time decimal not null,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

insert into patients (patient_name, age, admission_date, discharge_date)
VALUES
    ('Maria Jozef', 67, '2023-10-01', '2023-10-07'),
    ('Albert Fernandez', 45, '2023-09-15', '2023-09-22'),
    ('Luis Jose', 32, '2023-11-05', '2023-11-22');
    
select * from patients;

delimiter //

create procedure ScheduleAppointment(
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_appointment_date DATE,
    IN p_appointment_time DECIMAL
)
begin
    insert into appointments (patient_id, doctor_id, appointment_date, appointment_time)
    VALUES (p_patient_id, p_doctor_id, p_appointment_date, p_appointment_time);
end //

delimiter ;

delimiter //

create procedure DischargePatient(IN p_patient_id INT)
begin
    update patients SET discharge_date = current_date where patient_id = p_patient_id;
end //

delimiter ;

create table doctors (
    doctor_id int not null auto_increment primary key,
    doctor_name varchar(45) not null
);

INSERT INTO doctors (doctor_name) VALUES
    ('Dr. Jose'),
    ('Dr. Alex'),
    ('Dr. Chris');

create view appointment_view AS
select
    a.appointment_id,
    p.patient_name,
    p.age,
    a.appointment_date,
    a.appointment_time,
    d.doctor_name
from
    appointments a
    join patients p on a.patient_id = p.patient_id
    join doctors d on a.doctor_id = d.doctor_id;
