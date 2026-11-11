Portfolio 1 – Normalisation Explanation
1. Understanding the original database design (UNF)
Imagine PrimeCare Hospital initially stores all its information in one large table called Hospital_Records.

It contains patient information, doctor information, appointments, diagnoses, prescriptions and laboratory results.

For example:
Patient ID	Patient Name	Doctor	Appointment	Diagnosis	Prescriptions
P001	John James	Dr. Smith	10 Nov 2026	Malaria	Artemether, Paracetamol
P002	Mary John	Dr. Peter	11 Nov 2026	Typhoid	Ciprofloxacin

What is wrong with this design?
1. A patient may have several appointments.
2. An appointment may have several prescriptions.
3. An appointment may have several laboratory tests.
4. Information can be repeated unnecessarily.
5. Updating one patient's information in several places can cause inconsistencies.
This is our starting point: an unnormalised design (UNF).

The purpose of normalisation is to organise this information properly and reduce duplication and data anomalies.

2. First Normal Form (1NF)
Stage 1
 Making every field atomic

Definition: A table is in First Normal Form when each column contains a single, indivisible value, and there are no repeating groups or multiple values stored in one field.
Step 1: Identify the problem
Look at this original record:
Patient ID	Patient Name	Prescriptions
P001	John James	Artemether, Paracetamol

The problem is that the Prescriptions column contains two different values in one cell.

1NF achieved
Step 2: Correct the design
We separate the prescriptions so that each row contains one prescription.
Patient ID	Patient Name	Prescription
P001	John James	Artemether
P001	John James	Paracetamol

- We can retrieve individual prescriptions.
Now each cell contains only one value.
Step 3: Why does this matter?
This violates 1NF.
- We can add a new prescription without changing an existing cell.
- We can search and update prescription records more easily.
- We avoid storing multiple values in one column.
Our reasoning: First Normal Form focuses on eliminating repeating groups and ensuring that each field contains one value.

3. Second Normal Form (2NF)
Stage 2
 Removing partial dependencies

Definition: A table is in Second Normal Form when it is already in 1NF and every non-key attribute depends on the whole candidate key, not just part of a composite key.

This is where we start examining how the information relates to the primary key.
Step 1: Consider our 1NF design
Suppose we have a prescription record with a composite primary key:

(Appointment_ID, Prescription_Line_No)
Appointment ID	Prescription Line No	Patient Name	Doctor Name	Medication
A001	1	John James	Dr. Smith	Artemether
A001	2	John James	Dr. Smith	Paracetamol
A002	1	Mary John	Dr. Peter	Ciprofloxacin

The key consists of two columns.

However, look closely:
- Appointment_ID determines the patient and doctor.
- Prescription_Line_No distinguishes the prescription within the appointment.
- Patient and doctor information does not need the entire composite key to be identified.
This is called a partial dependency.
Step 2: Correct the design
We separate appointment information from prescription information.

Table A: Appointments
Appointment ID	Patient ID	Doctor ID
A001	P001	D001
A002	P002	D002

Table B: Prescriptions
Prescription ID	Appointment ID	Medication
PR001	A001	Artemether
PR002	A001	Paracetamol
PR003	A002	Ciprofloxacin

2NF achieved
The appointment details are now stored separately from the prescription details.
Step 3: Why does this matter?
- We reduce unnecessary repetition.
- We can add several prescriptions to one appointment.
- Updating appointment information does not require changing every prescription row.
- Each table represents a more clearly defined subject.
Our reasoning: Second Normal Form removes partial dependencies, ensuring that non-key attributes depend on the whole candidate key.

An important technical point: In our final design, each table uses a single-column primary key. Once the tables satisfy 1NF, they automatically satisfy 2NF with respect to that primary key, provided their candidate keys have no partial dependencies.

4. Third Normal Form (3NF)
Stage 3
 Removing transitive dependencies

Definition: A table is in Third Normal Form when it is already in 2NF and non-key attributes depend directly on the key, not on other non-key attributes.

Let's understand this with PrimeCare Hospital.
Step 1: Identify the problem
Suppose our appointment table looks like this:
Appointment ID	Patient ID	Patient Name	Doctor ID	Doctor Name	Speciality
A001	P001	John James	D001	Dr. Smith	Cardiology
A002	P002	Mary John	D001	Dr. Smith	Cardiology
A003	P003	David Peter	D002	Dr. Peter	Neurology

The problem is that patient and doctor details are repeated.

The dependencies are:
- Appointment_ID determines Patient_ID and Doctor_ID.
- Patient_ID determines Patient_Name.
- Doctor_ID determines Doctor_Name and Speciality.
Therefore, patient and doctor information depends indirectly on Appointment_ID, through other non-key attributes. These are transitive dependencies.
Step 2: Correct the design
We separate patient and doctor information into their own tables.

Patients
Patient ID	Patient Name
P001	John James
P002	Mary John
P003	David Peter

Doctors
Doctor ID	Doctor Name	Speciality
D001	Dr. Smith	Cardiology
D002	Dr. Peter	Neurology

Appointments
Appointment ID	Patient ID	Doctor ID
A001	P001	D001
A002	P002	D001
A003	P003	D002

3NF achieved
Now patient details are stored in the Patients table, doctor details in the Doctors table, and appointment details in the Appointments table.
Step 3: Why does this matter?
- We avoid repeating patient information.
- We avoid repeating doctor information.
- Updating a doctor's speciality happens in one place.
- The database becomes easier to maintain.
- We improve data consistency and integrity.
Our reasoning: Third Normal Form removes transitive dependencies so that non-key attributes depend directly on their table's key.

5. Our final PrimeCare Hospital database design
After applying 1NF, 2NF and 3NF, our database is organised into six tables.
PrimeCare Hospital – Final 3NF structure
PATIENTS

patient_id (PK), first_name, last_name, date_of_birth, gender, phone, email, address

DOCTORS

doctor_id (PK), first_name, last_name, speciality, phone, email


APPOINTMENTS

appointment_id (PK), patient_id (FK), doctor_id (FK), date, time, status, reason



DIAGNOSES

diagnosis_id (PK), appointment_id (FK), description, date, notes


LABORATORY_RECORDS

lab_record_id (PK), appointment_id (FK), test_name, date, result, remarks



PRESCRIPTIONS

prescription_id (PK), diagnosis_id (FK), medication_name, dosage, frequency, duration, prescription_date

This is the logical grouping of our six tables. The foreign keys connect the tables according to the ER diagram.
6. Summary of the three normalisation stages
Normal Form	Main purpose	What we achieved
1NF	Remove repeating groups	One value per cell
2NF	Remove partial dependencies	Separate appointment and prescription information
3NF	Remove transitive dependencies	Separate patient and doctor details

7. Academic conclusion for your portfolio
You can use this as the conclusion of your normalisation section:
The PrimeCare Hospital Management System database was designed using the principles of First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF). First Normal Form ensures that all attributes contain atomic values and that repeating groups are eliminated. Second Normal Form removes partial dependencies by ensuring that non-key attributes depend on the entire candidate key. Third Normal Form eliminates transitive dependencies by separating patient, doctor, appointment, diagnosis, prescription, and laboratory information into related tables. The resulting database structure reduces data redundancy, improves data integrity, supports efficient data management, and makes the system easier to maintain.
