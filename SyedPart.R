setwd("/cloud/project")

TextMessages <- read.csv("TextMessages.csv", header=TRUE)


#install.packages("pastecs")

library(pastecs)

TextMessages$Group <- as.factor(TextMessages$Group)
by(TextMessages$Baseline,TextMessages$Group,stat.desc)
