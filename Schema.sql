-- ============================================================
-- MIT 8103: Advanced Database Systems
-- Portfolio 1: Database Design and Modelling
-- Case Study: PrimeCare Hospital Management System
-- File: PrimeCare_Hospital_Relational_Schema.sql
-- DBMS: MySQL 8.0+
--
-- Purpose:
--   Create the PrimeCare Hospital database and its six core tables.
--   This script implements the relational schema, primary keys,
--   foreign keys, and integrity constraints.
--
-- Note:
--   This script does not insert real patient information.
--   Use fictional/sample data only for coursework testing.
-- ============================================================

CREATE DATABASE IF NOT EXISTS primecare_hospital
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE primecare_hospital;

-- ------------------------------------------------------------
-- 1. PATIENTS
-- Stores the personal and contact details of registered patients.
-- One patient can have many appointments.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS patients (
    patient_id INT UNSIGNED AUTO_INCREMENT COMMENT 'Unique patient ID',
    first_name VARCHAR(50) NOT NULL COMMENT 'First name',
    last_name VARCHAR(50) NOT NULL COMMENT 'Last name',
    date_of_birth DATE NOT NULL COMMENT 'Date of birth',
    gender VARCHAR(15) NOT NULL COMMENT 'Patient gender',
    phone VARCHAR(20) COMMENT 'Contact number',
    email VARCHAR(100) COMMENT 'Email address',
    address VARCHAR(255) COMMENT 'Residential address',

    CONSTRAINT pk_patients PRIMARY KEY (patient_id),
    CONSTRAINT uq_patients_email UNIQUE (email),
    CONSTRAINT chk_patients_gender
        CHECK (gender IN ('Female', 'Male', 'Other', 'Prefer not to say'))
) ENGINE = InnoDB;

-- ------------------------------------------------------------
-- 2. DOCTORS
-- Stores the names and professional details of hospital doctors.
-- One doctor can attend many appointments.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS doctors (
    doctor_id INT UNSIGNED AUTO_INCREMENT COMMENT 'Unique doctor ID',
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    speciality VARCHAR(100) NOT NULL COMMENT 'Doctor medical speciality',
    phone VARCHAR(20),
    email VARCHAR(100),

    CONSTRAINT pk_doctors PRIMARY KEY (doctor_id),
    CONSTRAINT uq_doctors_email UNIQUE (email)
) ENGINE = InnoDB;

-- ------------------------------------------------------------
-- 3. APPOINTMENTS
-- Connects each patient to the doctor they are scheduled to see.
-- Each appointment belongs to one patient and one doctor.
-- A patient and a doctor can each have many appointments.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS appointments (
    appointment_id INT UNSIGNED AUTO_INCREMENT COMMENT 'Unique appointment ID',
    patient_id INT UNSIGNED NOT NULL COMMENT 'Patient linked to appointment',
    doctor_id INT UNSIGNED NOT NULL COMMENT 'Doctor assigned to appointment',
    appointment_date DATE NOT NULL COMMENT 'Appointment date',
    appointment_time TIME NOT NULL COMMENT 'Appointment time',
    status VARCHAR(30) NOT NULL DEFAULT 'Scheduled' COMMENT 'Appointment status',
    reason VARCHAR(255) COMMENT 'Reason for appointment',

    CONSTRAINT pk_appointments PRIMARY KEY (appointment_id),

    CONSTRAINT fk_appointments_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients (patient_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_appointments_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES doctors (doctor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_appointments_status
        CHECK (status IN ('Scheduled', 'Completed', 'Cancelled', 'No-show')),

    INDEX idx_appointments_patient (patient_id),
    INDEX idx_appointments_doctor (doctor_id),
    INDEX idx_appointments_date (appointment_date)
