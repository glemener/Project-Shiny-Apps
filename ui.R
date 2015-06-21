# project: Shiny Apps
# author: Guillaume Le Mener
# date: June, 20th 2015

shinyUI(navbarPage("myApps",
                   tabPanel("Exploration",
                            sidebarLayout(
                                    sidebarPanel(
                                            helpText("Help: select first your dataset and at least 2 variables",
                                                     "then select your cluster size and press the button 'Evaluate K-means' to grpah the cluster.",
                                                     "It's a very easy to use application with dynamic UI based on the dataset selected.",
                                                     "You can add more dataset by updating both the ui.R and server.R scripts."),
                                            hr(),
                                            radioButtons("dataset", label="Select the dataset:", choices=c("Cars","Diamonds","Iris")),
                                            uiOutput("ui_variable"),
                                            hr(),
                                            numericInput('clusters', 'Cluster count:', 3, min = 1, max = 9),
                                            actionButton("go", "Evaluate K-means"),
                                            hr(),
                                            helpText("Version: 1.0 of June 20th 2015 by GLM.") 
                                    ),
                                    mainPanel(
                                            verbatimTextOutput("feedback"),
                                            plotOutput("plot"),
                                            plotOutput("model")
                                    ) 
                            )
                   )
)
)