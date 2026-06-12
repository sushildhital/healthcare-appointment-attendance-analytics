-- ============================================================
-- No-Show Analysis
-- Healthcare Appointment Attendance Analytics
-- ============================================================

-- Overall no-show rate

SELECT
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments;


-- No-show rate by gender

SELECT
    gender,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY gender
ORDER BY no_show_rate DESC;


-- No-show rate by age group

SELECT
    age_group,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY age_group
ORDER BY no_show_rate DESC;


-- No-show rate by waiting days bucket

SELECT
    CASE
        WHEN waiting_days BETWEEN 0 AND 7 THEN '0-7 days'
        WHEN waiting_days BETWEEN 8 AND 14 THEN '8-14 days'
        WHEN waiting_days BETWEEN 15 AND 30 THEN '15-30 days'
        ELSE '30+ days'
    END AS waiting_bucket,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY waiting_bucket
ORDER BY no_show_rate DESC;


-- No-show rate by SMS received

SELECT
    sms_received,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY sms_received
ORDER BY no_show_rate DESC;


-- No-show rate by medical conditions

SELECT
    hypertension,
    diabetes,
    alcoholism,
    handcap,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY hypertension, diabetes, alcoholism, handcap
ORDER BY no_show_rate DESC;


-- Top 10 neighbourhoods with highest no-show rate

SELECT
    neighbourhood,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY neighbourhood
HAVING COUNT(*) > 100
ORDER BY no_show_rate DESC
LIMIT 10;