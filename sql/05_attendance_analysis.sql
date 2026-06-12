-- ============================================================
-- Attendance Analysis
-- Healthcare Appointment Attendance Analytics
-- ============================================================

-- Overall attendance rate

SELECT
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attendance_rate_percentage
FROM healthcare.appointments;


-- No-show rate

SELECT
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate_percentage
FROM healthcare.appointments;


-- Attendance by gender

SELECT
    gender,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) AS shows,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY gender
ORDER BY no_show_rate DESC;


-- Attendance by age group

SELECT
    age_group,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) AS shows,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY age_group
ORDER BY no_show_rate DESC;


-- Attendance by scholarship status

SELECT
    scholarship,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) AS shows,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY scholarship
ORDER BY no_show_rate DESC;


-- Impact of waiting days on attendance

SELECT
    CASE
        WHEN waiting_days BETWEEN 0 AND 7 THEN '0-7 days'
        WHEN waiting_days BETWEEN 8 AND 14 THEN '8-14 days'
        WHEN waiting_days BETWEEN 15 AND 30 THEN '15-30 days'
        ELSE '30+ days'
    END AS waiting_period,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) AS shows,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY waiting_period
ORDER BY no_show_rate DESC;


-- SMS reminder impact

SELECT
    sms_received,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) AS shows,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS no_show_rate
FROM healthcare.appointments
GROUP BY sms_received
ORDER BY no_show_rate DESC;


-- Neighbourhood risk analysis (Top 10 highest no-show rates)

SELECT
    neighbourhood,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) AS shows,
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