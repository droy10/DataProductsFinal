library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Horsepower Confidence Interval"),

    sidebarLayout(
        sidebarPanel(
            selectInput("ConfLevel", "Confidence Interval", choices=c(80, 90, 95, 99)),
            submitButton("Submit")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3(textOutput("text")),
            verbatimTextOutput("code"),
            plotOutput("plot1")
        )
    )
))
