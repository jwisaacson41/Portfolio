#' @TITLE: Shiny App Practice 03 - Control Widgets
#' @DESCRIPTION: https://shiny.rstudio.com/tutorial/written-tutorial/lesson2/

library(shiny)

# Define UI ----

ui <- fluidPage(
  titlePanel("censusVis"),
  sidebarLayout(
    sidebarPanel(
      helpText("create demographic maps with information from the 2010 US Census"),
      selectInput("selectinput1", "Choose a variable to display",
                  choices = list("Percent White" = 1,
                                 "Percent Black" = 2,
                                 "Percent Hispanic" = 3,
                                 "Percent Asian" = 4)),
      sliderInput("slider1", "Range of Interest:",
                  min=0, max=100, value=c(0, 100))
    ),
    mainPanel(
    )
  )
)


# Define server logic  ----
server <- function(input, output) {
  
}

shinyApp(ui = ui, server = server)
