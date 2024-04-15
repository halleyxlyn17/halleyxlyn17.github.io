library(tidyverse)
library(shiny)

df = read.csv("data.csv")

ui <- fluidPage(
  titlePanel("Sample App"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput("con_inp", "Select Country:", 
                  choices = unique(df$country))
    ),
    mainPanel = mainPanel(
      plotOutput("plot1")
    )
  )
)

server <- function(input, output){
  output$plot1 <- renderPlot({
    df %>% filter(country == input$con_inp) %>%
      ggplot() +
      geom_line(aes(x = Year, y = Gender.wage.gap..))
  })
}

shinyApp(ui, server)
