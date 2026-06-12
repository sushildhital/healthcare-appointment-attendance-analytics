-- Data Quality Checks
-- Validate row counts, missing values, and categorical values

-- Check total record count

SELECT COUNT(*) AS total_records
FROM healthcare.appointments;

-- Check for missing age values

SELECT COUNT(*) AS missing_age_records
FROM healthcare.appointments
WHERE age IS NULL;

-- Check for missing waiting days

SELECT COUNT(*) AS missing_waiting_days
FROM healthcare.appointments
WHERE waiting_days IS NULL;

-- Check for duplicate appointment IDs

SELECT appointment_id,
       COUNT(*) AS record_count
FROM healthcare.appointments
GROUP BY appointment_id
HAVING COUNT(*) > 1;

-- Validate attendance status values

SELECT DISTINCT attendance_status
FROM healthcare.appointments
ORDER BY attendance_status;

-- Validate gender values

SELECT DISTINCT gender
FROM healthcare.appointments
ORDER BY gender;

-- Validate age group values

SELECT DISTINCT age_group
FROM healthcare.appointments
ORDER BY age_group;

-- Check waiting days range

SELECT
    MIN(waiting_days) AS min_waiting_days,
    MAX(waiting_days) AS max_waiting_days
FROM healthcare.appointments;

-- Check no-show distribution

SELECT
    attendance_status,
    COUNT(*) AS appointment_count
FROM healthcare.appointments
GROUP BY attendance_status
ORDER BY appointment_count DESC;