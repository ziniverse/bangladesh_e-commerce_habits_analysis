
\copy survey_respondents (respondent_id, gender, age_group, education_level, shopping_frequency, monthly_income, occupation) FROM 'C:/Users/zarin/Desktop/bangladesh_e-commerce_portfolio/data/processed/respondents.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8');

\copy survey_questions (question_id, question_text, dimension) FROM 'C:/Users/zarin/Desktop/bangladesh_e-commerce_portfolio/data/processed/questions.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8');

\copy survey_answers (respondent_id, question_id, response_value) FROM 'C:/Users/zarin/Desktop/bangladesh_e-commerce_portfolio/data/processed/answers.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8');
