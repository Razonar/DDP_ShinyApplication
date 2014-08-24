library(shiny); library(ggplot2); library(grid);


# Define server logic for random distribution application
shinyServer(function(input, output) {

    data <- reactive({   # generate the requested distribution.
        dist <- switch(input$dist,
                       norm = rnorm,
                       unif = runif,
                       lnorm = rlnorm,
                       exp = rexp,
                       rnorm)
        dist(input$n)
    })

    output$text <- renderPrint({ # Generate HTML
        doc <- tags$html(
            tags$body(
                h3('Summary'),
                br(),
                p('On the left Panel you can choose a distribution and the number of trials to see some basic commands on the above tabs.'
                )
            )
        )
        cat(as.character(doc))
    })

    output$plot <- renderPlot({    # Generate a plot
        dist <- input$dist
        n <- input$n
        tit <- paste('Plot of r', dist, '(', n, ')', sep='')
        qp1 <- qplot(data(), main=tit)
        print(qp1)
    })

    output$summ <- renderPrint({   # Generate a summary
        summary(data())
    })

    output$table <- renderTable({  # Generate table
        data.frame(x=data())
    })

})
