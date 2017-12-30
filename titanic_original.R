library(tidyverse)

titanic <- read_csv("titanic_original.csv")


#port of embarkation
titanic$embarked[is.na(titanic$embarked)] <- "S"

#Age
titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm = TRUE)

#Lifeboat
titanic$boat[is.na(titanic$boat)] <- "None"

#Cabin
titanic <- titanic %>%
  mutate("has_cabin_number" = if_else(is.na(titanic$cabin), 0, 1))

#save
write.csv(titanic, "titanic_clean.csv")
