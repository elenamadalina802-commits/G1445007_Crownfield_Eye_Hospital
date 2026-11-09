USE crownfield_eye_hospital;
DELIMITER $$
CREATE PROCEDURE GetPatientAppointments(
   IN p_patient_id VARCHAR(10)
)
BEGIN
   SELECT
       a.appointment_id,
       a.appointment_date,
       a.appointment_time,
       a.status
   FROM appointment a
   WHERE a.patient_id = p_patient_id
   ORDER BY a.appointment_date;
END $$
DELIMITER ;

CALL GetPatientAppointments('P001');

USE crownfield_eye_hospital;


CREATE TRIGGER trg_followup_date
BEFORE INSERT ON follow_up
FOR EACH ROW
SET NEW.due_date = GREATEST(
   NEW.due_date,
   (SELECT appointment_date
    FROM appointment
    WHERE appointment_id = NEW.appointment_id)
);

SHOW TRIGGERS FROM crownfield_eye_hospital;

DESCRIBE follow_up;

START TRANSACTION;
INSERT INTO follow_up (appointment_id, due_date, priority, status)
VALUES (11, '2020-01-01', 'High', 'Pending');
SELECT
   f.appointment_id,
   a.appointment_date,
   f.due_date
FROM follow_up f
JOIN appointment a ON f.appointment_id = a.appointment_id
WHERE f.appointment_id = 11;
ROLLBACK;