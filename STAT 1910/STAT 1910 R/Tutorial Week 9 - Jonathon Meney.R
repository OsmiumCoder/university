data<-read.csv("iris.csv")
summary(data)
Y<- data$SepalWidth # select Target attribute
X<- data$SepalLength # select Predictor attribute
hist(Y)
plot(Y ~ X, data = data)
iris_lm <- lm(Y ~ X, data = data)
summary(iris_lm)
par(mfrow=c(2,2))
plot(iris_lm)
par(mfrow=c(1,1))