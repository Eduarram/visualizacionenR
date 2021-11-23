#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
#####Import Data

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% select(c("pid7","ideo5"))
dat<-drop_na(dat)

###data plot
ggplot(data = dat, mapping = aes(x=pid7, fill=ideo5))+
  geom_bar()+ 
  facet_wrap(~ideo5)


# Define UI or user interface
ui <- fluidPage(
  #title
  titlePanel("Select Five Point Ideology (1=Very liberal, 5=Very conservative)"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("main_ideology",
                  "ideology_2:",
                  min = 1,
                  max = 5,
                  value = 30)
    ),
    mainPanel(
      plotOutput("displot")
    )
  )
)

##input and output 
server <- function(input, output){
  
  output$displot <- renderPlot({
    ideology <- read_csv("ideology.csv")
    ideology<- ideology %>% select(c("pid7","ideo5"))
    ideology<-drop_na(ideology)
    ##connect the fucntion with output, in this part use command filtter.
    ggplot(filter(ideology,ideo5==input$main_ideology), mapping = aes(x=pid7))+
      geom_bar(fill="skyblue") + theme_light()
  })
}

###server of shiny aplication

shinyApp(ui=ui, server = server)


