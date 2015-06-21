# project: Shiny Apps
# author: Guillaume Le Mener
# date: June, 20th 2015

library(shiny)
library(ggplot2)
library(datasets)

shinyServer(function(input, output, session) {
        
        # By declaring datasetInput as a reactive expression we ensure that:
        #
        #  1) It is only called when the inputs it depends on changes
        #  2) The computation and result are shared by all the callers 
        #          (it only executes a single time)
        #
        datasetInput <- reactive({
                switch(input$dataset,
                       "Cars" = mtcars,
                       "Diamonds" = diamonds,
                       "Iris"=iris)
        })
        
        # By declaring selectedVar as a reactive expression we ensure that:
        #
        #  1) It is only called when the inputs it depends on changes
        #  2) The computation and result are shared by all the callers 
        #          (it only executes a single time)
        #
        selectedVar <- reactive({
                dataset <- datasetInput()
                dataset[, c(input$variable[1], input$variable[2])]
        })
        
        # By declaring clusters as a reactive expression we ensure that:
        #
        #  1) It is only called when the inputs it depends on changes
        #  2) The computation and result are shared by all the callers 
        #          (it only executes a single time)
        #
        clusters <- reactive({
                kmeans(selectedVar(), input$clusters)
        })
           
        # Dynamic UI based on the Dataset selected in the first place,
        # so the end user can select the variables of choices for analysis
        # That's pretty cool since the server side needs to know the dataset,
        # but the UI needs to list the variables in the dataset via names()
        output$ui_variable <- renderUI({
                dataset <- datasetInput()
                selectInput("variable", "Select at least 2 variables:",
                            choices = names(dataset), multiple=TRUE
                )               
        })
        
        # We only calculate the Kmeans when the button 'go' is pressed
        # for that we use the eventReactive function and as soon as the button is pressed
        # we evaluate the results based on the current state of dataset and variables selected
        newplot <- eventReactive(input$go, {
                par(mar = c(5.1, 4.1, 3, 1))
                plot(selectedVar(),
                     col = clusters()$cluster,
                     pch = 20, cex = 3, main="Cluster analysis")
                points(clusters()$centers, pch = 4, cex = 4, lwd = 4)                 
        })       
        
        # We render ONLY if there is an active selection of 2 variables at least
        # If so, we boxplot the results.
        output$plot <- renderPlot({
                dataset <- datasetInput()
                if(is.null(input$variable)) return(NULL)
                if(!is.na(input$variable[1]) & !is.na(input$variable[2])) {
                        boxplot(dataset[,input$variable[2]]~as.factor(dataset[,input$variable[1]]),col="blue",ylab=input$variable[2],xlab=input$variable[1],main="Cross analysis")
                }    
        })
        
        # This shows the summary for each variables selected
        output$feedback <- renderPrint({
                dataset <- datasetInput()
                if(!is.null(input$variable)) return(summary(dataset[,input$variable]))
                else return("Select at least one variable to show a summary.")
                
        })
        # We output the graph of the Kmeans here based on the newplot()
        # newplot() depends on the button go to be pressed, so it's reactive and only evaluated when pressed
        output$model <- renderPlot({
                if(is.null(input$variable)) return(NULL)
                if(!is.na(input$variable[1]) & !is.na(input$variable[2])) { newplot() }
        })
})
