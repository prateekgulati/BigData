setwd("C:\\Users\\Prateek\\PycharmProjects\\BigData\\Finance")
options(warn=-1)
.libPaths(c(.libPaths(), "C:/Users/Prateek/Documents/R/win-library/3.2"))

library(ggplot2)
library(GGally)
library(plotly)
library(htmlwidgets)
ticker=c("APPL","ALV","MCK","XRX")
ticker="APPL"
for( tic in ticker){
  data=read.csv(paste(tic,"balance_sheet.csv",sep = '\\'))

 plot<-ggcorr(data[ 2:4,], geom = "blank", label = TRUE, hjust = 0.75) +
    geom_point(size = 10, aes(color = coefficient > 0, alpha = abs(coefficient) > 0.9)) +
    scale_alpha_manual(values = c("TRUE" = 0.25, "FALSE" = 0)) +
    guides(color = FALSE, alpha = FALSE)
  ggsave(paste(tic,"corr.jpg",sep = '\\'),width  = 18.2, height = 9.88)
  print(plot)

  QuickRatio=(data$AssetsCurrent-data$Inventory)/data$LiabilitiesCurrent
  CurrRatio= data$AssetsCurrent/data$LiabilitiesCurrent
  DebtRatio=data$Liabilities/data$Assets
  EquityRatio=data$StockholdersEquity/data$Assets
  DebtToEquity=data$LiabilitiesCurrent/data$StockholdersEquity
  AssetsChange=c(NA,diff(data$Assets)*100/data$Assets[1:3])
  LiabilitiesChange=c(NA,diff(data$Liabilities)*100/data$Liabilities[1:3])
  EquityChange=c(NA,diff(data$StockholdersEquity)*100/data$StockholdersEquity[1:3])
  year=as.character(data[,1])
  PlotData=data.frame(year,AssetsChange,LiabilitiesChange,EquityChange,QuickRatio,CurrRatio,DebtRatio, EquityRatio,DebtToEquity)
  
  #ggplot(data=PlotData, aes(x=year, y=QuickRatio, group=1)) + 
  #  geom_line(colour="red", linetype="dashed", size=1) + 
  #  geom_point(colour="red", size=5, shape=21, fill="white") +
  #  xlab("Year") + ylab("Ratio") + # Set axis labels
  #  ggtitle("Quick Ratio") +     # Set title
  #  theme_bw()
  #ggsave(paste(tic,"QuickRatio.jpg",sep = '\\'))
  
  p <- plot_ly(PlotData, x = ~year, y = ~AssetsChange, name = 'AssetsChange', type = 'bar',marker = list(color = 'rgb(0, 51, 255)')) %>%
        add_trace(y = ~LiabilitiesChange, name = 'LiabilitiesChange',marker = list(color = 'rgb(255, 204, 0)')) %>%
        add_trace(y = ~EquityChange, name = 'EquityChange',marker = list(color = 'rgb(51, 154, 0)'))%>%
    layout(title = "Assets Percentage Change", xaxis = list(title = "Year"), yaxis = list (title = "Percentage Change"))
  htmlwidgets::saveWidget(widget =  as.widget(p), file=file.path(getwd(), paste(tic, "/PercentageChange.html", sep="")), selfcontained = FALSE)
  
  
  p<-plot_ly(PlotData, x = ~year, y = ~CurrRatio, name = 'CurrentRatio', type = 'scatter', mode = 'lines+markers',line=list(dash='dot')) %>%
    layout(title = "Current Ratio", xaxis = list(title = "Year"), yaxis = list (title = "Ratio"))
  htmlwidgets::saveWidget(widget = as.widget(p), file=file.path(getwd(), paste(tic, "/CurrentRatio.html", sep="")), selfcontained = FALSE)
  
  p <- plot_ly(PlotData, x = ~year, y = ~QuickRatio, name = 'QuickRatio', type = 'scatter', mode = 'lines+markers',line=list(dash='dot')) %>%
    layout(title = "Quick Ratio", xaxis = list(title = "Year"), yaxis = list (title = "Ratio"))
  htmlwidgets::saveWidget(widget = as.widget(p), file=file.path(getwd(), paste(tic, "/QuickRatio.html", sep="")), selfcontained = FALSE)

  p <- plot_ly(PlotData, x = ~year, y = ~DebtRatio, name = 'DebtRatio', type = 'scatter', mode = 'lines+markers',line=list(dash='dot')) %>%
    add_trace(y = ~EquityRatio, name = 'EquityRatio') %>%
    add_trace(y = ~DebtToEquity, name = 'DebitToEquity') %>%
    layout(title = "Equity and Debt Ratios", xaxis = list(title = "Year"), yaxis = list (title = "Ratio"))
  htmlwidgets::saveWidget(widget = as.widget(p), file=file.path(getwd(), paste(tic, "/DebtEquityRatio.html", sep="")), selfcontained = FALSE)
  
}
