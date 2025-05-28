
iris <- read.csv("iris.csv")
length <- iris$SepalLength

confident_int <- CI(length, ci=0.95)

sample <- sample(1:nrow(iris), 15)
data_iris_sample <- iris[sample,]
View(data_iris_sample)
CI(data_iris_sample$SepalLength, ci=0.95)

?sample
?nrow
bigger_sample <- sample(1:nrow(iris), 50)
the_sam <- iris[sample,]
CI(the_sam$SepalLength, ci=0.95)
