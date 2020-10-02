#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# setwd("~/Desktop/Data Science with R/Developing Data Products/Week 4 Assignment")
housingdata = read.csv("housingdata.csv")

# Now we need to factor the categorical features we will be using...

housingdata$housestyle <- as.factor(housingdata$housestyle)
housingdata$heating <- as.factor(housingdata$heating)
housingdata$centralair <- as.factor(housingdata$centralair)

shinyServer(function(input, output) {
    
    formulaText <- reactive({
        paste("saleprice ~", input$feature)
    })
    
    formulaTextPoint <- reactive({
        paste("saleprice ~", "as.integer(", input$feature, ")")
    })
    
    fit <- reactive({
        lm(as.formula(formulaTextPoint()), data=housingdata)
    })
    
    output$caption <- renderText({
        formulaText()
    })
    
    output$salepriceBoxPlot <- renderPlot({
        boxplot(as.formula(formulaText()), 
                data = housingdata,ylab="Sale Price ($)",
                outline = input$outliers)
    })
    
    output$fit <- renderPrint({
        summary(fit())
    })
    
    output$salepricePlot <- renderPlot({
        with(housingdata, {
            plot(as.formula(formulaTextPoint()),ylab = "Sale Price ($)")
            abline(fit(), col=2)
        })
    })
    
})