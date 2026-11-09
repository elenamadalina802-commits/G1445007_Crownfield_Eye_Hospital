USE crownfield_eye_hospital;
SELECT
   'patient' AS table_name,
   COUNT(*) AS total_records
FROM patient
UNION ALL
SELECT 'appointment', COUNT(*)
FROM appointment
UNION ALL
SELECT 'clinician', COUNT(*)
FROM clinician
UNION ALL
SELECT 'diagnosis', COUNT(*)
FROM diagnosis
UNION ALL
SELECT 'follow_up', COUNT(*)
FROM follow_up;

SELECT patient_id, first_name, last_name
FROM patient
ORDER BY patient_id;

DESCRIBE patient;
 
 ALTER TABLE patient
MODIFY date_of_birth DATE NULL;

INSERT INTO patient
(patient_id, first_name, last_name, postcode)
VALUES
('OP001', 'Amina', 'Yusuf', 'NE1 4AB'),
('OP002', 'Daniel', 'Reed', 'N16 7QP'),
('OP003', 'Sofia', 'Bennett', 'E8 2LD'),
('OP004', 'Michael', 'Okoro', 'SE6 3RT');

SELECT patient_id, first_name, last_name
FROM patient
WHERE patient_id LIKE 'OP%'
ORDER BY patient_id;

DESCRIBE appointment;

SELECT clinician_id, first_name, last_name
FROM clinician;
SELECT clinic_id, clinic_name
FROM clinic;

SELECT clinic_id, clinic_name
FROM clinic;

INSERT INTO appointment
(patient_id, clinician_id, clinic_id,
appointment_date, appointment_time, notes, status)
VALUES
('OP001', 1, 1, '2026-10-05', '09:00:00', 'Review IOP', 'Completed'),
('OP002', 2, 1, '2026-10-05', '09:30:00', 'OCT before review', 'Completed'),
('OP001', 1, 2, '2026-11-16', '10:15:00', 'Visual field test', 'Scheduled'),
('OP003', 1, 1, '2026-10-06', '11:00:00', 'Monitor', 'Completed'),
('OP004', 3, 3, '2026-10-07', '14:00:00', 'Corneal topography', 'Completed');

SELECT appointment_id, patient_id,

       appointment_date, appointment_time

FROM appointment

WHERE patient_id LIKE 'OP%'

ORDER BY appointment_date, appointment_time;

DESCRIBE diagnosis;

INSERT INTO diagnosis (appointment_id, diagnosis_name)
SELECT
   a.appointment_id,
   CASE
       WHEN a.patient_id = 'OP001' THEN 'Ocular hypertension'
       WHEN a.patient_id = 'OP002' THEN 'Diabetic macular oedema'
       WHEN a.patient_id = 'OP003' THEN 'Glaucoma suspect'
       WHEN a.patient_id = 'OP004' THEN 'Keratoconus'
   END
FROM appointment a
WHERE a.patient_id IN ('OP001', 'OP002', 'OP003', 'OP004')
AND NOT EXISTS (
   SELECT 1
   FROM diagnosis d
   WHERE d.appointment_id = a.appointment_id
);
 
 DESCRIBE medicine;
DESCRIBE prescription;
DESCRIBE prescription_item;
DESCRIBE follow_up;

INSERT IGNORE INTO medicine (medicine_name)
VALUES
('Latanoprost'),
('Timolol'),
('Aflibercept'),
('Sodium chloride drops');
INSERT INTO follow_up
(appointment_id, due_date, priority, status)
SELECT
   a.appointment_id,
   DATE_ADD(
       a.appointment_date,
       INTERVAL
       CASE
           WHEN a.patient_id = 'OP001'
                AND a.appointment_date = '2026-10-05' THEN 6
           WHEN a.patient_id = 'OP002' THEN 4
           WHEN a.patient_id = 'OP001'
                AND a.appointment_date = '2026-11-16' THEN 12
           WHEN a.patient_id = 'OP003' THEN 26
           WHEN a.patient_id = 'OP004' THEN 8
       END WEEK
   ),
   CASE
       WHEN a.patient_id = 'OP001'
            AND a.appointment_date = '2026-10-05' THEN 'High'
       WHEN a.patient_id = 'OP002' THEN 'Urgent'
       ELSE 'Routine'
   END,
   'Pending'
FROM appointment a
WHERE a.patient_id LIKE 'OP%'
AND NOT EXISTS (
   SELECT 1
   FROM follow_up f
   WHERE f.appointment_id = a.appointment_id
);

INSERT INTO prescription (appointment_id, prescription_date)
SELECT a.appointment_id, a.appointment_date
FROM appointment a
WHERE a.patient_id LIKE 'OP%'
AND a.patient_id <> 'OP003'
AND NOT EXISTS (
   SELECT 1
   FROM prescription p
   WHERE p.appointment_id = a.appointment_id
);

ALTER TABLE prescription_item
MODIFY duration_days INT NULL;
INSERT INTO prescription_item
(prescription_id, medicine_id, dose, route, frequency, duration_days)
SELECT
   p.prescription_id,
   m.medicine_id,
   'Not specified',
   NULL,
   'Not specified',
   NULL
FROM prescription p
JOIN appointment a
   ON p.appointment_id = a.appointment_id
JOIN medicine m
   ON (
       (a.patient_id = 'OP001'
        AND m.medicine_name = 'Latanoprost')
       OR
       (a.patient_id = 'OP001'
        AND a.appointment_date = '2026-10-05'
        AND m.medicine_name = 'Timolol')
       OR
       (a.patient_id = 'OP002'
        AND m.medicine_name = 'Aflibercept')
       OR
       (a.patient_id = 'OP004'
        AND m.medicine_name = 'Sodium chloride drops')
   )
WHERE a.patient_id LIKE 'OP%'
AND NOT EXISTS (
   SELECT 1
   FROM prescription_item pi
   WHERE pi.prescription_id = p.prescription_id
     AND pi.medicine_id = m.medicine_id
);

START TRANSACTION;
INSERT INTO medicine (medicine_name)
VALUES ('Temporary Test Medicine');
UPDATE medicine
SET medicine_name = 'Updated Test Medicine'
WHERE medicine_name = 'Temporary Test Medicine';
SELECT medicine_id, medicine_name
FROM medicine
WHERE medicine_name = 'Updated Test Medicine';
DELETE FROM medicine
WHERE medicine_name = 'Updated Test Medicine';
ROLLBACK;

SELECT 'patient' AS table_name, COUNT(*) AS total
FROM patient
UNION ALL
SELECT 'appointment', COUNT(*) FROM appointment
UNION ALL
SELECT 'diagnosis', COUNT(*) FROM diagnosis
UNION ALL
SELECT 'medicine', COUNT(*) FROM medicine
UNION ALL
SELECT 'prescription', COUNT(*) FROM prescription
UNION ALL
SELECT 'prescription_item', COUNT(*) FROM prescription_item
UNION ALL
SELECT 'follow_up', COUNT(*) FROM follow_up;