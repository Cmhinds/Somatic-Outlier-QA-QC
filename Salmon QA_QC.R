#Salmon Somatic Weight and Length Outlier Check####
#R/V Unknown Boat QA/QC
#Chris Hinds 3/17/2022
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Install packages and call up libraries####
install.packages("measurements")
library(tidyverse)
library(ggplot2)
library("readxl")
library(dplyr)
library(measurements)  #convert cm to mm and kg to g
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Import Data Set####
setwd("G:\\ZZ Hinds\\R\\Codes for how to do things\\Somatic Outlier QA QC")
library(readxl)
Salmon_Metadata <- read_excel("Salmon Data.xlsx", 
                               sheet = "Mar 5 specimen measurements")
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Filter for Salmon species only and make a new dataframe####

#Newdataframe <- dplyr::select(dataframe, columnA, columnB, columnC, columnD, columnE, columnF)   SELECT A FEW COLUMNS
#OR
#Newdataframe <- filter(dataframe, columnname == "whatyouwanttofilterout")  USE TO FILTER TO ONLY INCLUDE/selects rows based on their values


Salmon_Metadata_filtered <- dplyr::select(Salmon_Metadata, SURVEY, HAUL, COMMON_NAME, SPECIMEN_ID, BARCODE, FORK_LENGTH, ORGANISM_WEIGHT)

species_to_include <-c("Sockeye salmon", "Pink salmon","Chum salmon", "Chinook salmon") #You can make a list of things to include for your filter then use the list name


Salmon_Final <- filter(Salmon_Metadata, COMMON_NAME %in% species_to_include)
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Convert single measurement from cm to mm or kg to g####
#conv_unit(the_measurement, "cm", "mm") 
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#Make new columns that convert length from cm to mm and weight from kg to g####  

library(dplyr)
Salmon_Final %>% mutate(FORK_LENGTH = FORK_LENGTH * 10,ORGANISM_WEIGHT = ORGANISM_WEIGHT * 1000) #change measurements
Salmon_Final$FORK_LENGTH_mm <- Salmon_Final$FORK_LENGTH * 10 #this creates a new column
Salmon_Final$ORGANISM_WEIGHT_g <-Salmon_Final$ORGANISM_WEIGHT *1000 #this creates a new column
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#Plot Length vs weight for fish outliers####
#ggplot(DATAFRAME,aes(x AXIS, Y AXIS))+ geom_point()                                #this plots the X, Y and data points show up

ggplot(Salmon_Final, aes(ORGANISM_WEIGHT_g,FORK_LENGTH_mm, col=COMMON_NAME))+     #col=columnname will color code groups in that column
  geom_point()+                                                                     #theme_classic() will take away the grid marks
  theme_classic()+ 
  theme(legend.title = element_blank())+                                            #theme(legend.title = element_blank() removes the ledgend title
  labs(x = "Somatic Weight g", y = "Somatic Length mm", title = "Salmon Speices Somatic Length vs Weight")       #Renames the X,Y and Title


#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Save the Plot####
#ggsave(plot = plottosave, filename = "output/filesavename.png",
#       dpi = 300, width = 6, height = 4, units = "in")


#Think about saving another way

