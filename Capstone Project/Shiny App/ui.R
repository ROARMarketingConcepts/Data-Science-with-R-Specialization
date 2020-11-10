# Data Science in R - Capstone Project
# Ken Wood
# Date: 11/9/20

library(shiny)

shinyUI(
    navbarPage("Capstone Project in R - Shiny Application (Prepared by Ken Wood)",
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
                          using 10% each of the text files.To build the models we realize that we do not
                          need to load in and use all of the data. Often, relatively few randomly 
                          selected rows or chunks need to be included to get an accurate 
                          approximation to results that would be obtained using all the data. 
                          We might want to create a separate sub-sample dataset by reading in 
                          a random subset of the original data and writing it out to a separate file. 
                          That way, we can store the sample and not have to recreate it every time.")
               ),
               tabPanel("Word Predictor",
                        fluidPage(
                            titlePanel("Let's predict the trailing word for a 3-gram by inputting the first two words"),
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput("feature", "Feature:",
                                                c("Lot Area" = "lotarea",
                                                  "House Style" = "housestyle",
                                                  "Overall Condition (1 = Poor, 9 = Excellent)" = "overallcond",
                                                  "Above Grade Living Area" = "grlivarea",
                                                  "Number of Full Baths" = "fullbath",
                                                  "Number of Half Baths" = "halfbath",
                                                  "Number of Bedrooms" = "bedroomabvgr",
                                                  "Total Number of Rooms" = "totrmsabvgrd",
                                                  "Central Air Conditioning" = "centralair",
                                                  "Heating" = "heating"
                                                )),
                                    
                                    checkboxInput("outliers", "Show BoxPlot's outliers", FALSE)
                                ),
                                
                                mainPanel(
                                    h3(textOutput("caption")),
                                    
                                    tabsetPanel(type = "tabs", 
                                                tabPanel("BoxPlot", plotOutput("salepriceBoxPlot")),
                                                tabPanel("Regression model", 
                                                         plotOutput("salepricePlot"),
                                                         verbatimTextOutput("fit")
                                                )
                                    )
                                )
                            )
                        )
               ),
              
               tabPanel("Github repository",
                        a(href="https://github.com/ROARMarketingConcepts/Data-Science-with-R-Specialization/tree/master/Developing%20Data%20Products/Week%204%20Shiny%20Assignment",
                          "Project Files on Github"),
               )
    )
)