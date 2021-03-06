# Author: Kevin C Limburg
# Date: 2014-10-20
#
# User Interface File for InternetSpeedDash Shiny App.

library(shiny)

shinyUI(fluidPage(    
    titlePanel("Home Internet Speed Dashboard"),
    fluidRow(includeMarkdown("Intro.Rmd")),
    tabsetPanel(
        tabPanel("Monitor",
                 sidebarLayout(
                     sidebarPanel(width = 3,
                                  selectInput(inputId = "serverSelect",
                                              label = "Select Server",
                                              choices = as.character(serverNames),
                                              selected = as.character(serverNames),
                                              multiple = TRUE),
                                  selectInput(inputId = "speedSelect",
                                              label = "Select Plan Speed",
                                              choices = c("25 Mbit/Sec","105 Mbit/Sec"),
                                              selected =  c("25 Mbit/Sec","105 Mbit/Sec"),
                                              multiple = TRUE),
                                  selectInput(inputId = "colorSelect",
                                              label = "Color By:",
                                              choices = c("Server",
                                                          "Direction",
                                                          "Plan Speed",
                                                          "Hour",
                                                          "Weekday"),
                                              selected =  "Direction"),
                                  dateRangeInput(inputId = "dateInput",
                                                 label = "Select Date Range",
                                                 start = dateRange[1],
                                                 end = dateRange[2],
                                                 min = dateRange[1],
                                                 max = dateRange[2]),
                                  checkboxInput(inputId = "smoother",
                                                label = "Apply Smoother",
                                                value = FALSE),
                                  checkboxInput(inputId = "groupServer",
                                                label = "Group Lines By Server",
                                                value = FALSE)
                     ),
                     mainPanel(
                         # put time series plots here
                         plotOutput("timeSeries"),
                         plotOutput("histogram")
                     )
                 )),
        tabPanel("Help",
                 # documentation goes here
                 includeMarkdown("Help.Rmd")
                 
        ) 
    )
))

