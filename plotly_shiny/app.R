library(plotly)
library(tidyr)
library(magrittr)
library(tidyverse)
library(wesanderson)

#built this chloropleth from this tutorial: https://plot.ly/r/choropleth-maps/
# give state boundaries a white border


ui <- fluidPage(
  #titlePanel("Number of People Tested for COVID-19 in the US"),
  mainPanel(plotlyOutput("plot"), width = 20),
  fluidRow("Data source from The COVID Tracking Project. Last updated on 3/19/2020."),
  fluidRow(uiOutput("url1"))
)



server <- function(input, output, session) {    
  df<- read.csv("https://covidtracking.com/api/states.csv")
  
  df$hover <- with(df, paste("Total tested in", state, '<br>',
                               "Confirmed cases:", positive, "<br>",
                               "Confirmed deaths:", death))

  
  output$plot <- renderPlotly({
    
    l <- list(color = toRGB("white"), width = 2)
    # specify some map projection/options
    g <- list(
      scope = 'usa',
      projection = list(type = 'albers usa'),
      showlakes = TRUE,
      lakecolor = toRGB('white')
    )
    
    plot_geo(df, locationmode = 'USA-states') %>%
      add_trace(
      z = ~total,  text = ~hover, locations = ~state,
        color = ~total, colors ="Blues"
      ) %>%
      colorbar(title = "Number of people tested") %>%
      layout(
        geo = g
      )
    
  })
  

  #data sources
  covid_url <- a("The COVID Tracking Project", href="https://covidtracking.com/data/")
  
  output$url1 <- renderUI({
    tagList("Data Source:", covid_url)
  })
  
  
}

shinyApp(ui, server)
