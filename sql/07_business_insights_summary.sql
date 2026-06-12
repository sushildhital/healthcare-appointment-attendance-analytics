-- ============================================================
-- Business Insights Summary
-- Healthcare Appointment Attendance Analytics
-- ============================================================

-- Overall KPIs

SELECT
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) AS total_shows,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS total_no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attendance_rate_percentage,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate_percentage
FROM healthcare.appointments;


-- Top risk factors (combined segmentation)

SELECT
    age_group,
    gender,
    scholarship,
    hypertension,
    diabetes,
    COUNT(*) AS total_appointments,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY age_group, gender, scholarship, hypertension, diabetes
HAVING COUNT(*) > 50
ORDER BY no_show_rate DESC
LIMIT 15;


-- Waiting time impact

SELECT
    CASE
        WHEN waiting_days BETWEEN 0 AND 7 THEN '0-7 days'
        WHEN waiting_days BETWEEN 8 AND 14 THEN '8-14 days'
        WHEN waiting_days BETWEEN 15 AND 30 THEN '15-30 days'
        ELSE '30+ days'
    END AS waiting_bucket,
    COUNT(*) AS total_appointments,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attendance_rate,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY waiting_bucket
ORDER BY no_show_rate DESC;


-- SMS impact

SELECT
    sms_received,
    COUNT(*) AS total_appointments,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attendance_rate,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY sms_received;


-- High-risk neighbourhoods

SELECT
    neighbourhood,
    COUNT(*) AS total_appointments,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY neighbourhood
HAVING COUNT(*) > 100
ORDER BY no_show_rate DESC
LIMIT 5;