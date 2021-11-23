library(shiny)
library(tidyverse)
library(plotly)
library(DT)

#####Import Data

dat<-read_csv("ideology.csv")
dat<- dat %>% select(c("pid7","ideo5","newsint","gender","educ","CC18_308a","region"))
dat<-drop_na(dat)

#####Make your app

ui <-navbarPage(title = "menu", tabPanel("page 1",fluidPage(
  #title
  titlePanel("ideology"), 
  sidebarLayout(
    sidebarPanel(
      sliderInput("main_ideology",
                  "Select Five Point Ideology (1=Very liberal, 5=Very conservative",
                  min = 1,
                  max = 5,
                  value = 3)
    ),
    mainPanel(tabsetPanel(tabPanel("tab1", plotOutput("displot")),
                          tabPanel("tab2", plotOutput("sunsplot")))
    )
  )
)), 
tabPanel("page 2",fluidPage(
  titlePanel("gender and education"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("checkgroup", label = h3("checkboxgroup"),
                         choices = list("Male"=1, "female"=2), selected = 1), 
      hr(), fluidRow()),
    mainPanel(plotlyOutput("iceplot")))
)), 
tabPanel("page 3", 
         fluidPage(
           sidebarLayout(
             sidebarPanel(
               selectInput("select3",
                           label = h4("select option"),
                           choices = list("1"=1, "2"=2, "3"=3, "4"=4), selected = 1),
               hr()
               
             ),mainPanel(fluidRow(column(12,DT::dataTableOutput('table'))))
             
           )
         ))
)

##input and output 
server <- function(input, output){
  #first page first plot
  output$displot <- renderPlot({
    ideology <- read_csv("ideology.csv")
    ideology<- ideology %>% select(c("pid7","ideo5"))
    ideology<-drop_na(ideology)
    ##connect the fucntion with output, in this part use command filtter.
    ggplot(filter(ideology,ideo5==input$main_ideology), mapping = aes(x=pid7))+
      geom_bar(fill="skyblue") + theme_light()
  })
  #first page second plot
  output$sunsplot <- renderPlot({
    dat<-read_csv("ideology.csv")
    dat<- dat %>% select(c("pid7","ideo5","newsint","gender","educ","CC18_308a","region"))
    dat<-drop_na(dat)
    ggplot(filter(dat, ideo5==input$main_ideology), mapping = aes(x=CC18_308a))+
      geom_bar(fill="green") + theme_light() + 
      ylab("trump support") + 
      ggtitle(" 1:strongly aprove 4:disprove")
  })
  #second page cekcbox
  output$iceplot <- renderPlotly({
    dat<-read_csv("ideology.csv")
    dat<- dat %>% select(c("pid7","ideo5","newsint","gender","educ","CC18_308a","region"))
    dat<-drop_na(dat)
    p <- ggplot(filter(dat, gender==input$checkgroup),mapping = aes(x=educ, y= pid7)) + geom_point() + 
      geom_smooth( method="lm" ,color="blue")
    po <- p
    po
  })
 
  output$table <- renderDataTable({
    datatable(dplyr::filter(dat, region==input$select3))
  })

}

###server of shiny aplication

shinyApp(ui=ui, server = server)