# PROBLEM 1/INITIAL VALUES
data_canada <- read.csv ("Canada.csv", header = TRUE, stringsAsFactors = FALSE, skip = 1)
View(data_canada)
new_data <- data_canada[1:196,10:43]

# PROBLEM 3
sd_1980 <- sd(new_data$X1980)
sd_1990 <- sd(new_data$X1990)
sd_2003 <- sd(new_data$X2003)
sd_2013 <- sd(new_data$X2013)

var_1980 <- var(new_data$X1980)
var_1990 <- var(new_data$X1990)
var_2003 <- var(new_data$X2003)
var_2013 <- var(new_data$X2013)

# PROBLEM 4
hist(new_data$X1983)
hist(new_data$X1986)
hist(new_data$X2005)
hist(new_data$X2008)

boxplot(new_data$X1989)
boxplot(new_data$X1995)
boxplot(new_data$X2004)
boxplot(new_data$X2010)
