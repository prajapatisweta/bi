quality <- read.csv('G:/sweta-practicals/Sem 6/BI/extra/Practical 10/quality.csv')
str(quality)
table(quality$PoorCare)
98/131
install.packages("caTools")
library(caTools)
set.seed(88)
split = sample.split(quality$PoorCare, SplitRatio = 0.75)
split
qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)
nrow(qualityTrain)
nrow(qualityTest)
QualityLog = glm(PoorCare ~ OfficeVisits + Narcotics, data = qualityTrain, family = binomial)
summary(QualityLog)
predictTrain = predict(QualityLog, type = "response")
summary(predictTrain)
tapply(predictTrain, qualityTrain$PoorCare, mean)
table(qualityTrain$PoorCare, predictTrain > 0.5)
10/25
70/74
table(qualityTrain$PoorCare, predictTrain > 0.7)
8/25
73/74
table(qualityTrain$PoorCare, predictTrain > 0.2)
16/25
54/74

install.packages("ROCR")
library(ROCR)
ROCRpred = prediction(predictTrain, qualityTrain$PoorCare)
ROCRpref = performance(ROCRpred, "tpr", "fpr")
plot(ROCRpref)
plot(ROCRpref, colorize=TRUE)
plot(ROCRpref, colorize=TRUE, print, print.cutoffs.at = seq(0,1,by = 0.1), text.adj = c(-0.2,0.7))