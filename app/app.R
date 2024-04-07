

library(shiny)
library(readr)

# Define UI
ui <- fluidPage(
  titlePanel("Scatterplot"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Choose CSV File",
                accept = c(".csv"))
    ),
    mainPanel(
      plotOutput("scatterplot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Read the CSV file
  data <- reactive({
    req(input$file)
    read_csv(input$file$datapath)
  })
  
  output$scatterplot <- renderPlot({
    req(data())
    plot(data()$x, data()$y, main = "Scatterplot", xlab = "X", ylab = "Y")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
