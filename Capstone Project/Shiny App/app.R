# Data Science in R - Capstone Project
# Shiny Application app.R
# Ken Wood
# Date: 11/14/20

library(shiny)
library(quanteda)
library(data.table)
library(dplyr)
library(stringr)
library(tidyverse)

ui <- shinyUI(navbarPage("Capstone Project in R - Shiny Application (Prepared by Ken Wood)",
               tabPanel("Overview",
                        h2("Overview"),
                        h3("Natural Language Processing (NLP) using the Katz Back-off Algorithm"),
                        helpText("The goal of this project is to develop a Shiny app for our NLP word prediction algorithm
                        that is easy and convenient to use."),
                        h3("The training corpus..."),
                        helpText("...consists of three files:  `en_USblogs.text`, `en_USnews.text` and `en_USblogs.text`
                        which each contain a large number of blogs, news and tweets, respectively, to train the word prediction algorithm."),
                        h3("The NLP word prediction algorithm..."),
                        helpText("...is based on the Katz Backoff Model, a generative n-gram language routine 
                                 that estimates the conditional probability of a word given its history in the n-gram. 
                                 It accomplishes this estimation by backing off through progressively shorter history models 
                                 under certain conditions. By doing so, the model with the most reliable information about a 
                                 given history is used to provide the better results.")
                        ),
               tabPanel("Training Corpus Features",
                        h2("Training Corpus Features"),
                        helpText(" The data are from a corpus called HC Corpora. The corpora are collected 
                                 from publicly available sources by a web crawler."),
                        helpText("Here are some summary statistics for each of the text files:"),
                        h3("en_USblogs.txt"),
                        helpText("Number of entries: 899,288"),
                        helpText("Number of sentences: 2,362,935"),
                        helpText("Number of tokens: 37,339,814"),
                        h3("en_USnews.txt"),
                        helpText("Number of entries: 1,010,242"),
                        helpText("Number of sentences: 1,992,553"),
                        helpText("Number of tokens: 34,376,642"),
                        h3("en_UStwitter.txt"),
                        helpText("Number of entries: 2,360,148"),
                        helpText("Number of sentences: 3,754,216"),
                        helpText("Number of tokens: 30,162,656"),
                        h3("Sampling for the Training Corpus"),
                        helpText("The training data set for the Katz Backoff Model was compiled 
                          using 10% each of the text files. Often, relatively few randomly 
                          selected rows or chunks need to be included to get an accurate 
                          approximation to results that would be obtained using all the data. 
                          We might want to create a separate sub-sample dataset by reading in 
                          a random subset of the original data and writing it out to a separate file. 
                          That way, we can store the sample and not have to recreate it every time.")
                        ),
               tabPanel("Word Predictor",
                        fluidPage(
                            titlePanel("Word Predictor"),
                            sidebarLayout(
                                sidebarPanel(
                                    textInput("user_input", "Enter in two leading words and then press 'Predict':"),
                                    submitButton("Predict"),
                                    br(),
                                    h5("You entered the following leading words:", style = "color:blue"),
                                    div(textOutput("Original"), style = "color:black"),
                                    br(), 
                                    h5("The tri-gram with the highest probability is:", style = "color:green"), 
                                    div(DT::dataTableOutput("BestGuess"), style = "color:green"),
                                            ),
                
                                mainPanel(
                                    tabsetPanel(type = "tabs", 
                                                tabPanel("Top 5 Predictions",DT::dataTableOutput("word_list")),
                                                tabPanel("Column Chart")
                                    )
                                )
                            )
                        )
               ),
              
               tabPanel("Github repository",
                        a(href="https://github.com/ROARMarketingConcepts/Data-Science-with-R-Specialization/tree/master/Capstone%20Project/Shiny%20App",
                          "Project Files on Github"),
               )
    )
)


server <- shinyServer(function(input, output) {
    
    output$Original <- renderText({
      input_str <- str_split(input$user_input," ",simplify=TRUE)
      if (length(input_str) != 2) {
          OriginalTextInput <- "Processing..."
      } else {
          OriginalTextInput <- input$user_input  
              }        
        return(OriginalTextInput) 
        })
    
    # Re-format the user input.

    output$bigPre <- renderText({
      input_str <- str_split(input$user_input," ",simplify=TRUE)
      if (length(input_str) == 2) {
        Translated_Input <- paste(input_str[1],"_",input_str[2],sep="")
      } else {
        Translated_Input <- "Processing..."
      }
      return(Translated_Input) 
    })
    
    
    # Get the best guess for the third word...
    
    output$BestGuess <- DT::renderDataTable({ 
      input_str <- str_split(input$user_input," ",simplify=TRUE)
      if (length(input_str) == 2) {
        Translated_Input <- paste(input_str[1],"_",input_str[2],sep="")
      } else {
        Translated_Input <- "Processing..."
      }
      word_list <- predict_word(Translated_Input,unigrs,bigrs,trigrs)
      return(DT::datatable(word_list[1,],options=list(dom="t")))
    })
    
    # Get a list of third word predictions...
    
    output$word_list <- DT::renderDataTable({ 
      input_str <- str_split(input$user_input," ",simplify=TRUE)
      if (length(input_str) == 2) {
        Translated_Input <- paste(input_str[1],"_",input_str[2],sep="")
      } else {
        Translated_Input <- "Processing..."
      }
      word_list <- predict_word(Translated_Input,unigrs,bigrs,trigrs)
      # return(word_list)
      return(DT::datatable(word_list[1:5,],options=list(dom="t")))
    }) 

    # Render a barplot
    # output$ColumnChart <- renderPlot({
    #  barplot(word_list$prob,main="Top 5 Tri-gram Probabilities",
    #        ylab="Probability",
    #        xlab="Tri-Gram")
    #})

})

# Create Shiny object
shinyApp(ui = ui, server = server)
