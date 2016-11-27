library(dplyr)
library(stringr)
library(DT)
library(xlsx)

setwd("C:/Users/ThinkPad/Desktop/GLMapper")
tblGL.10 <- read.csv2("TN10.csv", header=TRUE, sep = ",", quote = "\"",dec=".", na.strings = "N/A")
tblGL.00 <- read.csv2("TN00.csv", header=TRUE, sep = ",", quote = "\"",dec=".", na.strings = "N/A")
tblGL.10$Sub.Entity <- as.integer(tblGL.10$Sub.Entity)
tblGL <- bind_rows(tblGL.10, tblGL.00)

tblGL.DB <- tblGL %>%
  select(Entity,Sub.Entity,Department,Sales.Force,Product.Type, Product.Line, Sub.Product.Line, Company.Code, Business.Area, Internal.Order, Cost.Center, Profit.Center) %>%
  mutate(CostLocation = str_c(Entity, "0", Sub.Entity, Department, Sales.Force, "0", Product.Type, Product.Line, "0", Sub.Product.Line),
         Len=str_length(CostLocation))

names(tblGL.DB) <- gsub("\\.", "", names(tblGL.DB))

tableGL.DB <- tblGL.DB %>%
  select(CompanyCode, CostCenter, ProfitCenter, BusinessArea, InternalOrder, CostLocation)

write.xlsx2(tableGL.DB, "SPCostLocation.xlsx", sheetName="SPCostLocation", col.names=TRUE, row.names=FALSE)

