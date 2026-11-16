# Set a seed for reproducibility
set.seed(123)

# Create a sample wide-form data frame
data_wide <- data.frame(
  StudentID = 1:60,
  GradeLevel = sample(c("Freshman", "Sophomore", "Junior", "Senior"), 60, replace = TRUE),
  Math_Grade = sample(c("A", "B", "C", "F"), 60, replace = TRUE, prob = c(0.3, 0.4, 0.2, 0.1)),
  Science_Grade = sample(c("A", "B", "C", "F"), 60, replace = TRUE, prob = c(0.25, 0.45, 0.2, 0.1)),
  English_Grade = sample(c("A", "B", "C", "F"), 60, replace = TRUE, prob = c(0.35, 0.4, 0.15, 0.1))
)

# View the first few rows of the wide dataset
head(data_wide)

# Optional: Export to a CSV file so you can easily open it in Jamovi
write.csv(data_wide, "student_grades_wide.csv", row.names = FALSE)


# 1. Reshape the data from wide to long format
data_long <- data_wide |>
  tidyr::pivot_longer(
    cols = c(Math_Grade, Science_Grade, English_Grade),
    names_to = "Subject",
    values_to = "Grade"
  ) |>
  dplyr::mutate(
    # Clean up the subject names for a nicer plot (removes "_Grade")
    Subject = sub("_Grade", "", Subject)
  )

# View the first few rows of the new long-form dataset
head(data_long)

# 2. Create the stacked bar plot using ggplot2
ggplot2::ggplot(data_long, ggplot2::aes(x = Subject, fill = Grade)) +
  ggplot2::geom_bar(position = "stack") +
  ggplot2::labs(
    title = "Distribution of Student Grades Across Subjects",
    x = "Subject",
    y = "Count",
    fill = "Grade"
  ) +
  ggplot2::theme_minimal()
