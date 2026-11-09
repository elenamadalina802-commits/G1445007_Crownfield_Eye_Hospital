USE crownfield_eye_hospital;

INSERT INTO specialty (specialty_name) VALUES
('Ophthalmology'),
('Optometry'),
('Retina'),
('Glaucoma'),
('Cornea'),
('Paediatric Ophthalmology'),
('Neuro-Ophthalmology'),
('Oculoplastics'),
('Cataract Surgery'),
('Low Vision');

INSERT INTO patient
(patient_id, first_name, last_name, postcode, date_of_birth, phone, email)
VALUES
('P001', 'John', 'Smith', 'WV1 1AA', '1980-03-15', '07111000001', 'john.smith@example.com'),
('P002', 'Emma', 'Wilson', 'WV2 2BB', '1992-07-22', '07111000002', 'emma.wilson@example.com'),
('P003', 'Michael', 'Brown', 'WV3 3CC', '1975-11-08', '07111000003', 'michael.brown@example.com'),
('P004', 'Sarah', 'Taylor', 'WV4 4DD', '1988-05-12', '07111000004', 'sarah.taylor@example.com'),
('P005', 'David', 'Jones', 'WV5 5EE', '1965-09-30', '07111000005', 'david.jones@example.com'),
('P006', 'Olivia', 'Davies', 'WV6 6FF', '2001-01-18', '07111000006', 'olivia.davies@example.com'),
('P007', 'James', 'Evans', 'WV7 7GG', '1995-04-25', '07111000007', 'james.evans@example.com'),
('P008', 'Sophia', 'Thomas', 'WV8 8HH', '1983-12-03', '07111000008', 'sophia.thomas@example.com'),
('P009', 'Daniel', 'Roberts', 'WV9 9JJ', '1970-06-14', '07111000009', 'daniel.roberts@example.com'),
('P010', 'Emily', 'Walker', 'WV10 0AB', '1999-10-09', '07111000010', 'emily.walker@example.com');

INSERT INTO clinic (clinic_name, address)
VALUES
('City Road', '12 City Road'),
('Bedford', '5 Bedford Street'),
('Croydon', '18 High Street'),
('North Wing', 'Crownfield Hospital North Wing'),
('South Wing', 'Crownfield Hospital South Wing'),
('Retina Centre', '22 Medical Avenue'),
('Glaucoma Suite', '14 Vision Lane'),
('Cornea Unit', '7 Eye Care Road'),
('Paediatric Clinic', '10 Children Way'),
('Urgent Eye Clinic', '1 Emergency Road');

INSERT INTO clinician
(first_name, last_name, specialty_id, email)
VALUES
('Maya', 'Shah', 4, 'maya.shah@crownfield.test'),
('Leo', 'Grant', 3, 'leo.grant@crownfield.test'),
('Priya', 'Nair', 5, 'priya.nair@crownfield.test'),
('James', 'Collins', 9, 'james.collins@crownfield.test'),
('Sarah', 'Ahmed', 6, 'sarah.ahmed@crownfield.test'),
('Peter', 'Wong', 7, 'peter.wong@crownfield.test'),
('Helen', 'Brooks', 2, 'helen.brooks@crownfield.test'),
('David', 'Okafor', 1, 'david.okafor@crownfield.test'),
('Nina', 'Patel', 8, 'nina.patel@crownfield.test'),
('Grace', 'Morgan', 10, 'grace.morgan@crownfield.test');

INSERT INTO appointment
(patient_id, clinician_id, clinic_id,
appointment_date, appointment_time, notes, status)
VALUES
('P001', 1, 1, '2026-10-05', '09:00:00', 'Eye pressure review', 'Completed'),
('P002', 2, 2, '2026-10-06', '09:30:00', 'Retina examination', 'Completed'),
('P003', 3, 3, '2026-10-07', '10:00:00', 'Cornea assessment', 'Completed'),
('P004', 4, 4, '2026-10-08', '10:30:00', 'Cataract consultation', 'Completed'),
('P005', 5, 5, '2026-10-09', '11:00:00', 'Vision examination', 'Completed'),
('P006', 6, 6, '2026-10-12', '11:30:00', 'Neuro ophthalmology review', 'Completed'),
('P007', 7, 7, '2026-10-13', '12:00:00', 'Optometry examination', 'Completed'),
('P008', 8, 8, '2026-10-14', '13:00:00', 'General eye examination', 'Completed'),
('P009', 9, 9, '2026-11-16', '14:00:00', 'Eyelid consultation', 'Scheduled'),
('P010', 10, 10, '2026-11-17', '14:30:00', 'Low vision assessment', 'Scheduled'),
('P001', 1, 1, '2026-11-18', '09:00:00', 'Follow up eye pressure', 'Scheduled');

SELECT appointment_id, patient_id, appointment_date, status
FROM appointment
ORDER BY appointment_id;

INSERT INTO diagnosis
(appointment_id, diagnosis_name, diagnosis_notes)
VALUES
(1, 'Ocular Hypertension', 'Elevated eye pressure'),
(1, 'Glaucoma Suspect', 'Further monitoring required'),
(2, 'Diabetic Macular Oedema', 'Retinal swelling identified'),
(2, 'Diabetic Retinopathy', 'Retinal changes observed'),
(3, 'Keratoconus', 'Corneal examination completed'),
(4, 'Cataract', 'Lens opacity identified'),
(5, 'Refractive Error', 'Vision correction required'),
(6, 'Optic Neuropathy', 'Further assessment recommended'),
(7, 'Myopia', 'Distance vision reduced'),
(8, 'Dry Eye Syndrome', 'Lubricating treatment recommended');

INSERT INTO medicine (medicine_name)
VALUES
('Latanoprost'),
('Timolol'),
('Aflibercept'),
('Sodium Chloride Eye Drops'),
('Artificial Tears'),
('Brimonidine'),
('Dorzolamide'),
('Prednisolone Eye Drops'),
('Cyclopentolate'),
('Chloramphenicol');

INSERT INTO prescription
(appointment_id, prescription_date)
VALUES
(1, '2026-10-05'),
(1, '2026-10-05'),
(2, '2026-10-06'),
(2, '2026-10-06'),
(3, '2026-10-07'),
(4, '2026-10-08'),
(5, '2026-10-09'),
(6, '2026-10-12'),
(7, '2026-10-13'),
(8, '2026-10-14');

SELECT prescription_id, appointment_id, prescription_date
FROM prescription
ORDER BY prescription_id;

INSERT INTO prescription_item
(prescription_id, medicine_id, dose, route, frequency, duration_days)
VALUES
(1, 1, '1 drop', 'Ophthalmic', 'Once daily', 30),
(2, 2, '1 drop', 'Ophthalmic', 'Twice daily', 30),
(3, 3, '2 mg', 'Intravitreal', 'As directed', 30),
(4, 4, '1 drop', 'Ophthalmic', 'Twice daily', 14),
(5, 5, '1 drop', 'Ophthalmic', 'Three times daily', 14),
(6, 6, '1 drop', 'Ophthalmic', 'Twice daily', 30),
(7, 7, '1 drop', 'Ophthalmic', 'Twice daily', 30),
(8, 8, '1 drop', 'Ophthalmic', 'Four times daily', 7),
(9, 9, '1 drop', 'Ophthalmic', 'As directed', 7),
(10, 10, '1 drop', 'Ophthalmic', 'Four times daily', 7);

INSERT INTO follow_up
(appointment_id, due_date, priority, status)
VALUES
(1, '2026-11-16', 'High', 'Pending'),
(2, '2026-11-03', 'Urgent', 'Completed'),
(3, '2026-11-18', 'Routine', 'Pending'),
(4, '2026-11-19', 'Routine', 'Pending'),
(5, '2026-11-20', 'High', 'Pending'),
(6, '2026-11-23', 'Routine', 'Pending'),
(7, '2026-11-24', 'Routine', 'Pending'),
(8, '2026-11-25', 'High', 'Pending'),
(9, '2026-12-14', 'Routine', 'Pending'),
(10, '2026-12-15', 'Routine', 'Pending');

SELECT 'specialty' AS table_name, COUNT(*) AS total FROM specialty
UNION ALL
SELECT 'patient', COUNT(*) FROM patient
UNION ALL
SELECT 'clinic', COUNT(*) FROM clinic
UNION ALL
SELECT 'clinician', COUNT(*) FROM clinician
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