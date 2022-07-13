#' @TITLE: Shiny App Spelling Bee Ace
#' @DESCRIPTION: Shiny App to provide answers to the Spelling B of the day

library(shiny)

# Define UI ----

ui <- fluidPage(
  titlePanel("Spelling Bee Ace",
             img(src="bee.png", height = 180, width = 180)
             ),
  sidebarLayout(
    sidebarPanel(textInput("lettertext", h4("Letters")),
                 textInput("centertext", h4("Center Letter"))
      
    ),
    mainPanel(h4("Pangram Words"),
              textOutput("pangrams"),
              br(),
              br(),
              br(),
              br(),
              h4("Other Words")
      
    )
  )
)

# Define server logic  ----
server <- function(input, output) {
  output$pangrams<-renderText({toupper(input$lettertext)})
}

shinyApp(ui = ui, server = server)
