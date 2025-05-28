# PROBLEM 1
titanic_data <- read.csv ("TitanicData.csv", header = TRUE, stringsAsFactors = FALSE)
View(titanic_data)

# PROBLEM 2
# PART A
any(is.na(titanic_data))
# PART B
titanic_data_new <- na.omit(titanic_data)

#PROBLEM 3
# PART A
mean_age <- mean(titanic_data_new$Age)
median_age <- median(titanic_data_new$Age)

# PART B
total_suv <- sum(titanic_data_new$Survived)

# PART C
total_female_suv <- sum(titanic_data_new$Survived[titanic_data_new$Sex == "female"])

# PART D
total_male_suv <- sum(titanic_data_new$Survived[titanic_data_new$Sex == "male"])

# PART E
total_not_suv <- length(titanic_data_new$Survived[titanic_data_new$Survived == 0])

