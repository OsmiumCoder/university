texts <- c(32, 33, 33, 34, 35, 36, 37, 37, 37, 37, 38, 39, 40, 41, 41, 42, 
          42, 42, 43, 44, 44, 45, 45, 45, 47, 47, 47, 47, 47, 48, 48, 49, 
          50, 50, 51, 52, 53, 54, 59, 61)

class <- seq(from=32, to=62, by = 6)

midpo <- c(34.5,40.5,46.5,52.5,58.5)

classW <- cut(texts, breaks=class, right=FALSE, include.lower=TRUE, dig.lab = 5)

Freq <- as.data.frame(cbind(table(classW)),row.names = FALSE,)

colnames(Freq) <- "f"

Class <- c("32-37", "38-43", "44-49", "50-55", "56-61")
Freq <- cbind(Class, midpo,Freq)
Freq$rel.freq <- Freq$f/40
Freq$percent <- Freq$rel.freq*100
Freq$Cum.freq <- cumsum(Freq$f)
Freq$Cum.rel.freq <- cumsum(Freq$rel.freq)

h <- hist(texts,
     breaks = class,
     main = "Number of Texts sent per day over 40 days",
     xlab = "Number of Texts Sent",
     ylab = "Number of Days",
     xaxt = "n",
     ylim = c(0,14)
     )
axis(1, h$mids, labels = midpo, tick = FALSE, padj= -1.5)