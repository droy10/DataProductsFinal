
library(shiny)

shinyServer(function(input, output) {

    model1 <- lm(hp ~ mpg, data = mtcars)
    newx <- seq(10, 35, length.out=100)

    model1pred <- reactive({
        predict(model1, newdata = data.frame(mpg = newx), interval = 'confidence',
                level = as.numeric(input$ConfLevel)/100)
    })

    output$text <- renderText({
        "Instructions: This graph displays the linear model for the mtcars data (a prediction of horsepower based on MPG). The red line represents the regression line, and the grey area the confidence interval, that can be modified with the input field, and pushing the button"
    })

    output$plot1 <- renderPlot({

        plot(mtcars$mpg, mtcars$hp, xlab = "Miles per Gallon",
             ylab = "Horsepower", bty = "n", pch = 16,
             xlim = c(10, 35), ylim = c(50, 350))
        # add fill
        polygon(x= c(rev(newx), newx), y = c(rev(model1pred()[ ,3]), model1pred()[ ,2]), col = 'grey80', border = NA)
        # model
        abline(model1, col = "red", lwd = 2)
        # intervals
        lines(newx, model1pred()[ ,3], lty = 'dashed', col = 'red')
        lines(newx, model1pred()[ ,2], lty = 'dashed', col = 'red')

        legend(20, 340, c("Linear Regression Prediction"), pch = 16,
               col = c("red"), bty = "n", cex = 1.2)
    })
})
