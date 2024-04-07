# #
# # This is a Shiny web application. You can run the application by clicking
# # the 'Run App' button above.
# #
# # Find out more about building applications with Shiny here:
# #
# #    https://shiny.posit.co/
# #
# 
library(shiny)
library(shinydashboard)
library(DT)
library(DBI)
library(RSQLite)
library(ggplot2)
library(shinythemes)
library(shinyjs)
library(shinycssloaders)
library(lubridate)
library(shinyFeedback)
library(dplyr)
library(dbplyr)


# Connect to your SQLite database
sqldb_connection <- dbConnect(RSQLite::SQLite(), 'data/sdm_netflix.sqlite')

# Define the UI
ui <- dashboardPage(
  skin="green",
  dashboardHeader(title = "SDM Project"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Data View", tabName = "dataview", icon = icon("table")),
      menuItem("Analysis", tabName = "charts", icon = icon("bar-chart")),
      menuItem("Charts", tabName = "charts", icon = icon("bar-chart")),
      menuItem("About", tabName = "about", icon = icon("info-circle"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "home",
              h2("Welcome to the SDM Project"),
              h3("Team Members"),
              h4("1. Vaibhav Bansal - Employee"),
              h4("2. Devendra Rana - CEO"),
              h4("3. Mounika - CMO"),
              h4("4. Atul Sharma - CTO")
      ),
      tabItem(tabName = "dataview",
              h2("Data View"),
              downloadButton("downloadData", "Download Data"),
              br(),
              DT::dataTableOutput("dataView")
      ),
      tabItem(tabName = "charts",
              h2("Charts"),
              sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
              plotOutput("histPlot")
      ),
      tabItem(tabName = "about",
              h2("About the Team"),
              p("Vaibhav"),
              p("Devendra"),
              p("Mounika"),
              p("Atul")
      )
    )
  )
)

# Server logic
server <- function(input, output) { 
  # Data View
  output$dataView <- DT::renderDataTable({
    query <- sprintf("SELECT * FROM netflix")
    data <- dbGetQuery(sqldb_connection, query)
    DT::datatable(data)
  })
  
  # Charts (Histogram)
  output$histPlot <- renderPlot({
    data <- rnorm(100)
    bins <- seq(min(data), max(data), length.out = input$bins + 1)
    hist(data, breaks = bins, col = 'lightblue', border = 'white')
  })
  
  output$downloadData <- downloadHandler(
        filename = function() {
          paste("data-", Sys.Date(), ".csv", sep = "")
        },
        content = function(file) {
          query <- "SELECT * FROM netflix"
          data <- dbGetQuery(sqldb_connection, query)
          write.csv(data, file, row.names = FALSE)
        }
    )
}

# Run the application
shinyApp(ui, server)
