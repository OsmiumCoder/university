pats <- c(0, 1, 2, 3, 4, 5, 6)
prob <- c(0.2725, 0.3543, 0.2303, 0.0998, 0.0324, 0.0084, 0.0023)

tab <- data.frame(pats, prob)
?barplot
graph <- barplot(prob~pats,
                 tab,
                 space = 0,
                 ylim = c(0, 0.4),
                 xlab = "Number of Patients",
                 ylab = "Probability",
                 main = "Probability for a Number of Patients to walk into the Emergency Room Over a 1 Hour period"
                 )

x <- c(0, 1, 2, 3, 4, 5)
p <- c(0.08, 0.12, 0.32, 0.28, 0.12, 0.08)

m <- sum(x*p)
stan <- sqrt(sum((x ** 2) * p) - m**2)
other <- sqrt(sum(((x - m) ** 2) * p))



