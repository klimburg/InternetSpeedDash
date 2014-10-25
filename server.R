# Author: Kevin C Limburg
# Date: 2014-10-20
#
# Server File for InternetSpeedDash Shiny App.


library(shiny)
library(ggplot2)
 

shinyServer(function(input, output) {
        
    output$timeSeries<-renderPlot({
        # filters
        servers<-input$serverSelect
        dates <- as.POSIXct(input$dateInput)
        speeds <- str_replace_all(input$speedSelect," Mbit/Sec","")
        speeds <- as.numeric(speeds)
        colorSelect<-switch(input$colorSelect,
                            "Server" = "server",
                            "Direction" = "variable",
                            "Plan Speed" = "ad.speed.f",
                            "Hour" = "hour",
                            "Weekday" = "day")
        #apply filters
        df.plot<-df.melt%>%
            filter(server %in% servers,
                   ad.speed %in% speeds,
                   date.time >= dates[1],
                   date.time <= dates[2])
        
        #plot graph
        if(input$groupServer){
            plot1<-ggplot(df.plot,aes(x=date.time, y=value, group=server))
        }
        else{
            plot1<-ggplot(df.plot,aes(x=date.time, y=value))    
        }        
        
        plot1<- plot1+
            geom_line(aes_string(color=colorSelect))+
            geom_point(aes_string(shape="server", color=colorSelect),size=3)+
            facet_wrap(~variable, scale = "free_y", ncol=1)+
            labs(y="Mbit/Sec", x = "Date", shape = "Server", color = input$colorSelect)+
            theme(title = element_text(size = 16),
                  text = element_text(size = 14))
        if(input$smoother){
            plot1<-plot1+
                geom_smooth(aes_string(x = "date.time",
                                       y = "value",
                                       color = colorSelect),
                            alpha = 0.8,
                            size = 1.5,
                            se = FALSE)
        }
        plot1
    })
    
    output$histogram<-renderPlot({
        # filters
        servers<-input$serverSelect
        dates <- as.POSIXct(input$dateInput)
        speeds <- str_replace_all(input$speedSelect," Mbit/Sec","")
        speeds <- as.numeric(speeds)
        colorSelect<-switch(input$colorSelect,
                            "Server" = "server",
                            "Direction" = "variable",
                            "Plan Speed" = "ad.speed.f",
                            "Hour" = "hour",
                            "Weekday" = "day")
        #apply filters
        df.plot <- df.melt%>%
            filter(server %in% servers,
                   ad.speed %in% speeds,
                   date.time >= dates[1],
                   date.time <= dates[2])
       
        plot2 <- ggplot(df.plot)
        plot2 <- plot2 +
            geom_histogram(aes_string(x = "value", fill = as.character(colorSelect)))+
            facet_wrap(~variable, scale = "free", nrow=1)+
                labs(x="Mbit/Sec", y = "Count", fill = input$colorSelect)+
                theme(title = element_text(size = 16),
                      text = element_text(size = 14))
        plot2
    })
    
    
})


