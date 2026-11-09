# Crownfield Eye Hospital Database

Student ID: G1445007

This individual repository contains my MySQL implementation and the ER diagram created in Draw.io for the CPU4:103 assessment.

## Setup

1. Open MySQL Workbench and connect to a MySQL 8 server.
2. Run the numbered SQL files in order.
3. Use a fresh database or remove the existing `crownfield_eye_hospital` database before repeating the full build.
4. The security script assumes that the four named roles or accounts already exist on the selected MySQL server.

## Execution order

1. `01_create_database.sql`
2. `02_create_tables.sql`
3. `03_insert_sample_data.sql`
4. `04_individual_queries.sql`
5. `05_procedure_and_trigger.sql`
6. `06_security_and_transactions.sql`
7. `07_database_testing.sql`

The ER diagram is supplied as `08_Crownfield_Eye_Hospital_ERD.pdf`.

## Individual SQL coverage

- Aggregate query with `GROUP BY` and `HAVING`
- `INNER JOIN` across four tables
- `LEFT JOIN` showing appointments without diagnoses
- Subquery showing patients with repeated appointments
- Stored procedure with an input parameter
- Trigger applying a follow-up date rule
- Role permissions, SHA-256 hashing and transaction rollback

## Assumptions

- Each clinician has one primary specialty.
- Every appointment belongs to one patient, clinician and clinic.
- Diagnoses and prescriptions are optional outcomes of an appointment.
- An appointment has at most one follow-up plan in this prototype.
- All patient and clinical data is fictional and used only for assessment.
