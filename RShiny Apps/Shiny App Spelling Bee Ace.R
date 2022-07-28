#' @TITLE: Shiny App Spelling Bee Ace
#' @DESCRIPTION: Shiny App to provide answers to the Spelling B of the day

library(shiny)
library(dplyr)
library(stringr)
library(data.table)

words<-fread("data/Collins Scrabble Words (2019).txt")
colnames(words)<-"Word"

# Define UI ----

ui <- fluidPage(
  titlePanel("Spelling Bee Ace",
             img(src="bee.png", height = 180, width = 180)
             ),
  sidebarLayout(
    sidebarPanel(textInput("lettertext", h4("Letters"), value = "hvnaelc"),
                 textInput("centertext", h4("Center Letter"), value="n"),
                 numericInput("worddisplaycount", h4("Number of Words to Display"), value = 10)
      
    ),
    mainPanel(h4("Pangram Words"),
              textOutput("pangrams_out"),
              br(),
              br(),
              br(),
              br(),
              h4("Other Words"),
              textOutput("valid_words_out")
      
    )
  )
)

# Define server logic  ----
server <- function(input, output) {
  
  valid_words<-reactive({
    valid_letters<-input$lettertext
    center_letter<-input$centertext
    
    valid_letter_vector<-toupper(c(str_split_fixed(valid_letters, "", 7)))
    invalid_letter_vector<-LETTERS[LETTERS %notin% valid_letter_vector]
    
    invalid_letter_lookup<-paste0(invalid_letter_vector, collapse ="")
    invalid_letter_lookup<-paste0("[", invalid_letter_lookup, "]")
    
    valid.words<-words %>%
      mutate(Contains_Invalid_Letter = str_detect(Word, invalid_letter_lookup)) %>%
      filter(Contains_Invalid_Letter==F,
             nchar(Word)>3,
             str_detect(Word, toupper(center_letter))) %>%
      arrange(desc(nchar(Word))) %>%
      select(-Contains_Invalid_Letter)
    
    valid.words.string<-valid.words%>%
      slice(1:input$worddisplaycount) %>%
      paste(Word, sep=",")
    
    return(valid.words.string)
  })
  
  pangrams<-reactive({
    valid_letters<-input$lettertext
    center_letter<-input$centertext
    
    valid_letter_vector<-toupper(c(str_split_fixed(valid_letters, "", 7)))
    invalid_letter_vector<-LETTERS[LETTERS %notin% valid_letter_vector]
    
    invalid_letter_lookup<-paste0(invalid_letter_vector, collapse ="")
    invalid_letter_lookup<-paste0("[", invalid_letter_lookup, "]")
    
    valid.words<-words %>%
      mutate(Contains_Invalid_Letter = str_detect(Word, invalid_letter_lookup)) %>%
      filter(Contains_Invalid_Letter==F,
             nchar(Word)>3,
             str_detect(Word, toupper(center_letter))) %>%
      arrange(desc(nchar(Word))) %>%
      select(-Contains_Invalid_Letter)
    
    valid.words.string<-valid.words%>%
      slice(1:input$worddisplaycount) %>%
      paste(Word, sep=",")
    
    pangrams<-valid.words %>%
      filter(str_detect(Word, valid_letter_vector[1]),
             str_detect(Word, valid_letter_vector[2]),
             str_detect(Word, valid_letter_vector[3]),
             str_detect(Word, valid_letter_vector[4]),
             str_detect(Word, valid_letter_vector[5]),
             str_detect(Word, valid_letter_vector[6]),
             str_detect(Word, valid_letter_vector[7]))
    
    pangrams_string<-paste(pangrams, sep=",")
    
    return(pangrams_string)
  })

  
  ##### OUTPUT #####
  #' Pulls out pangrams
  output$pangrams_out<-renderText(print(pangrams))

  #' Pulls out top all other words

  output$valid_words_out<-renderText(print(valid_words))
    

  
}

shinyApp(ui = ui, server = server)
