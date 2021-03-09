# This is code has been created to pull the Coronavirus dashboard LTLA data and save within the City and County Testing Data Folder
# Data sourced from https://coronavirus.data.gov.uk/details/download

# Clear the environment
rm(list=ls())

# Install and load (with the library function) the required packages - You only need to perform install packages once. After the first install call each package using the library function
install.packages("ukcovid19")
install.packages("xlsx")
install.packages("tidyverse")
install.packages("curl")
install.packages('RcppRoll')
install.packages("ragg")
library(tidyverse)
library(curl)
library(ukcovid19)
library(RcppRoll)
library(ragg)
library(xlsx)

# Set working directory as the folder you want the dataframe to be saved to
setwd("insert path to working directory here")

# Check the working directory is correct
getwd()

# Bring in daily data
temp <- tempfile()
source="https://api.coronavirus.data.gov.uk/v2/data?areaType=ltla&metric=cumCasesBySpecimenDate&metric=newCasesBySpecimenDate&metric=cumCasesBySpecimenDateRate&format=csv"
temp <- curl_download(url=source, destfile=temp, quiet=FALSE, mode="wb")
APIdata2 <- read.csv(temp)
colnames(APIdata2) <- c("date", "type", "code", "name", "Cumulative lab-confirmed cases", "Daily lab_confirmed cases", "Cumulative lab-confirmed cases rate")

# Save the export as a xlsx 
write.xlsx(APIdata2, file = "ALL_LA's.xlsx",
           sheetName = "coronovirus-cases_latest", append=FALSE)