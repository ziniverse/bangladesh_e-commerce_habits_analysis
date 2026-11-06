# Bangladeshi E-commerce Consumer Habits

An end-to-end data analytics portfolio project exploring e-commerce
attitudes, online shopping habits, trust, security, and purchase
intention among 299 respondents in Bangladesh.

The project uses Python for data preparation, PostgreSQL and SQL for
data storage and analysis, and Microsoft Power BI for interactive data
visualisation.

## Project Overview

This project analyses survey responses to understand how respondents
Dataset: https://data.mendeley.com/datasets/npsbdyv7ry/1?
perceive and use e-commerce. It examines demographic characteristics,
online shopping frequency, consumer experience, trust and security
perceptions, and future purchase intention.

The analysis focuses on reported attitudes and associations in the
survey sample. It does not claim to measure actual post-pandemic
behavioural change or establish causal relationships.

## Research Questions

1.  What are the demographic characteristics and online shopping habits
    of the respondents?
2.  How do respondents evaluate different aspects of the e-commerce
    experience?
3.  How do purchase intention scores vary across shopping-frequency,
    age, and income groups?
4.  Is purchase intention associated with online shopping frequency or
    monthly income?

## Dataset

The dataset contains:

-   **299 respondents**
-   **30 survey questions**
-   **8,970 recorded answers**
-   A five-point Likert response scale

The survey covers several dimensions:

  Dimension                    Number of questions
  -------------------------- ---------------------
  Pandemic motivations                           5
  Purchase intention                             2
  Usability and efficiency                      12
  Consumer attitudes                             5
  Trust and security                             4
  Social influence                               2
  **Total**                                 **30**

The dimension groupings follow the survey's question categories and
should not be interpreted as independently validated psychometric
scales.

## Tools and Technologies

-   **Python (Pandas):** Data preparation and conversion of the source
    Excel workbook into CSV files.
-   **PostgreSQL:** Relational data storage.
-   **SQL:** Data cleaning checks, exploratory analysis, aggregations,
    group comparisons, and correlation analysis.
-   **Microsoft Power BI:** Data modelling, DAX measures, interactive
    reports, and dashboard design.
-   **Git and GitHub:** Version control and project documentation.

## Project Structure

``` text
bangladesh_e-commerce_portfolio/
│
├── data/
│   ├── raw/
│   │   └── bangladesh_ecommerce_survey.xlsx
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
│   ├── Bangladesh_Ecommerce_Dashboard.pbix
│   ├── screenshots/
│   └── dashboard_overview.pdf
│
├── README.md
└── .gitignore
```

The Power BI screenshots and PDF are optional presentation exports.
Include them only if you create them.

## Data Preparation

The original survey workbook was processed using Python and Pandas.

The preparation workflow:

1.  Read the source Excel workbook.
2.  Separate the respondent, question, and answer information.
3.  Export the data into three CSV files.
4.  Import the processed CSV files into PostgreSQL.
5.  Check table row counts and data completeness.

The resulting relational tables are:

  -------------------------------------------------------------------------
  Table                  Description                                   Rows
  ---------------------- --------------------- ----------------------------
  `survey_respondents`   Respondent                                     299
                         demographics and      
                         shopping habits       

  `survey_questions`     Survey question text                            30
                         and dimension         
                         categories            

  `survey_answers`       Individual question                          8,970
                         responses             
  -------------------------------------------------------------------------

## Database Model

The database uses three related tables:

-   `survey_respondents`: one record per respondent.
-   `survey_questions`: one record per survey question.
-   `survey_answers`: one record per respondent-question response.

The `survey_answers` table links to the other two tables through
`respondent_id` and `question_id`, creating a simple relational model
suitable for analysis.

## SQL Analysis

The SQL scripts cover:

### Exploratory analysis

-   Dataset overview and record counts.
-   Missing-value checks.
-   Response distributions.
-   Respondent demographics.
-   Online shopping frequency.
-   Average scores by question.
-   Average scores by survey dimension.
-   Respondent-level dimension scores.

### Purchase intention analysis

-   Overall purchase intention.
-   Purchase intention by shopping frequency.
-   Purchase intention by age group.
-   Purchase intention by monthly income.
-   Comparisons by gender, education, and occupation.
-   Spearman rank correlations between purchase intention and shopping
    frequency, and between purchase intention and income.

## Power BI Dashboard

The Power BI report contains four pages.

### 1. Overview

Provides a snapshot of the respondent sample, including:

-   Total respondents.
-   Gender distribution.
-   Age distribution.
-   Online shopping frequency.
-   Average purchase intention.

### 2. Consumer Experience

Explores how respondents evaluate different aspects of e-commerce
through:

-   Average scores across the six survey dimensions.
-   Average scores for individual survey questions.
-   An interactive dimension slicer to filter the question-level chart.

### 3. Purchase Intention

Compares average purchase intention across:

-   Online shopping frequency.
-   Age groups.
-   Monthly income groups.

The charts include respondent counts in their tooltips to help viewers
interpret group averages in the context of sample sizes.

### 4. Key Findings

Summarises the main results, highlights the strongest and weakest
individual question scores, and presents the study limitations and
methodology.

## Key Findings

### Consumer experience

  Dimension                    Average score (out of 5)
  -------------------------- --------------------------
  Pandemic motivations                             3.99
  Purchase intention                               3.95
  Usability and efficiency                         3.83
  Consumer attitudes                               3.71
  Trust and security                               3.48
  Social influence                                 3.46

Pandemic motivations received the highest average dimension score, while
social influence and trust and security received the lowest scores.

### Individual survey questions

-   **Highest average:** Q17, social distancing through e-commerce ---
    **4.31/5**.
-   **Lowest average:** Q19, privacy protection --- **3.34/5**.

Other relatively low-scoring statements concerned the influence of
economic experts and the efficiency and practicality of e-commerce.

### Purchase intention by shopping frequency

  Shopping frequency      Respondents   Average purchase intention
  --------------------- ------------- ----------------------------
  Once a week                      30                         4.55
  Once a month                     93                         4.19
  Once every 3 months              79                         3.76
  Once every 6 months              97                         3.70

Respondents who reported shopping online more frequently tended to
report higher purchase intention.

The Spearman rank correlation between shopping frequency and purchase
intention was **ρ = 0.305** (n = 299), indicating a positive
association.

### Purchase intention by age

  Age group     Respondents   Average purchase intention
  ----------- ------------- ----------------------------
  Below 20                2                         3.50
  20--29                206                         3.90
  30--39                 79                         4.11
  40--49                  8                         4.13
  Above 49                4                         3.63

The 20--29 group represents the largest share of the sample. Comparisons
involving the other smaller age groups should be interpreted cautiously.

### Purchase intention by monthly income

  Monthly income (BDT)     Respondents   Average purchase intention
  ---------------------- ------------- ----------------------------
  Less than 10,000                 136                         3.88
  10,000--19,000                    33                         4.45
  20,000--29,000                    33                         4.02
  30,000--40,000                    37                         3.65
  More than 40,000                  60                         4.00

The Spearman rank correlation between income and purchase intention was
**ρ = 0.022** (n = 299), indicating a negligible monotonic association
in this sample. The group averages also do not show a consistent
increasing or decreasing pattern with income.

## Limitations

-   The data are self-reported and represent 299 survey respondents;
    they should not automatically be generalised to all consumers in
    Bangladesh.
-   The dataset does not include verified transaction records.
-   Although the survey includes pandemic-related questions, it does not
    provide a pre-pandemic baseline or longitudinal follow-up.
    Therefore, it cannot establish actual post-pandemic behavioural
    change.
-   Some demographic groups have small sample sizes, making their
    averages less stable.
-   The dimension groupings are based on survey question categories and
    have not been independently validated as psychometric scales.
-   Spearman correlations describe associations, not causation.

## Future Improvements

Potential extensions include:

-   Adding more detailed statistical testing and confidence intervals.
-   Exploring relationships between demographic variables and individual
    survey dimensions.
-   Improving the dashboard with additional drill-through and filtering
    features.
-   Adding a reproducible environment and database setup guide.
-   Including a data dictionary and documented data provenance.

## Conclusion

This project demonstrates an end-to-end analytics workflow, from
preparing survey data with Python and storing it in PostgreSQL to
analysing it with SQL and communicating findings through an interactive
Power BI dashboard.

The results show generally positive reported attitudes towards
e-commerce, alongside comparatively lower scores for trust and security.
Shopping frequency had a positive association with purchase intention,
while income showed almost no monotonic association in this sample.

------------------------------------------------------------------------

**Data redistribution note:** Before making this repository public,
confirm that the survey dataset and its source workbook may be
redistributed. Do not publish respondent-level or otherwise personal
data without appropriate permission. If redistribution is not permitted,
exclude the raw workbook and processed respondent-level CSV files, and
document how an authorised user can obtain or prepare the data.
