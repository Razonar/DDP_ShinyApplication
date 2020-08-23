#
# Shiny APP server and ui
# Alvaro.

library(shiny); library(ggplot2); library(grid);


# Define UI for application that draws a histogram
ui <- fluidPage(

    titlePanel("Examining some few distributions"),

    # Sidebar with controls
    sidebarLayout(
        sidebarPanel(
            radioButtons("dist", "Distribution type:",
                         c("Normal" = "norm",
                           "Uniform" = "unif",
                           "Log-normal" = "lnorm",
                           "Exponential" = "exp")),
            br(""),
            sliderInput("n",
                        "Number of observations:",
                        value = 500,
                        min = 1,
                        max = 1000),
            br("Alvaro Diaz Falconi, August 2020")
        ),
        # Show a tabset
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Text", htmlOutput("text")),
                        tabPanel("Plot", plotOutput("plot")),
                        tabPanel("Summary", verbatimTextOutput("summ")),
                        tabPanel("Table", tableOutput("table"))
            )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

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

}

# Run the application
shinyApp(ui = ui, server = server)

