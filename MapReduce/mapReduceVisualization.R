setwd("C:\\Users\\Prateek\\PycharmProjects\\BigData\\MapReduce")
options(warn=-1)
.libPaths(c(.libPaths(), "C:/Users/Prateek/Documents/R/win-library/3.2"))
library(ggplot2)
library(plotly)
library(htmlwidgets)

.libPaths(c(.libPaths(), "C:/Users/Prateek/Documents/R/win-library/3.3"))
library(NLP)
library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)

wordData=read.csv("wordFrequency.csv",header = FALSE,col.names = c("Word","Frequency"))
wordData=wordData[order( wordData[,2],decreasing = TRUE),]
plotData=data.frame(head(wordData,10),tail(wordData,10))
plotData$Word<-factor(plotData$Word)
plotData$Word.1<-factor(plotData$Word.1)
p <- plot_ly(plotData, x=~Word , y = ~Frequency, name = 'MapReduce', type = 'bar')%>%
  layout(title = "Most Common Words", yaxis = list(title = "Frequency"), xaxis = list (title = "Term"))
htmlwidgets::saveWidget(widget = as.widget(p), file=file.path(getwd(),"mostCommon.html"), selfcontained
                        = FALSE)
p <- plot_ly(plotData, x=~Word.1 , y = ~Frequency.1, name = 'MapReduce', type = 'bar')%>%
  layout(title = "Least Common Words", yaxis = list(title = "Frequency"), xaxis = list (title = "Term"))
htmlwidgets::saveWidget(widget = as.widget(p), file=file.path(getwd(),"leastCommon.html"), selfcontained = FALSE)

filePath <- "Pagerank.txt"
text <- readLines(filePath)
# Load the data as a corpus
docs <- Corpus(VectorSource(text))

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
docs <- tm_map(docs, stemDocument)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)



set.seed(1234)
png("WordCloud.png", width=12, height=8, units="in", res=300)
cloud<-wordcloud(words = d$word, freq = d$freq, min.freq = 1,
                 max.words=200, random.order=FALSE, rot.per=0.35, 
                 colors=brewer.pal(8, "Dark2"))
dev.off()

d=head(d,10)
d$word<-factor(d$word)
p <- plot_ly(d, x=~word , y = ~freq, name = 'MapReduce', type = 'bar')%>%
  layout(title = "Most Important Words", yaxis = list(title = "Frequency"), xaxis = list (title = "Term"))
htmlwidgets::saveWidget(widget = as.widget(p), file=file.path(getwd(),"mostImportant.html"), selfcontained
                        = FALSE)



