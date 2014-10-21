# Author: Kevin C Limburg
# Date: 2014-10-20
#
# User Interface File for InternetSpeedDash Shiny App.

library(shiny)

shinyUI(fluidPage(
    
    titlePanel("Home Internet Speed Dashboard"),
    
    tabsetPanel(
        tabPanel("Monitor", 
                 # put time series plots here
                 
                 ),
        tabPanel("Explore",
                 # put in some exploratory features here
                 
                 ),
        tabPanel("Predict",
                 # maybe forcast future 
                 
                 ),
        tabPanel("Help",
                 # documentation goes here
                 
                 )
    )
))

