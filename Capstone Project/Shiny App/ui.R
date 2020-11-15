# title: "Data Science with R - Capstone Project"
# author: "Ken Wood"
# date: "11/14/2020"
# filename: ui.R


library(shiny)

shinyUI(navbarPage("Capstone Project in R - Shiny Application (Prepared by Ken Wood)",
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
