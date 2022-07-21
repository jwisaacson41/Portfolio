#' @TITLE: Shiny App Practice 04 - Reactive Output
#' @DESCRIPTION: https://shiny.rstudio.com/tutorial/written-tutorial/lesson2/

library(shiny)
library(maps)
library(mapproj)

source("data/helpers.R")

counties <- readRDS("data/counties.rds")

# Define UI ----

ui <- fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("create demographic maps with information from the 2010 US Census"),
      
      selectInput("selectvar1", "Choose a variable to display",
                  choices = c("Percent White",
                                 "Percent Black",
                                 "Percent Hispanic",
                                 "Percent Asian"),
                  selected = "Percent White"),
      
      sliderInput("slider1", "Range of Interest:",
                  min=0, max=100, value=c(0, 100))
    ),
    
    mainPanel(
      plotOutput("map")
    )
  )
)


# Define server logic  ----
server <- function(input, output) {
  
  output$map<-renderPlot({
    data = switch(input$selectvar1,
                  "Percent White" = counties$white,
                  "Percent Black" = counties$black,
                  "Percent Hispanic" = counties$hispanic,
                  "Percent Asian" = counties$asian)
    
    color <- switch(input$selectvar1, 
                    "Percent White" = "darkgreen",
                    "Percent Black" = "darkblue",
                    "Percent Hispanic" = "darkorange",
                    "Percent Asian" = "darkviolet")
    
    legend <- switch(input$selectvar1, 
                     "Percent White" = "% White",
                     "Percent Black" = "% Black",
                     "Percent Hispanic" = "% Hispanic",
                     "Percent Asian" = "% Asian")
    
    percent_map(data,
                color,
                legend.title = legend,
                min = input$slider1[1],
                max = input$slider1[2])
  })
  
}

shinyApp(ui = ui, server = server)





