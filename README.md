# Healthcare Appointment Attendance Analytics

## Project Overview

This project analyzes over 110,000 healthcare appointments to understand patient behavior and identify key factors contributing to appointment no-shows.

The objective is to build an end-to-end data analytics pipeline from raw data to business insights.

Pipeline includes:
- Data cleaning & feature engineering (Python)
- Data storage in PostgreSQL
- SQL-based analytics
- Business insights generation
- Power BI dashboard (future work)

---

## Problem Statement

Healthcare systems face challenges with missed appointments, leading to:
- Wasted medical resources
- Increased waiting times
- Reduced operational efficiency

This project aims to identify patterns behind patient no-shows and suggest actionable insights.

---

## Tech Stack

- Python (Pandas, NumPy, Matplotlib, Seaborn)
- PostgreSQL
- SQL
- Jupyter Notebook
- Power BI
- Git & GitHub

---

## Dataset Features

- Patient demographics: Age, Gender
- Medical conditions: Hypertension, Diabetes, Alcoholism, Handicap
- Appointment details: ScheduledDay, AppointmentDay
- Behavioral factors: SMS_received, WaitingDays
- Target variable: AttendanceStatus (Show / No-show)

---

## Project Workflow

Raw Data
→ Python Cleaning & Feature Engineering
→ Processed Dataset
→ PostgreSQL Database
→ SQL Analysis Layer
→ Business Insights
→ Power BI Dashboard

---

## SQL Analysis Files

sql/
├── 01_create_schema.sql
├── 02_standardize_columns.sql
├── 03_data_quality_checks.sql
├── 04_exploratory_analysis.sql
├── 05_attendance_analysis.sql
├── 06_no_show_analysis.sql
└── 07_business_insights_summary.sql

---

## Key Insights

- Waiting time increases no-show probability
- SMS reminders improve attendance rates
- Certain age groups show higher no-show rates
- Geographic variation exists in attendance behavior
- Medical conditions influence attendance patterns

---

## Project Status

- Data Cleaning: Completed
- PostgreSQL Setup: Completed
- SQL Analysis: Completed
- Business Insights: Completed
- Power BI Dashboard: In Progress

---

## Author

Sushil Dhital
Aspiring Data Engineer | SQL | Python | Analytics
