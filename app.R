#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Hype over time"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("inputTime", "Time t",
                        min = 134,
                        max = 225,
                        step = 1,
                        value = 134, animate = animationOptions(200))
            
        ),

        # Show a jjplot of the generated distribution
        mainPanel(
           plotOutput("scatPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$scatPlot <- renderPlot({
        
        df <-  dplyr:::read_csv("https://raw.githubusercontent.com/ssinha98/mma_hype_time_map_data/main/tidied_fighter_map.csv")  %>% dplyr::filter(t == input$inputTime)
        # code for the graph being displayed itself
        ggplot() + geom_polygon(data = world, aes(x = long, y = lat, group = group), fill = "white") + geom_point(data = df, aes(long, lat, size = interest)) + geom_text(data =df, (aes(x = long, y = lat, label = fighter)),check_overlap = TRUE, size = 4) + theme(legend.position = "none") + theme(legend.position = "none") + labs(title=df$month)
        
        
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
