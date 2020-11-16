# title: "Data Science with R - Capstone Project"
# author: "Ken Wood"
# date: "11/14/2020"
# filename: server.R

library(shiny)
library(quanteda)
library(data.table)
library(stringr)
library(tidyverse)
library(dplyr)

shinyServer(function(input, output) {
  
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
  
  
})