library(tidyverse)
library(lmerTest)


tt <- read.csv("postARIMA_covid.txt")
str(tt)
tt$Country <- factor(tt$Country)

tt.new <- gather(tt, key = "face_covering_required", value = "cases", 2:3 )
tt.new$face_covering_required <- ifelse( tt.new$face_covering_required == "No_Face_covering",
                                         "No", "Yes")
tt.new$face_covering_required <- factor(tt.new$face_covering_required)

fit <- lmer( cases ~ face_covering_required + (1 | Country) + face_covering_required: (1| Country), data = tt.new )
summary(fit)
