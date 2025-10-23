# Setting Working Directory
setwd("/cloud/project") 

#Read the Data and call it TextMessages
TextMessages <- read.csv("TextMessages.csv", header=TRUE)

# Create the dataset
text_data <- data.frame(Participant = 1:50, Group = c(rep(1, 25), rep(2, 25)),
                        Baseline = c(52,68,85,47,73,57,63,50,66,60,51,72,77,57,
                                     79,75,53,72,62,71,53,64,79,75,60,65,57,66,
                                     71,75,61,80,66,53,62,61,77,66,52,60,58,54,
                                     72,71,87,75,57,59,46,89),
                        Six_months = c(32,48,62,16,63,53,59,58,59,57,60,56,61,
                                       52,9,76,38,63,53,61,50, 78,33,68,59,62,
                                       50,62,61,70,64,64,55,47,61,56,64,62,47,
                                       56,78,74, 61,61,78,62,71,55,46,79))


# *** RESHAPE DATE FROM WIDE TO LONG ***
library(tidyr)
library(dplyr)

text_long <- text_data %>% pivot_longer(cols = c(Baseline, Six_months),
                            names_to = "Timepoint", values_to = "TextMessages")


##############
## BOX PLOT ##
##############

library(ggplot2)

# quick peek to confirm the data is ready
str(text_long)
head(text_long)
table(text_long$Timepoint)
table(text_long$Group)

# Make sure Categorical Variables exist 
text_long$Group <- as.factor(text_long$Group)
text_long$Timepoint <- factor(text_long$Timepoint, levels = 
                                c("Baseline", "Six_months"))
# Create the boxplot
Boxplot <- ggplot(text_long, aes(x = Timepoint, y = TextMessages, 
                                 fill = Timepoint))
Boxplot

# Add box layer 
Boxplot + geom_boxplot()

# Stratify into 2 seperate groups
Boxplot + geom_boxplot() + facet_wrap(~ Group, labeller = labeller(Group = 
                                          c(`1` = "Group 1", `2` = "Group 2")))

#add user-defined labels 
Boxplot + geom_boxplot() + facet_wrap(~ Group, labeller = labeller(Group = 
                         c(`1` = "Group 1", `2` = "Group 2"))) + labs(title =   
                       "Text Messages by Group and Timepoint", x = "Timepoint", 
                       y = "Number of Text Messages") 

# Make it look cleaner 
Boxplot + geom_boxplot() + facet_wrap(~ Group, labeller = labeller(Group = 
                         c(`1` = "Group 1", `2` = "Group 2"))) + labs(title = 
                       "Text Messages by Group and Timepoint", x = "Timepoint",
                       y = "Number of Text Messages") + theme_minimal() + 
       theme(legend.position = "none", plot.title =  element_text(hjust = 0.5))