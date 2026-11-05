
# Bangladeshi E-commerce Consumer Habits: A Survey-Based Analysis

## Project Overview

This project explores the online shopping habits, consumer attitudes, and purchase intentions of respondents in Bangladesh using survey data from 299 participants.

The analysis focuses on understanding how consumers perceive e-commerce platforms, including usability, convenience, trust, security, social influence, and pandemic-related motivations. It also examines whether purchase intention is associated with demographic characteristics and online shopping frequency.

The project uses **PostgreSQL and SQL for data preparation and analysis**, with **Power BI planned for interactive data visualisation**.

## Research Questions

The analysis explores the following questions:

1. **Consumer behaviour:** How frequently do respondents shop online, and what are their general attitudes towards e-commerce?
2. **Usability and convenience:** How do respondents evaluate the usability, efficiency, and convenience of online shopping?
3. **Trust and security:** How confident are respondents in the reliability, privacy, and security of e-commerce platforms?
4. **Purchase intention:** How does online purchase intention vary across shopping frequency and demographic groups?
5. **Relationships:** Is there an association between shopping frequency, income level, and online purchase intention?

## Dataset

The dataset contains survey responses from **299 respondents** and includes:

- 6 demographic and shopping-profile variables.
- 30 Likert-scale survey statements.
- 8,970 individual question responses.

The survey uses a five-point Likert scale, where higher scores represent stronger agreement with a statement.

### Survey Dimensions

The 30 survey questions are grouped into six analytical dimensions:

| Dimension | Number of Questions |
|---|---:|
| Usability and efficiency | 12 |
| Pandemic-related motivations | 5 |
| Trust and security | 4 |
| Consumer attitudes | 5 |
| Social influence | 2 |
| Purchase intention | 2 |
| **Total** | **30** |

*Note: These dimensions are analytical groupings based on the survey question categories, rather than independently validated measurement scales.*

## Tools and Technologies

| Tool | Purpose |
|---|---|
| PostgreSQL 16 | Relational database and data storage |
| SQL | Data cleaning, aggregation, exploratory analysis, and correlation analysis |
| Python | Excel-to-CSV data preparation |
| Pandas | Data processing |
| Power BI | Interactive dashboards and visualisation (planned) |
| Git and GitHub | Version control and project documentation |

## Project Structure

```text
bangladesh_e-commerce_portfolio/
│
├── data/
│   ├── raw/
│   │   └── bangladesh_ecommerce_survey.xlsx
│   │
│   └── processed/
│       ├── respondents.csv
│       ├── questions.csv
│       └── answers.csv
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_import_data.sql
│   ├── 03_exploratory_analysis.sql
│   └── 04_purchase_intention_analysis.sql
│
├── analysis/
│   └── data_processing.py
│
├── powerbi/
│
└── README.md
```

## Data Preparation and Methodology

The original survey data was provided in Excel format and processed using Python and Pandas.

The preparation process involved:

1. Reading the original Excel survey.
2. Separating respondent demographics, survey questions, and individual responses.
3. Restructuring the data into three CSV files.
4. Importing the processed data into PostgreSQL.
5. Organising the dataset into three relational tables:
   - `survey_respondents`
   - `survey_questions`
   - `survey_answers`
6. Using SQL joins and aggregation to explore respondent characteristics and survey responses.

### Analytical Methods

The SQL analysis includes:

- Descriptive statistics and frequency distributions.
- Average Likert-scale scores at question and dimension levels.
- Comparisons of purchase intention across demographic groups.
- Spearman rank correlation to examine associations between ordinal variables and purchase intention.

Purchase intention is operationalised as the average response to Q29 and Q30.

## Key Findings

### 1. Respondent Profile

The sample consists predominantly of younger respondents:

- Approximately 68.9% were aged 20–29.
- Approximately 72.58% were male.

This sample composition is important when interpreting the findings, as the results may not represent the wider population of Bangladeshi consumers.

### 2. Convenience and Usability Received Relatively Positive Evaluations

The highest-rated survey statements included:

| Survey Statement | Average Score |
|---|---:|
| Social distancing through e-commerce (Q17) | 4.31 |
| Easy payment process (Q08) | 4.24 |
| Saves time (Q07) | 4.19 |
| Easy to access and use (Q09) | 4.17 |
| Health safety encourages e-commerce (Q15) | 4.05 |

These results suggest that respondents particularly valued convenience, ease of use, and pandemic-related health and safety considerations.

### 3. Trust and Security Received Comparatively Lower Scores

The average scores across the six analytical dimensions were:

| Dimension | Average Score |
|---|---:|
| Pandemic-related motivations | 3.99 |
| Purchase intention | 3.95 |
| Usability and efficiency | 3.83 |
| Consumer attitudes | 3.71 |
| Trust and security | 3.48 |
| Social influence | 3.46 |

Trust and security had the lowest average score among the six dimensions. In particular, privacy protection received an average score of 3.34.

This suggests that, although respondents generally evaluated convenience positively, concerns related to privacy and security may remain relevant.

### 4. Shopping Frequency Was Associated with Purchase Intention

Purchase intention varied across online shopping frequency groups:

| Shopping Frequency | Respondents | Average Purchase Intention |
|---|---:|---:|
| Once a week | 30 | 4.55 |
| Once a month | 93 | 4.19 |
| Once every 3 months | 79 | 3.76 |
| Once every 6 months | 97 | 3.70 |

Respondents who shopped online more frequently reported higher average purchase intention.

A Spearman rank correlation analysis found a positive association between shopping frequency and purchase intention:

**Spearman's ρ = 0.305 (n = 299)**

This indicates a weak-to-moderate positive monotonic association. It does not establish that shopping frequency causes higher purchase intention.

### 5. Income Showed Virtually No Association with Purchase Intention

The average purchase intention varied across income groups, but the pattern was not consistently increasing with income.

Spearman correlation analysis found:

**Spearman's ρ = 0.022 (n = 299)**

This indicates a negligible monotonic association between monthly income category and purchase intention in this sample.

### 6. Purchase Intention Varied Across Occupation Groups

| Occupation | Respondents | Average Purchase Intention |
|---|---:|---:|
| Business | 27 | 4.43 |
| Doctor | 4 | 4.38 |
| Teaching | 16 | 4.09 |
| Others | 46 | 3.97 |
| Student | 125 | 3.93 |
| Engineer | 75 | 3.79 |
| Government employee | 6 | 3.58 |

Business respondents had the highest average purchase intention (4.43), followed by doctors (4.38). However, some occupational groups had very small sample sizes, particularly doctors and government employees. These differences should therefore be interpreted cautiously.

## Limitations

Several limitations should be considered when interpreting the findings:

- **Sample representativeness:** The dataset contains 299 respondents and is predominantly composed of younger and male participants. It may not represent all Bangladeshi consumers.
- **Self-reported responses:** The analysis reflects respondents' reported attitudes and intentions rather than verified purchasing behaviour.
- **Cross-sectional data:** The dataset does not provide longitudinal observations or a pre-pandemic baseline. Therefore, it cannot establish how e-commerce behaviour changed over time.
- **Ordinal measurements:** Likert-scale responses and demographic categories have limitations when treated as numerical variables.
- **Analytical groupings:** The six survey dimensions are based on the original question categories and have not been independently validated as psychometric scales.
- **Small subgroups:** Some occupation and age categories contain very few respondents, making comparisons less reliable.
- **Correlation does not imply causation:** Observed associations cannot establish causal relationships.

## Future Work

The next stage of the project is to develop an interactive Power BI dashboard featuring:

- Respondent demographic profiles.
- Online shopping frequency distributions.
- Average scores across survey dimensions.
- Highest- and lowest-rated survey statements.
- Purchase intention comparisons across demographic groups.
- Relationships between shopping frequency, income, and purchase intention.

Further statistical analysis could also examine whether differences between demographic groups are statistically significant.

## Conclusion

This project demonstrates an end-to-end analytical workflow, from processing survey data and designing a relational database to conducting exploratory analysis using SQL.

The findings highlight the importance of convenience and usability in respondents' evaluations of e-commerce, while trust and security received comparatively lower scores. Shopping frequency showed a stronger association with purchase intention than monthly income in this sample.

The project will be extended with an interactive Power BI dashboard to communicate the findings through visualisations and accessible data exploration.

---

**Technologies:** PostgreSQL · SQL · Python · Pandas · Power BI · Git
