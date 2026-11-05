
from pathlib import Path
import pandas as pd

# --------------------------------------------------
# 1. Define project paths
# --------------------------------------------------

PROJECT_DIR = Path(__file__).resolve().parent.parent

INPUT_FILE = (
    PROJECT_DIR
    / "data"
    / "raw"
    / "bangladesh_ecommerce_survey.xlsx"
)

OUTPUT_DIR = PROJECT_DIR / "data" / "processed"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


# --------------------------------------------------
# 2. Read the Excel spreadsheet
# --------------------------------------------------

print("Reading Excel survey...")

df = pd.read_excel(INPUT_FILE)

# Remove accidental whitespace from column names
df.columns = df.columns.astype(str).str.strip()

print(f"Original dataset: {df.shape[0]} respondents")
print(f"Total columns: {df.shape[1]}")


# --------------------------------------------------
# 3. Identify demographic and survey columns
# --------------------------------------------------

demographic_columns = [
    "D1: Gender",
    "D2: Age(Years)",
    "D3: Education Level",
    "D4: Frequency of online shopping",
    "D5: Monthly Income(in Taka)",
    "D6: Occupation"
]

# All remaining columns contain Likert-scale statements
question_columns = [
    col for col in df.columns
    if col not in demographic_columns
]

if len(demographic_columns) != 6:
    raise ValueError("Expected 6 demographic columns.")

if len(question_columns) != 30:
    raise ValueError(
        f"Expected 30 survey questions, found {len(question_columns)}."
    )


# --------------------------------------------------
# 4. Create respondent IDs
# --------------------------------------------------

df.insert(
    0,
    "respondent_id",
    range(1, len(df) + 1)
)

respondents = df[
    ["respondent_id"] + demographic_columns
].copy()

respondents.columns = [
    "respondent_id",
    "gender",
    "age_group",
    "education_level",
    "shopping_frequency",
    "monthly_income",
    "occupation"
]


# --------------------------------------------------
# 5. Create question IDs and categories
# --------------------------------------------------

# These are exploratory analytical groupings.
# They can be revised if the research framework changes.

dimension_mapping = {
    **{i: "usability_efficiency" for i in range(1, 13)},
    **{i: "pandemic_motivations" for i in range(13, 18)},
    **{i: "trust_security" for i in range(18, 24)},
    **{i: "social_influence" for i in range(24, 26)},
    **{i: "consumer_attitudes" for i in range(26, 31)},
    **{i: "purchase_intention" for i in range(31, 33)}
}

questions = pd.DataFrame({
    "question_id": [
        f"Q{i:02d}" for i in range(1, 31)
    ],
    "question_text": question_columns,
    "dimension": [
        dimension_mapping[i]
        for i in range(1, 31)
    ]
})


# --------------------------------------------------
# 6. Convert answers into a long-format table
# --------------------------------------------------

answer_data = df[
    ["respondent_id"] + question_columns
].copy()

answers = answer_data.melt(
    id_vars="respondent_id",
    var_name="question_text",
    value_name="response_value"
)

# Match each answer to its question ID
question_lookup = dict(
    zip(questions["question_text"], questions["question_id"])
)

answers["question_id"] = answers["question_text"].map(
    question_lookup
)

answers = answers[
    ["respondent_id", "question_id", "response_value"]
]


# --------------------------------------------------
# 7. Validate the survey data
# --------------------------------------------------

print("\nValidating data...")

if respondents.isnull().any().any():
    raise ValueError("Missing values found in respondent data.")

if questions.isnull().any().any():
    raise ValueError("Missing values found in question data.")

if answers.isnull().any().any():
    raise ValueError("Missing values found in answer data.")

answers["response_value"] = pd.to_numeric(
    answers["response_value"],
    errors="raise"
)

valid_scores = answers["response_value"].between(1, 5)

if not valid_scores.all():
    raise ValueError(
        "Invalid Likert scores found. Expected values between 1 and 5."
    )

if not answers["response_value"].apply(
    lambda x: float(x).is_integer()
).all():
    raise ValueError("Non-integer Likert scores found.")

answers["response_value"] = answers[
    "response_value"
].astype(int)

expected_answers = len(respondents) * len(questions)

if len(answers) != expected_answers:
    raise ValueError(
        f"Expected {expected_answers} answers, "
        f"found {len(answers)}."
    )


# --------------------------------------------------
# 8. Export the three CSV files
# --------------------------------------------------

respondents.to_csv(
    OUTPUT_DIR / "respondents.csv",
    index=False,
    encoding="utf-8"
)

questions.to_csv(
    OUTPUT_DIR / "questions.csv",
    index=False,
    encoding="utf-8"
)

answers.to_csv(
    OUTPUT_DIR / "answers.csv",
    index=False,
    encoding="utf-8"
)


# --------------------------------------------------
# 9. Display results
# --------------------------------------------------

print("\nData preparation completed successfully!")

print(f"\nRespondents: {len(respondents)}")
print(f"Questions: {len(questions)}")
print(f"Answers: {len(answers)}")

print("\nDimension distribution:")
print(questions["dimension"].value_counts())

print("\nFiles saved to:")
print(OUTPUT_DIR)
