
-- ============================================================
-- PROJECT: Bangladeshi E-commerce Consumer Habits
-- FILE: 04_purchase_intention_analysis.sql
-- PURPOSE: Analyse purchase intention and its relationships
--          with shopping frequency and respondent demographics.
-- ============================================================


-- ============================================================
-- 1. OVERALL PURCHASE INTENTION
-- Q29 and Q30 are used as purchase-intention measures.
-- ============================================================

SELECT
    COUNT(DISTINCT respondent_id) AS number_of_respondents,
    ROUND(AVG(response_value), 2) AS average_purchase_intention
FROM survey_answers
WHERE question_id IN ('Q29', 'Q30');


-- ============================================================
-- 2. PURCHASE INTENTION BY SHOPPING FREQUENCY
-- Compare average purchase intention across shopping groups.
-- ============================================================

SELECT
    r.shopping_frequency,
    COUNT(DISTINCT r.respondent_id) AS number_of_respondents,
    ROUND(AVG(a.response_value), 2) AS average_purchase_intention
FROM survey_respondents r
JOIN survey_answers a
    ON r.respondent_id = a.respondent_id
WHERE a.question_id IN ('Q29', 'Q30')
GROUP BY r.shopping_frequency
ORDER BY average_purchase_intention DESC;


-- ============================================================
-- 3. PURCHASE INTENTION BY AGE GROUP
-- ============================================================

SELECT
    r.age_group,
    COUNT(DISTINCT r.respondent_id) AS number_of_respondents,
    ROUND(AVG(a.response_value), 2) AS average_purchase_intention
FROM survey_respondents r
JOIN survey_answers a
    ON r.respondent_id = a.respondent_id
WHERE a.question_id IN ('Q29', 'Q30')
GROUP BY r.age_group
ORDER BY average_purchase_intention DESC;


-- ============================================================
-- 4. PURCHASE INTENTION BY MONTHLY INCOME
-- ============================================================

SELECT
    r.monthly_income,
    COUNT(DISTINCT r.respondent_id) AS number_of_respondents,
    ROUND(AVG(a.response_value), 2) AS average_purchase_intention
FROM survey_respondents r
JOIN survey_answers a
    ON r.respondent_id = a.respondent_id
WHERE a.question_id IN ('Q29', 'Q30')
GROUP BY r.monthly_income
ORDER BY average_purchase_intention DESC;


-- ============================================================
-- 5. PURCHASE INTENTION BY GENDER
-- ============================================================

SELECT
    r.gender,
    COUNT(DISTINCT r.respondent_id) AS number_of_respondents,
    ROUND(AVG(a.response_value), 2) AS average_purchase_intention
FROM survey_respondents r
JOIN survey_answers a
    ON r.respondent_id = a.respondent_id
WHERE a.question_id IN ('Q29', 'Q30')
GROUP BY r.gender
ORDER BY average_purchase_intention DESC;


-- ============================================================
-- 6. PURCHASE INTENTION BY EDUCATION LEVEL
-- ============================================================

SELECT
    r.education_level,
    COUNT(DISTINCT r.respondent_id) AS number_of_respondents,
    ROUND(AVG(a.response_value), 2) AS average_purchase_intention
FROM survey_respondents r
JOIN survey_answers a
    ON r.respondent_id = a.respondent_id
WHERE a.question_id IN ('Q29', 'Q30')
GROUP BY r.education_level
ORDER BY average_purchase_intention DESC;


-- ============================================================
-- 7. SPEARMAN CORRELATION:
-- SHOPPING FREQUENCY VS. PURCHASE INTENTION
--
-- Shopping frequency is ranked from 1 to 4:
-- 1 = Once every 6 months
-- 2 = Once every 3 months
-- 3 = Once a month
-- 4 = Once a week
--
-- Average ranks account for tied observations.
-- ============================================================

WITH respondent_scores AS (
    SELECT
        r.respondent_id,
        CASE
            WHEN r.shopping_frequency = 'Once every 6 months' THEN 1
            WHEN r.shopping_frequency = 'Once every 3 months' THEN 2
            WHEN r.shopping_frequency = 'Once a month' THEN 3
            WHEN r.shopping_frequency = 'Once a week' THEN 4
        END AS frequency_rank,
        AVG(a.response_value) AS purchase_intention
    FROM survey_respondents r
    JOIN survey_answers a
        ON r.respondent_id = a.respondent_id
    WHERE a.question_id IN ('Q29', 'Q30')
    GROUP BY
        r.respondent_id,
        r.shopping_frequency
),
average_ranks AS (
    SELECT
        RANK() OVER (ORDER BY frequency_rank)
        + (COUNT(*) OVER (PARTITION BY frequency_rank) - 1) / 2.0
            AS frequency_average_rank,
        RANK() OVER (ORDER BY purchase_intention)
        + (COUNT(*) OVER (PARTITION BY purchase_intention) - 1) / 2.0
            AS intention_average_rank
    FROM respondent_scores
    WHERE frequency_rank IS NOT NULL
)
SELECT
    COUNT(*) AS number_of_respondents,
    ROUND(
        CORR(
            frequency_average_rank,
            intention_average_rank
        )::numeric,
        3
    ) AS spearman_correlation
FROM average_ranks;


-- ============================================================
-- 8. SPEARMAN CORRELATION:
-- MONTHLY INCOME VS. PURCHASE INTENTION
--
-- Income categories are ranked from lowest to highest.
-- Average ranks account for tied observations.
-- ============================================================

WITH respondent_scores AS (
    SELECT
        r.respondent_id,
        CASE
            WHEN r.monthly_income = 'Less than 10,000' THEN 1
            WHEN r.monthly_income = '10,000-19,000' THEN 2
            WHEN r.monthly_income = '20,000-29,000' THEN 3
            WHEN r.monthly_income = '30,000-40,000' THEN 4
            WHEN r.monthly_income = 'More than 40,000' THEN 5
        END AS income_rank,
        AVG(a.response_value) AS purchase_intention
    FROM survey_respondents r
    JOIN survey_answers a
        ON r.respondent_id = a.respondent_id
    WHERE a.question_id IN ('Q29', 'Q30')
    GROUP BY
        r.respondent_id,
        r.monthly_income
),
average_ranks AS (
    SELECT
        RANK() OVER (ORDER BY income_rank)
        + (COUNT(*) OVER (PARTITION BY income_rank) - 1) / 2.0
            AS income_average_rank,
        RANK() OVER (ORDER BY purchase_intention)
        + (COUNT(*) OVER (PARTITION BY purchase_intention) - 1) / 2.0
            AS intention_average_rank
    FROM respondent_scores
    WHERE income_rank IS NOT NULL
)
SELECT
    COUNT(*) AS number_of_respondents,
    ROUND(
        CORR(
            income_average_rank,
            intention_average_rank
        )::numeric,
        3
    ) AS spearman_correlation
FROM average_ranks;


-- ============================================================
-- 9. PURCHASE INTENTION BY OCCUPATION
-- ============================================================

SELECT
    r.occupation,
    COUNT(DISTINCT r.respondent_id) AS number_of_respondents,
    ROUND(AVG(a.response_value), 2) AS average_purchase_intention
FROM survey_respondents r
JOIN survey_answers a
    ON r.respondent_id = a.respondent_id
WHERE a.question_id IN ('Q29', 'Q30')
GROUP BY r.occupation
ORDER BY average_purchase_intention DESC;


-- ============================================================
-- END OF PURCHASE INTENTION ANALYSIS
-- ============================================================
