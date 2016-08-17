getwd()
setwd("C:/Mac/Projects/SPCA")

###Prep Database

##Work on first file
data_SPCA <- read.csv(file="SPCA_data.csv",header=T,sep = ",",na.strings=c("NA"))

#Merge data bases
data_SPCA_MbM1 <- read.csv(file="Fabiana_20160608_2013_Q1_Q2.csv",header=T,sep = ",",na.strings=c(""," ","NA"))
total1 <- merge(data_SPCA,data_SPCA_MbM1,by=c("CnBio_ID","CnBio_Gender","CnBio_Religion"),all=T)
data_SPCA_MbM2 <- read.csv(file="Fabiana_20160608_2013_Q3_Q4.csv",header=T,sep = ",",na.strings=c(""," ","NA"))
total2 <- merge(total1,data_SPCA_MbM2,by=c("CnBio_ID","CnBio_Gender","CnBio_Religion"),all=T)
data_SPCA_MbM3 <- read.csv(file="Fabiana_20160608_2014_Q1_Q2.csv",header=T,sep = ",",na.strings=c(""," ","NA"))
total3 <- merge(total2,data_SPCA_MbM3,by=c("CnBio_ID","CnBio_Gender","CnBio_Religion"),all=T)
data_SPCA_MbM4 <- read.csv(file="Fabiana_20160608_2014_Q3_Q4.csv",header=T,sep = ",",na.strings=c(""," ","NA"))
total4 <- merge(total3,data_SPCA_MbM4,by=c("CnBio_ID","CnBio_Gender","CnBio_Religion"),all=T)
data_SPCA_MbM5 <- read.csv(file="Fabiana_20160608_2015_Q1_Q2.csv",header=T,sep = ",",na.strings=c(""," ","NA"))
total5 <- merge(total4,data_SPCA_MbM5,by=c("CnBio_ID","CnBio_Gender","CnBio_Religion"),all=T)
data_SPCA_MbM6 <- read.csv(file="Fabiana_20160608_2015_Q3_Q4.csv",header=T,sep = ",",na.strings=c(""," ","NA"))
total6 <- merge(total5,data_SPCA_MbM6,by=c("CnBio_ID","CnBio_Gender","CnBio_Religion"),all=T)
data_SPCA_MbM7 <- read.csv(file="Fabiana_20160608_2016_Q1_Q2.csv",header=T,sep = ",",na.strings=c(""," ","NA"))
data_SPCA_MbM <- merge(total6,data_SPCA_MbM7,by=c("CnBio_ID","CnBio_Gender","CnBio_Religion"),all=T)

##Work on new file
data_SPCA_MbM <- read.csv(file="data_SPCA_MbM.csv",header=T,sep = ",",na.strings=c(""," ","NA"))

#Arrange prices annotation
indx <- sapply(data_SPCA_MbM, is.factor) 
data_SPCA_MbM[indx] <- lapply(data_SPCA_MbM[indx], function(x) 
  as.factor(gsub("\\$", "", x)))
indx <- sapply(data_SPCA_MbM, is.factor) 
data_SPCA_MbM[indx] <- lapply(data_SPCA_MbM[indx], function(x) 
  as.factor(gsub("\\,", "", x)))

factorToNumeric <- function(x) as.numeric(levels(x))[as.integer(x)] 
cols<-c(6,9,15,18,19,21,22,24,25,27,28,30,31,33,34,36,37,39,43,47,49,50,52,53,55,56,58,59,61,62,64,65,67,68,70,71,73,74,76,77,79,80,82,83,85,86,88,89,91,92,94,95,97,98,100,101,103,104,106,107,109,110,112,113,115,116,118,119,121,122,124,125,127,128,130,131,133,134,136,137,139,140,142,143,145,146,148,149,151,152,154,155,157,158,160,161,163,164,166,167,169,170,172)
data_SPCA_MbM[,cols] <- lapply(data_SPCA_MbM[,cols], factorToNumeric)

#Transformation to dates
data_SPCA_MbM$CnFGf_1_Date<-as.Date(data_SPCA_MbM$CnFGf_1_Date, "%m/%d/%Y")
data_SPCA_MbM$CnLGf_1_Date<-as.Date(data_SPCA_MbM$CnLGf_1_Date, "%m/%d/%Y")
data_SPCA_MbM$CnLrgGf_1_Date<-as.Date(data_SPCA_MbM$CnLrgGf_1_Date, "%m/%d/%Y")
data_SPCA_MbM$CnGf_1_01_Gift_status_date<-as.Date(data_SPCA_MbM$CnGf_1_01_Gift_status_date, "%m/%d/%Y")
data_SPCA_MbM$CnGf_1_01_Date<-as.Date(data_SPCA_MbM$CnGf_1_01_Date, "%m/%d/%Y")

#Save r file
save(data_SPCA_MbM,file="data_SPCA_MbM.Rda")

#Extraction csv
write.csv(data_SPCA_MbM,"data_SPCA_MbM.csv")

load("data_SPCA_MbM.Rda")
