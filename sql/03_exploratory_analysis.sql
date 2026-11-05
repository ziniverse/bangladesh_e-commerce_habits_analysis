
-- ============================================================
-- PROJECT: Bangladeshi E-commerce Consumer Habits
-- FILE: 03_exploratory_analysis.sql
-- PURPOSE: Exploratory and descriptive analysis of survey data
-- DATABASE: bangladesh_ecommerce_portfolio
-- ============================================================


-- ============================================================
-- 1. DATASET OVERVIEW
-- Check the number of records in each table.
-- ============================================================

SELECT
    'Respondents' AS table_name,
    COUNT(*) AS total_records
FROM survey_respondents

UNION ALL

SELECT
    'Questions',
    COUNT(*)
FROM survey_questions

UNION ALL

SELECT
    'Answers',
    COUNT(*)
FROM survey_answers;


-- ============================================================
-- 2. DATA QUALITY CHECKS
-- Check for missing values in important respondent fields.
-- ============================================================

SELECT
    COUNT(*) AS total_respondents,
    COUNT(*) FILTER (WHERE gender IS NULL) AS missing_gender,
    COUNT(*) FILTER (WHERE age_group IS NULL) AS missing_age,
    COUNT(*) FILTER (WHERE education_level IS NULL) AS missing_education,
    COUNT(*) FILTER (WHERE shopping_frequency IS NULL) AS missing_shopping_frequency,
    COUNT(*) FILTER (WHERE monthly_income IS NULL) AS missing_income,
    COUNT(*) FILTER (WHERE occupation IS NULL) AS missing_occupation
FROM survey_respondents;


-- Check for missing answer values.

SELECT
    COUNT(*) AS total_answers,
    COUNT(*) FILTER (WHERE response_value IS NULL) AS missing_responses
FROM survey_answers;


-- Check the distribution of Likert-scale responses.

SELECT
    response_value,
    COUNT(*) AS total_responses,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM survey_answers
GROUP BY response_value
ORDER BY response_value;


-- ============================================================
-- 3. RESPONDENT DEMOGRAPHICS
-- ============================================================


-- 3.1 Gender distribution

SELECT
    gender,
    COUNT(*) AS respondents,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM survey_respondents
GROUP BY gender
ORDER BY respondents DESC;


-- 3.2 Age distribution

SELECT
    age_group,
    COUNT(*) AS respondents,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM survey_respondents
GROUP BY age_group
ORDER BY respondents DESC;


-- 3.3 Education level distribution

SELECT
    education_level,
    COUNT(*) AS respondents,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM survey_respondents
GROUP BY education_level
ORDER BY respondents DESC;


-- 3.4 Occupation distribution

SELECT
    occupation,
    COUNT(*) AS respondents,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM survey_respondents
GROUP BY occupation
ORDER BY respondents DESC;


-- 3.5 Monthly income distribution

SELECT
    monthly_income,
    COUNT(*) AS respondents,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM survey_respondents
GROUP BY monthly_income
ORDER BY respondents DESC;


-- ============================================================
-- 4. ONLINE SHOPPING BEHAVIOUR
-- ============================================================


-- 4.1 Shopping frequency distribution

SELECT
    shopping_frequency,
    COUNT(*) AS respondents,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM survey_respondents
GROUP BY shopping_frequency
ORDER BY respondents DESC;


-- 4.2 Shopping frequency by gender

SELECT
    gender,
    shopping_frequency,
    COUNT(*) AS respondents
FROM survey_respondents
GROUP BY
    gender,
    shopping_frequency
ORDER BY
    gender,
    respondents DESC;


-- ============================================================
-- 5. QUESTION-LEVEL ANALYSIS
-- Calculate the average score for each survey question.
-- Likert scale: 1 = lowest agreement, 5 = highest agreement.
-- ============================================================

SELECT
    q.question_id,
    q.dimension,
    q.question_text,
    ROUND(AVG(a.response_value), 2) AS average_score,
    COUNT(a.response_value) AS response_count
FROM survey_answers a
JOIN survey_questions q
    ON a.question_id = q.question_id
GROUP BY
    q.question_id,
    q.dimension,
    q.question_text
ORDER BY
    average_score DESC;


-- ============================================================
-- 6. DIMENSION-LEVEL ANALYSIS
-- Compare the average scores across the six dimensions.
-- ============================================================

SELECT
    q.dimension,
    COUNT(DISTINCT q.question_id) AS number_of_questions,
    ROUND(AVG(a.response_value), 2) AS average_score,
    COUNT(a.response_value) AS total_responses
FROM survey_questions q
JOIN survey_answers a
    ON q.question_id = a.question_id
GROUP BY q.dimension
ORDER BY average_score DESC;


-- ============================================================
-- 7. RESPONSE DISTRIBUTION BY DIMENSION
-- Show the percentage of responses at each Likert score
-- within each dimension.
-- ============================================================

SELECT
    q.dimension,
    a.response_value,
    COUNT(*) AS total_responses,
    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (PARTITION BY q.dimension),
        2
    ) AS percentage
FROM survey_answers a
JOIN survey_questions q
    ON a.question_id = q.question_id
GROUP BY
    q.dimension,
    a.response_value
ORDER BY
    q.dimension,
    a.response_value;


-- ============================================================
-- 8. RESPONDENT-LEVEL DIMENSION SCORES
-- Calculate each respondent's average score for each dimension.
-- Useful for further analysis and Power BI.
-- ============================================================

SELECT
    a.respondent_id,
    q.dimension,
    ROUND(AVG(a.response_value), 2) AS average_dimension_score
FROM survey_answers a
JOIN survey_questions q
    ON a.question_id = q.question_id
GROUP BY
    a.respondent_id,
    q.dimension
ORDER BY
    a.respondent_id,
    q.dimension;


-- ============================================================
-- 9. OVERALL RESPONDENT PROFILE
-- Combine respondent demographics and shopping frequency
-- with each respondent's overall average survey score.
-- ============================================================

SELECT
    r.respondent_id,
    r.gender,
    r.age_group,
    r.education_level,
    r.shopping_frequency,
    r.monthly_income,
    r.occupation,
    ROUND(AVG(a.response_value), 2) AS overall_average_score
FROM survey_respondents r
JOIN survey_answers a
    ON r.respondent_id = a.respondent_id
GROUP BY
    r.respondent_id,
    r.gender,
    r.age_group,
    r.education_level,
    r.shopping_frequency,
    r.monthly_income,
    r.occupation
ORDER BY r.respondent_id;


-- ============================================================
-- END OF EXPLORATORY ANALYSIS
-- ============================================================
