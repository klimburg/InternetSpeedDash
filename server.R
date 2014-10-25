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
        #apply filters
        df.plot<-df.melt%>%
            filter(server %in% servers,
                   ad.speed %in% speeds,
                   date.time >= dates[1],
                   date.time <= dates[2])
        
        #plot graph
        plot1<-ggplot(df.plot,aes(x=date.time, y=value))
        
        plot1<- plot1+
            geom_line(aes(color=variable))+
            geom_point(aes(shape=server, color=variable),size=3)+
            facet_wrap(~variable, scale = "free_y", ncol=1)+
            labs(y="Mbit/Sec", x = "Date")
        if(input$smoother){
            plot1<-plot1+geom_smooth(aes(x=date.time, y=value))
        }
        plot1
    })
    
    
})


