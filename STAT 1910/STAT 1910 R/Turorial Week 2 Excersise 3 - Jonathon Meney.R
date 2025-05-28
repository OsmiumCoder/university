# Problem 3
# Data
max_temps <- c (23, 21, 24, 24, 24, 26, 27, 21, 22, 25, 27, 28, 31, 30, 
                26, 23, 28, 28, 28, 27, 24, 25, 27, 27, 28, 29, 24, 20, 
                24, 20)

min_temps <- c (14, 13, 13, 16, 17, 18, 18, 9, 8, 16, 18, 20, 21, 21, 16, 
                14, 14, 17, 19, 18, 11, 11, 16, 20, 19, 18, 15, 10, 10, 
                12)

# Part a)
avgerage <- mean(max_temps)
variance <- var(min_temps)

# Part b)
med <- median(min_temps)
stanDeviation <- sd(min_temps)

# Part c)
maxHist <- hist(max_temps)
nimHist <- hist(min_temps)
