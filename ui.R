library(shiny)

# Define UI for random distribution application
shinyUI(fluidPage(

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
))

