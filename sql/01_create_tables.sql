
-- =====================================================
-- Bangladesh E-commerce Portfolio
-- 01: Create database tables
-- =====================================================

-- 1. Respondents table
CREATE TABLE survey_respondents (
    respondent_id INTEGER PRIMARY KEY,
    gender VARCHAR(50),
    age_group VARCHAR(50),
    education_level VARCHAR(100),
    shopping_frequency VARCHAR(100),
    monthly_income VARCHAR(100),
    occupation VARCHAR(100)
);

-- 2. Questions table
CREATE TABLE survey_questions (
    question_id VARCHAR(10) PRIMARY KEY,
    question_text TEXT NOT NULL,
    dimension VARCHAR(100) NOT NULL
);

-- 3. Answers table
CREATE TABLE survey_answers (
    answer_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    respondent_id INTEGER NOT NULL,
    question_id VARCHAR(10) NOT NULL,
    response_value INTEGER NOT NULL
        CHECK (response_value BETWEEN 1 AND 5),

    CONSTRAINT fk_respondent
        FOREIGN KEY (respondent_id)
        REFERENCES survey_respondents(respondent_id),

    CONSTRAINT fk_question
        FOREIGN KEY (question_id)
        REFERENCES survey_questions(question_id),

    CONSTRAINT unique_respondent_question
        UNIQUE (respondent_id, question_id)
);

-- Indexes to improve query performance
CREATE INDEX idx_answers_respondent
    ON survey_answers(respondent_id);

CREATE INDEX idx_answers_question
    ON survey_answers(question_id);

CREATE INDEX idx_questions_dimension
    ON survey_questions(dimension);
