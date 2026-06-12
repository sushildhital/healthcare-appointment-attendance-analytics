-- ============================================================
-- Advanced SQL Analysis (CTEs + Window Functions)
-- Healthcare Appointment Attendance Analytics
-- ============================================================

-- ============================================================
-- 1. Overall Attendance Metrics using CTE
-- ============================================================

WITH base_stats AS (
    SELECT
        COUNT(*) AS total_appointments,
        SUM(CASE WHEN attendance_status = 'Show' THEN 1 ELSE 0 END) AS total_shows,
        SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS total_no_shows
    FROM healthcare.appointments
)
SELECT
    total_appointments,
    total_shows,
    total_no_shows,
    ROUND(100.0 * total_shows / total_appointments, 2) AS attendance_rate,
    ROUND(100.0 * total_no_shows / total_appointments, 2) AS no_show_rate
FROM base_stats;


-- ============================================================
-- 2. No-show ranking by neighbourhood (Window Function)
-- ============================================================

WITH neighbourhood_stats AS (
    SELECT
        neighbourhood,
        COUNT(*) AS total_appointments,
        SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows
    FROM healthcare.appointments
    GROUP BY neighbourhood
)
SELECT
    neighbourhood,
    total_appointments,
    no_shows,
    ROUND(100.0 * no_shows / total_appointments, 2) AS no_show_rate,
    RANK() OVER (ORDER BY (100.0 * no_shows / total_appointments) DESC) AS risk_rank
FROM neighbourhood_stats
WHERE total_appointments > 100;


-- ============================================================
-- 3. Age Group Risk Ranking
-- ============================================================

WITH age_stats AS (
    SELECT
        age_group,
        COUNT(*) AS total_appointments,
        SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows
    FROM healthcare.appointments
    GROUP BY age_group
)
SELECT
    age_group,
    total_appointments,
    no_shows,
    ROUND(100.0 * no_shows / total_appointments, 2) AS no_show_rate,
    DENSE_RANK() OVER (ORDER BY (100.0 * no_shows / total_appointments) DESC) AS risk_rank
FROM age_stats;


-- ============================================================
-- 4. Waiting Time Impact using Window Bucketing
-- ============================================================

WITH waiting_analysis AS (
    SELECT
        waiting_days,
        attendance_status,
        CASE
            WHEN waiting_days BETWEEN 0 AND 7 THEN '0-7 days'
            WHEN waiting_days BETWEEN 8 AND 14 THEN '8-14 days'
            WHEN waiting_days BETWEEN 15 AND 30 THEN '15-30 days'
            ELSE '30+ days'
        END AS waiting_bucket
    FROM healthcare.appointments
)
SELECT
    waiting_bucket,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(100.0 * SUM(CASE WHEN attendance_status = 'No-show' THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate
FROM waiting_analysis
GROUP BY waiting_bucket
ORDER BY no_show_rate DESC;


-- ============================================================
-- 5. Patient Risk Scoring (Window + Case Logic)
-- ============================================================

WITH risk_base AS (
    SELECT
        patient_id,
        age,
        waiting_days,
        sms_received,
        attendance_status,
        CASE
            WHEN waiting_days > 30 THEN 2 ELSE 0
        END +
        CASE
            WHEN sms_received = 0 THEN 2 ELSE 0
        END +
        CASE
            WHEN age > 60 THEN 1 ELSE 0
        END AS risk_score
    FROM healthcare.appointments
)
SELECT
    patient_id,
    age,
    waiting_days,
    sms_received,
    risk_score,
    RANK() OVER (ORDER BY risk_score DESC) AS risk_rank
FROM risk_base
ORDER BY risk_score DESC
LIMIT 20;