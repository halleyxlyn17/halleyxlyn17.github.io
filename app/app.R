library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  
  # Application title
  titlePanel("Scatterplot Example"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    sidebarPanel(
      # Input: Upload CSV file
      fileInput("file", "Choose CSV File",
                accept = c(".csv")),
      # Input: Choose columns for x and y axes
      selectInput(inputId = "x_column",
                  label = "Choose a column for x-axis:",
                  choices = NULL),
      selectInput(inputId = "y_column",
                  label = "Choose a column for y-axis:",
                  choices = NULL)
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      # Output: Scatterplot
      plotOutput(outputId = "scatterplot")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # Read uploaded CSV file
  data <- reactive({
    req(input$file)
    read.csv(input$file$datapath)
  })
  
  # Update column choices when file is uploaded
  observe({
    col_choices <- names(data())
    updateSelectInput(session, "x_column", choices = col_choices)
    updateSelectInput(session, "y_column", choices = col_choices)
  })
  
  # Render the scatterplot based on selected columns
  output$scatterplot <- renderPlot({
    req(input$file)
    req(input$x_column)
    req(input$y_column)
    
    ggplot(data(), aes_string(x = input$x_column, y = input$y_column)) +
      geom_point() +
      labs(title = "Scatterplot", x = input$x_column, y = input$y_column)
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)