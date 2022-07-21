#' @TITLE: Shiny App Practice 04 - Reactive Output
#' @DESCRIPTION: https://shiny.rstudio.com/tutorial/written-tutorial/lesson2/

library(shiny)

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
      textOutput("selected_var"),
      textOutput("selected_range"),
      dataTableOutput("df_output")
    )
  )
)


# Define server logic  ----
server <- function(input, output) {
  output$selected_var <- renderText({ 
    paste("You have selected this:", input$selectvar1)})
  output$selected_range <-renderText({
    paste("You have selected the range:", input$slider1[1], "to", input$slider1[2])
  })
  output$df_output <- renderDataTable(mtcars)
}

shinyApp(ui = ui, server = server)





