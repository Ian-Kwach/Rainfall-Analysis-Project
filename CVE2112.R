# Load necessary libraries
library(tidyverse)
library(readxl)
library(lubridate)
library(fitdistrplus)
library(MASS)

# Load the data from Excel file
file_path <- "C:/Users/USER/Downloads/combined_data.xlsx"
combined_data <- read_excel(file_path)

# Convert Year, Month, Day into a Date column
combined_data <- combined_data %>%
  mutate(Date = make_date(Year, Month, Day))

# Calculate the highest daily rainfall total for each month
monthly_max_rainfall <- combined_data %>%
  group_by(Year, Month) %>%
  summarize(Max_Rainfall = max(`Daily Rainfall Total (mm)`, na.rm = TRUE))

# Summary statistics for the entire dataset
overall_summary <- combined_data %>%
  summarize(
    mean = mean(`Daily Rainfall Total (mm)`, na.rm = TRUE),
    median = median(`Daily Rainfall Total (mm)`, na.rm = TRUE),
    variance = var(`Daily Rainfall Total (mm)`, na.rm = TRUE),
    sd = sd(`Daily Rainfall Total (mm)`, na.rm = TRUE),
    Q1 = quantile(`Daily Rainfall Total (mm)`, 0.25, na.rm = TRUE),
    Q3 = quantile(`Daily Rainfall Total (mm)`, 0.75, na.rm = TRUE),
    min = min(`Daily Rainfall Total (mm)`, na.rm = TRUE),
    max = max(`Daily Rainfall Total (mm)`, na.rm = TRUE)
  )

# Summary statistics for each month
monthly_summary <- combined_data %>%
  group_by(Year, Month) %>%
  summarize(
    mean = mean(`Daily Rainfall Total (mm)`, na.rm = TRUE),
    median = median(`Daily Rainfall Total (mm)`, na.rm = TRUE),
    variance = var(`Daily Rainfall Total (mm)`, na.rm = TRUE),
    sd = sd(`Daily Rainfall Total (mm)`, na.rm = TRUE),
    Q1 = quantile(`Daily Rainfall Total (mm)`, 0.25, na.rm = TRUE),
    Q3 = quantile(`Daily Rainfall Total (mm)`, 0.75, na.rm = TRUE),
    min = min(`Daily Rainfall Total (mm)`, na.rm = TRUE),
    max = max(`Daily Rainfall Total (mm)`, na.rm = TRUE)
  )

# Create a new column for 5-year periods
combined_data <- combined_data %>%
  mutate(Period = cut(Year, breaks = seq(2000, 2025, by = 5), include.lowest = TRUE, right = FALSE))

# Boxplot for entire dataset (every 5 years)
ggplot(combined_data, aes(x = Period, y = `Daily Rainfall Total (mm)`)) +
  geom_boxplot() +
  labs(title = "Boxplot of Daily Rainfall Total (Every 5 Years)", x = "Period", y = "Daily Rainfall Total (mm)")

# Create box plots for wettest and driest months
wettest_month_plot <- ggplot(wettest_month_data, aes(x = factor(Month), y = `Daily Rainfall Total (mm)`)) +
  geom_boxplot() +
  labs(title = paste("Box Plot of Daily Rainfall Total (Wettest Month:", wettest_month$Month, wettest_month$Year, ")"), 
       x = "Month", y = "Daily Rainfall Total (mm)")

driest_month_plot <- ggplot(driest_month_data, aes(x = factor(Month), y = `Daily Rainfall Total (mm)`)) +
  geom_boxplot() +
  labs(title = paste("Box Plot of Daily Rainfall Total (Driest Month:", driest_month$Month, driest_month$Year, ")"), 
       x = "Month", y = "Daily Rainfall Total (mm)")
print(wettest_month_plot)
print(driest_month_plot)

# Violin plot for entire dataset (every 5 years)
ggplot(combined_data, aes(x = Period, y = `Daily Rainfall Total (mm)`)) +
  geom_violin() +
  labs(title = "Violin Plot of Daily Rainfall Total (Every 5 Years)", x = "Period", y = "Daily Rainfall Total (mm)")

# Identify wettest and driest months
wettest_month <- combined_data %>%
  group_by(Year, Month) %>%
  summarize(Max_Rainfall = max(`Daily Rainfall Total (mm)`, na.rm = TRUE)) %>%
  ungroup() %>%
  slice(which.max(Max_Rainfall))

driest_month <- combined_data %>%
  group_by(Year, Month) %>%
  summarize(Max_Rainfall = max(`Daily Rainfall Total (mm)`, na.rm = TRUE)) %>%
  ungroup() %>%
  slice(which.min(Max_Rainfall))

# Violin plot for wettest month
ggplot(filter(combined_data, Year == wettest_month$Year & Month == wettest_month$Month), aes(x = factor(Month), y = `Daily Rainfall Total (mm)`)) +
  geom_violin() +
  labs(title = "Violin Plot of Daily Rainfall Total (Wettest Month)", x = "Month", y = "Daily Rainfall Total (mm)")

# Violin plot for driest month
ggplot(filter(combined_data, Year == driest_month$Year & Month == driest_month$Month), aes(x = factor(Month), y = `Daily Rainfall Total (mm)`)) +
  geom_violin() +
  labs(title = "Violin Plot of Daily Rainfall Total (Driest Month)", x = "Month", y = "Daily Rainfall Total (mm)")

# Histogram with KDE for entire dataset (every 5 years)
ggplot(combined_data, aes(x = `Daily Rainfall Total (mm)`)) +
  geom_histogram(aes(y = ..density..), binwidth = 10, fill = "blue", alpha = 0.7) +
  geom_density(color = "red") +
  facet_wrap(~ Period, scales = "free_y") +
  labs(title = "Histogram with KDE of Daily Rainfall Total (Every 5 Years)", x = "Daily Rainfall Total (mm)", y = "Density")

# Histogram for wettest month
ggplot(filter(combined_data, Year == wettest_month$Year & Month == wettest_month$Month), aes(x = `Daily Rainfall Total (mm)`)) +
  geom_histogram(aes(y = ..density..), binwidth = 5, fill = "blue", alpha = 0.7) +
  geom_density(color = "red") +
  labs(title = "Histogram with KDE of Daily Rainfall Total (Wettest Month)", x = "Daily Rainfall Total (mm)", y = "Density")

# Histogram for driest month
ggplot(filter(combined_data, Year == driest_month$Year & Month == driest_month$Month), aes(x = `Daily Rainfall Total (mm)`)) +
  geom_histogram(aes(y = ..density..), binwidth = 5, fill = "blue", alpha = 0.7) +
  geom_density(color = "red") +
  labs(title = "Histogram with KDE of Daily Rainfall Total (Driest Month)", x = "Daily Rainfall Total (mm)", y = "Density")

# Time series plot with annotations for highest daily rainfall every 5 years
ggplot(combined_data, aes(x = Date, y = `Daily Rainfall Total (mm)`)) +
  geom_line(color = "blue") +
  geom_point(data = max_rainfall_5yr, aes(x = Max_Rainfall_Date, y = Max_Rainfall), color = "red", size = 3) +
  geom_text(data = max_rainfall_5yr, aes(x = Max_Rainfall_Date, y = Max_Rainfall, label = round(Max_Rainfall, 1)), 
            vjust = -1, color = "red") +
  labs(title = "Time Series of Daily Rainfall Total with Highest Daily Rainfall Every 5 Years", 
       x = "Date", y = "Daily Rainfall Total (mm)") +
  theme_minimal()

# Fit log-normal distribution
fit_lognorm <- fitdist(monthly_max_rainfall$Max_Rainfall, "lnorm")

# Fit gamma distribution
fit_gamma <- fitdist(monthly_max_rainfall$Max_Rainfall, "gamma")

# Plot distributions
par(mfrow = c(2, 1))
plot(fit_lognorm)
plot(fit_gamma)

# 95% Confidence Interval for overall data
ci_overall <- t.test(monthly_max_rainfall$Max_Rainfall, conf.level = 0.95)$conf.int

# 95% Confidence Interval for wettest month
wettest_month_data <- filter(combined_data, Year == wettest_month$Year & Month == wettest_month$Month)
ci_wettest <- t.test(wettest_month_data$`Daily Rainfall Total (mm)`, conf.level = 0.95)$conf.int

# 95% Confidence Interval for driest month
driest_month_data <- filter(combined_data, Year == driest_month$Year & Month == driest_month$Month)
ci_driest <- t.test(driest_month_data$`Daily Rainfall Total (mm)`, conf.level = 0.95)$conf.int

# Print confidence intervals
print(ci_overall)
print(ci_wettest)
print(ci_driest)

# Goodness-of-Fit test results
gof <- gofstat(list(fit_lognorm, fit_gamma))

# Plot goodness-of-fit test graphs
par(mfrow = c(2, 1))
gof_lognorm <- plot(fit_lognorm)
gof_gamma <- plot(fit_gamma)
