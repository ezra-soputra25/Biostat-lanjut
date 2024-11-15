#mengunggah data yang akan diubah formatnya
library(data.table)
stroke <- fread("http://www.statsci.org/data/oz/stroke.txt")

#reshaping wide format to long format
library(reshape2)
stroke_long <- melt(stroke,id.vars = c("Subject","Group", "Sex", "Side", "Age", "Lapse"))

#ATAU

#Mode reshaping wide to long format dengan pemisahan variable UE,HW,LE,Bal dan Bart
stroke1long <- reshape(stroke,varying = c('UE1','UE2','UE3','UE4','UE5','UE6','UE7','UE8','HW1','HW2','HW3','HW4','HW5','HW6','HW7','HW8','LE1','LE2','LE3','LE4','LE5','LE6','LE7','LE8','Bal1','Bal2','Bal3','Bal4','Bal5','Bal6','Bal7','Bal8','Bart1','Bart2','Bart3','Bart4','Bart5','Bart6','Bart7','Bart8'), direction = "long", timevar = "Observation",idvar = "Subject", v.names = c("UE","HW","LE","Bal","Bart"))

stroke1long <- reshape(stroke,varying = c('UE1','UE2','UE3','UE4','UE5','UE6','UE7','UE8','HW1','HW2','HW3','HW4','HW5','HW6','HW7','HW8','LE1','LE2','LE3','LE4','LE5','LE6','LE7','LE8','Bal1','Bal2','Bal3','Bal4','Bal5','Bal6','Bal7','Bal8','Bart1','Bart2','Bart3','Bart4','Bart5','Bart6','Bart7','Bart8'), direction = "long", timevar = "Observation", times = c(1, 2, 3, 4, 5, 6, 7, 8),idvar = "Subject", v.names = c("UE","HW","LE","Bal","Bart"))

library(dplyr)
library(tidyr)
strokelong <- stroke %>% pivot_longer(cols = starts_with(c("UE","HW","LE","Bal","Bart")), names_to = c("Variable","Time"), names_pattern = "(\\D+)(\\d+)", values_to = "ability")

stroke_long = stroke %>% select(c(1:6,39:46)) %>% 
  pivot_longer(cols=Bart1:Bart8,
               names_to= "Time",
               names_prefix = "Bart",
               values_to="ability")                       
