# Author: Kevin C Limburg
# Date: 2014-10-23
#
# Global File for InternetSpeedDash Shiny App.

library(dplyr)
library(reshape2)
library(stringr)
library(lubridate)

# read in data and clean
df<-read.csv(file = "data/speedtest.csv", header = F)
names(df) <- c("date.time", "Download", "Upload", "units", "server")
df$date.time <- as.POSIXct(df$date.time, origin = '1970-01-01')
df$server <- str_replace_all(df$server,pattern = "\\[\\'http:\\/\\/","")
df$server <- str_replace_all(df$server,pattern = "\\/speedtest\\/\\'\\]","")
df$server <- as.factor(df$server)
df$units<-paste0(df$units,"/sec")
df$ad.speed<-ifelse(df$date.time>as.POSIXct('2014-09-23 13:00:00'),105,25)
df$ad.speed.f<-as.factor(df$ad.speed)
df$hour <- hour(df$date.time)
df$day <- as.factor(weekdays(df$date.time))

# create unique servers 
serverNames<-unique(df$server)
# Date Range

dateRange<-range(df$date.time)


#melted data frame for ggplot 
df.melt<-melt(df, id.vars = c("date.time", "server", "units", 
                              "ad.speed.f", "ad.speed", "hour", "day"))

