USE crownfield_eye_hospital;

-- Query 1: clinicians with at least two appointments
SELECT c.clinician_id,
       CONCAT(c.first_name, ' ', c.last_name) AS clinician_name,
       COUNT(a.appointment_id) AS appointment_count
FROM clinician c
INNER JOIN appointment a ON c.clinician_id = a.clinician_id
GROUP BY c.clinician_id, c.first_name, c.last_name
HAVING COUNT(a.appointment_id) >= 2;

-- Query 2: appointment schedule across four related tables
SELECT a.appointment_id,
       CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       CONCAT(c.first_name, ' ', c.last_name) AS clinician_name,
       cl.clinic_name, a.appointment_date, a.appointment_time, a.status
FROM appointment a
INNER JOIN patient p ON a.patient_id = p.patient_id
INNER JOIN clinician c ON a.clinician_id = c.clinician_id
INNER JOIN clinic cl ON a.clinic_id = cl.clinic_id
ORDER BY a.appointment_date, a.appointment_time;

-- Query 3: appointments with no diagnosis
SELECT a.appointment_id, p.first_name, p.last_name,
       a.appointment_date, a.status, d.diagnosis_name
FROM appointment a
LEFT JOIN diagnosis d ON a.appointment_id = d.appointment_id
INNER JOIN patient p ON a.patient_id = p.patient_id
WHERE d.diagnosis_id IS NULL
ORDER BY a.appointment_id;

-- Query 4: patients with more than one appointment
SELECT p.patient_id, p.first_name, p.last_name
FROM patient p
WHERE p.patient_id IN (
   SELECT a.patient_id
   FROM appointment a
   GROUP BY a.patient_id
   HAVING COUNT(*) > 1
);
