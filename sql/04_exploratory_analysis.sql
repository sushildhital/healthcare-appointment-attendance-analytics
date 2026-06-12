-- ============================================================
-- Exploratory Analysis
-- Healthcare Appointment Attendance Analytics
-- ============================================================

-- Total number of records

SELECT
    COUNT(*) AS total_records
FROM healthcare.appointments;


-- Gender distribution

SELECT
    gender,
    COUNT(*) AS patient_count
FROM healthcare.appointments
GROUP BY gender
ORDER BY patient_count DESC;


-- Age summary statistics

SELECT
    MIN(age) AS minimum_age,
    MAX(age) AS maximum_age,
    ROUND(AVG(age), 2) AS average_age
FROM healthcare.appointments;


-- Age group distribution

SELECT
    age_group,
    COUNT(*) AS patient_count
FROM healthcare.appointments
GROUP BY age_group
ORDER BY patient_count DESC;


-- Attendance status distribution

SELECT
    attendance_status,
    COUNT(*) AS appointment_count
FROM healthcare.appointments
GROUP BY attendance_status
ORDER BY appointment_count DESC;


-- Top 10 neighbourhoods by appointment volume

SELECT
    neighbourhood,
    COUNT(*) AS appointment_count
FROM healthcare.appointments
GROUP BY neighbourhood
ORDER BY appointment_count DESC
LIMIT 10;


-- Scholarship distribution

SELECT
    scholarship,
    COUNT(*) AS patient_count
FROM healthcare.appointments
GROUP BY scholarship
ORDER BY scholarship;


-- Hypertension distribution

SELECT
    hypertension,
    COUNT(*) AS patient_count
FROM healthcare.appointments
GROUP BY hypertension
ORDER BY hypertension;


-- Diabetes distribution

SELECT
    diabetes,
    COUNT(*) AS patient_count
FROM healthcare.appointments
GROUP BY diabetes
ORDER BY diabetes;


-- Alcoholism distribution

SELECT
    alcoholism,
    COUNT(*) AS patient_count
FROM healthcare.appointments
GROUP BY alcoholism
ORDER BY alcoholism;


-- Handicap distribution

SELECT
    handcap,
    COUNT(*) AS patient_count
FROM healthcare.appointments
GROUP BY handcap
ORDER BY handcap;


-- SMS reminder distribution

SELECT
    sms_received,
    COUNT(*) AS appointment_count
FROM healthcare.appointments
GROUP BY sms_received
ORDER BY sms_received;


-- Waiting days summary statistics

SELECT
    MIN(waiting_days) AS minimum_waiting_days,
    MAX(waiting_days) AS maximum_waiting_days,
    ROUND(AVG(waiting_days), 2) AS average_waiting_days
FROM healthcare.appointments;


-- Appointment date range

SELECT
    MIN(appointment_day) AS first_appointment_date,
    MAX(appointment_day) AS last_appointment_date
FROM healthcare.appointments;


-- Scheduling date range

SELECT
    MIN(scheduled_day) AS first_scheduled_date,
    MAX(scheduled_day) AS last_scheduled_date
FROM healthcare.appointments;