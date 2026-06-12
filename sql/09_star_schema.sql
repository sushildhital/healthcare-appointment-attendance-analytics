-- ============================================================
-- Star Schema Implementation
-- Healthcare Appointment Attendance Analytics
-- ============================================================

-- ============================================================
-- 1. DIMENSION TABLE: dim_patient
-- ============================================================

CREATE TABLE dim_patient AS
SELECT DISTINCT
    patient_id,
    gender,
    age,
    age_group,
    scholarship
FROM healthcare.appointments;


-- ============================================================
-- 2. DIMENSION TABLE: dim_location
-- ============================================================

CREATE TABLE dim_location AS
SELECT DISTINCT
    neighbourhood
FROM healthcare.appointments;


-- ============================================================
-- 3. DIMENSION TABLE: dim_conditions
-- ============================================================

CREATE TABLE dim_conditions AS
SELECT DISTINCT
    patient_id,
    hypertension,
    diabetes,
    alcoholism,
    handcap
FROM healthcare.appointments;


-- ============================================================
-- 4. DIMENSION TABLE: dim_date
-- ============================================================

CREATE TABLE dim_date AS
SELECT DISTINCT
    appointment_day AS full_date,
    EXTRACT(YEAR FROM appointment_day) AS year,
    EXTRACT(MONTH FROM appointment_day) AS month,
    EXTRACT(DAY FROM appointment_day) AS day,
    TO_CHAR(appointment_day, 'Day') AS weekday
FROM healthcare.appointments;


-- ============================================================
-- 5. FACT TABLE: fact_appointments
-- ============================================================

CREATE TABLE fact_appointments AS
SELECT
    appointment_id,
    patient_id,
    appointment_day AS date_id,
    neighbourhood AS location_id,

    waiting_days,
    sms_received,
    attendance_status
FROM healthcare.appointments;


-- ============================================================
-- 6. OPTIONAL: BASIC RELATIONSHIP CHECK (VALIDATION)
-- ============================================================

-- Check fact table row count
SELECT COUNT(*) AS fact_rows FROM fact_appointments;

-- Check dimension counts
SELECT COUNT(*) AS patient_dim_rows FROM dim_patient;
SELECT COUNT(*) AS location_dim_rows FROM dim_location;
SELECT COUNT(*) AS condition_dim_rows FROM dim_conditions;
SELECT COUNT(*) AS date_dim_rows FROM dim_date;