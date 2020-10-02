#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)

shinyUI(
    navbarPage("Developing Data Products in R - Shiny Application",
               tabPanel("Overview",
                        h2("Overview"),
                        h3("Which home features most impact sale price?"),
                        helpText("We are working as an analyst at an investment bank. The team that we're working with wants 
                                 to understand how it should allocate dollars earmarked for investment into mortgage-backed securities. 
                                 They've asked us to look into the factors that drive home prices. This data originally comes from Kaggle."),
                        h3("The dataset..."),
                        helpText("...is a dataframe with 1460 observations on 81 features. We will only
                          look at a subset of these features. The raw data can be downloaded here:"),
                        
                        a(href="https://drive.google.com/file/d/15QsjfaynQheCDPm8RtC-0ISg03Iqsn3W/view?usp=sharing","housingdata.csv")
               ),
               tabPanel("Data Set Features",
                        h2("Data Set Features"),
                        helpText("Ask a home buyer to describe their dream house, 
                        and they probably won't begin with the height of the basement ceiling 
                        or the proximity to an east-west railroad. But this playground competition's
                        dataset proves that much more influences price negotiations than the number 
                        of bedrooms or a white-picket fence."),
                        helpText("With 79 explanatory variables describing (almost) every aspect 
                                 of residential homes in Ames, Iowa, this dataset challenges us
                                 to predict the final price of each home."),
                        h3("Features of Interest"),
                        p("We will focus on 10 features in the data set:"),
                        
                        helpText("  [,  5]   'lotarea':  Lot size in square feet"),
                        helpText("  [, 17]	 'housestyle':	 House Style"),
                        helpText("  [, 19]	 'overallcond':	 Overall Condition (1= Poor, 9= Excellent)"),
                        helpText("  [, 40]	 'heating':  Heating"),	
                        helpText("  [, 42]	 'centralair': Central Air Conditioning"),
                        helpText("  [, 47]	 'grlivarea': Above Grade Living Area"),
                        helpText("  [, 50]	 'fullbath': Number of Full Baths"),
                        helpText("  [, 51]	 'halfbath': Number of Half Baths"),
                        helpText("  [, 52]	 'bedroomabvgr: Number of Bedrooms"),
                        helpText("  [, 55]	 'totrmsabvgrd': Total Number of Rooms"),
                        helpText("  [, 81]	 'saleprice': Sale Price"),
                        
                        h3("Acknowledgments"),
                        
                        helpText("The Ames Housing dataset was compiled by Dean De Cock for 
                          use in data science education. It's an incredible alternative 
                          for data scientists looking for a modernized and expanded version 
                          of the often cited Boston Housing dataset.")
               ),
               tabPanel("Analysis",
                        fluidPage(
                            titlePanel("Let's explore how various home features impact the sales price"),
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
                        a("https://github.com/ludovicbenistant?tab=repositories"),
               )
    )
)