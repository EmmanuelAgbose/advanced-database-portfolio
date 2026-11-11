
# Database Requirements and Entity Identification

## 1. Introduction

The PrimeCare Hospital Management Database System is designed to manage patient information, doctors, appointments, diagnoses, prescriptions and laboratory records.

The database will provide a centralised platform for storing, managing and retrieving hospital information while maintaining data accuracy and consistency.

## 2. Functional Requirements

The database system must be able to:

1. Register and maintain patient records.
2. Store and manage doctors' information.
3. Schedule, update and cancel appointments.
4. Record patient diagnoses.
5. Create and manage medical prescriptions.
6. Record laboratory investigations and results.
7. Retrieve patients' medical histories.
8. Maintain relationships between patients, doctors and medical records.

## 3. Non-Functional Requirements

The system should provide:

1. **Security:** Only authorised users should access medical records.
2. **Data Integrity:** Information must remain accurate and consistent.
3. **Availability:** Authorised users should be able to access the database when required.
4. **Performance:** Patient records and medical histories should be retrieved efficiently.
5. **Scalability:** The database should support increasing numbers of patients and medical records.
6. **Reliability:** The system should minimise data loss and support database recovery.

## 4. Database Entities and Attributes

The proposed database will contain six main entities.

### 4.1 Patients

Stores personal information about individuals receiving healthcare services.

| Attribute | Description |
|---|---|
| patient_id (PK) | Unique patient identifier |
| first_name | Patient's first name |
| last_name | Patient's surname |
| date_of_birth | Patient's date of birth |
| gender | Patient's gender |
| phone | Contact number |
| email | Email address |
| address | Residential address |

### 4.2 Doctors

Stores information about medical professionals working at the hospital.

| Attribute | Description |
|---|---|
| doctor_id (PK) | Unique doctor identifier |
| first_name | Doctor's first name |
| last_name | Doctor's surname |
| speciality | Medical specialisation |
| phone | Contact number |
| email | Email address |

### 4.3 Appointments

Stores information about appointments scheduled between patients and doctors.

| Attribute | Description |
|---|---|
| appointment_id (PK) | Unique appointment identifier |
| patient_id (FK) | References the patient |
| doctor_id (FK) | References the doctor |
| appointment_date | Scheduled appointment date |
| appointment_time | Scheduled appointment time |
| status | Appointment status |
| reason | Reason for appointment |

### 4.4 Diagnoses

Stores medical diagnoses recorded during patient consultations.

| Attribute | Description |
|---|---|
| diagnosis_id (PK) | Unique diagnosis identifier |
| appointment_id (FK) | References the appointment |
| diagnosis_description | Medical diagnosis |
| diagnosis_date | Date diagnosis was recorded |
| notes | Additional clinical notes |

### 4.5 Prescriptions

Stores medication prescribed to patients by doctors.

| Attribute | Description |
|---|---|
| prescription_id (PK) | Unique prescription identifier |
| diagnosis_id (FK) | References the diagnosis |
| medication_name | Name of prescribed medication |
| dosage | Prescribed dosage |
| frequency | Medication frequency |
| duration | Treatment duration |
| prescription_date | Date prescription was issued |

### 4.6 Laboratory Records

Stores laboratory investigations and their corresponding results.

| Attribute | Description |
|---|---|
| lab_record_id (PK) | Unique laboratory record identifier |
| appointment_id (FK) | References the appointment |
| test_name | Name of laboratory test |
| test_date | Date test was conducted |
| test_result | Recorded laboratory result |
| remarks | Additional laboratory comments |

## 5. Database Relationships

The proposed database will maintain the following relationships:

1. One patient can have many appointments.
2. One doctor can attend to many appointments.
3. One appointment can have multiple diagnosis records.
4. One diagnosis can have multiple prescriptions.
5. One appointment can have multiple laboratory records.

## 6. Summary

The six identified entities form the foundation of the PrimeCare Hospital Management Database System.

Their attributes and relationships will guide the development of the Entity Relationship Diagram (ERD), relational database schema, primary keys, foreign keys and database constraints.

