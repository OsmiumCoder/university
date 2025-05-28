data <- c(12,27,8,15,5,9,18,13,35,23,
          19,33,41,59,3,26,5,34,27,51)

mean(data)
median(data)

?mean
mean(data, trim = 0.1)

grade <- c(75,52,85,74,81)
weight <- c(30,5,10,15,40)

weighted.mean(weight, grade)

years <- c(23,9,12,21,24,6,33,34,17,3,
           12,31,5,10,27,9,15,16,30,38)

range(years)
var(years)
standard <- sd(years)
cv <- standard/mean(years)


mids <- c(2.5, 7.5, 12.5, 17.5, 22.5, 27.5, 32.5 ,37.5)
freq <- c(7, 26, 59, 71, 62, 39, 22, 14)

N <- sum(freq)

top <- sum(mids * freq)

mean = top / N

variance <- (sum(mids**2 * freq) - (sum(mids * freq)**2)/N)/N

standardD <- sqrt(variance)

xbar <- 310
s <- 37


