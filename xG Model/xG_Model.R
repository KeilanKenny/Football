load("model_data.Rda")

#make this example reproducible
set.seed(1)

#use 70% of dataset as training set and 30% as test set
sample <- sample(c(TRUE, FALSE), nrow(data_to_mod), replace=TRUE, prob=c(0.7,0.3))
train  <- data_to_mod[sample, ]
test   <- data_to_mod[!sample, ]


model <- glm(is_goal ~.,family=binomial(link='logit'),data=train)

summary(model)

anova(model, test="Chisq")

fitted.results <- predict(model,newdata=subset(test,select=c(2,3,4,5,6,7,8,9,10)),type='response')
fitted.results <- ifelse(fitted.results > 0.5,1,0)
misClasificError <- mean(fitted.results != test$is_goal)
print(paste('Accuracy',1-misClasificError))
acc<-1-misClasificError
acc <- format(round(acc, 4), nsmall = 4)
acc

library(ROCR)
p <- predict(model, newdata=subset(test,select=c(2,3,4,5,6,7,8,9,10)), type="response")
pr <- prediction(p, test$is_goal)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc <- format(round(auc, 4), nsmall = 4)
auc



plot(prf, 
     main = 'ROC Curve',
     xlab="False Postive Rate",
     ylab="True Postive Rate",)
title(paste("Accuracy:",acc,"| AUC:",auc),line=0.35,font.main = 1)
