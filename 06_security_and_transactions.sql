USE crownfield_eye_hospital;

-- Role privileges
GRANT ALL PRIVILEGES ON crownfield_eye_hospital.* TO 'hospital_admin';
GRANT SELECT ON crownfield_eye_hospital.* TO 'doctor_role';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.appointment TO 'receptionist_role';
GRANT SELECT ON crownfield_eye_hospital.patient TO 'receptionist_role';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.prescription TO 'pharmacist_role';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.prescription_item TO 'pharmacist_role';
GRANT SELECT ON crownfield_eye_hospital.medicine TO 'pharmacist_role';

SHOW GRANTS FOR 'hospital_admin';
SHOW GRANTS FOR 'doctor_role';
SHOW GRANTS FOR 'receptionist_role';
SHOW GRANTS FOR 'pharmacist_role';

-- Data protection demonstration
SELECT patient_id,
       SHA2(CONCAT(patient_id, first_name, last_name), 256)
       AS hashed_patient_identifier
FROM patient;

-- Transaction and rollback demonstration
START TRANSACTION;
UPDATE patient SET first_name = 'TestName' WHERE patient_id = 'P001';
SELECT patient_id, first_name FROM patient WHERE patient_id = 'P001';
ROLLBACK;
SELECT patient_id, first_name FROM patient WHERE patient_id = 'P001';
