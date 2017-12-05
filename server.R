## Team Mango - Info 201
## Matthew, Min, Deanna, Keith
## R script for server of the Shiny App
library("shiny")
library("dplyr")
library("leaflet")
library("shinythemes")
library("maps")

server <- function(input, output) {
  #callData is the original csv
  callData <- fread("data/Seattle_Police_Department_911_Incident_Response.csv", header = TRUE)
  
  
  #Add your server functions here
  
  ## KEITH's SERVER FUNCTIONS
  #Reactive Function for filtering widgets
  crime.data <- reactive({
    df <- callData %>% filter(`Event Clearance Group` == input$crime)
    if (input$years >= 0 && input$years<= 7) {
      return(df %>% filter(substr(df$`Event Clearance Date`, 10, 10) == input$years))
    } 
    return(df)
  })
  #Map Display render fucntion
  output$map <- renderLeaflet({
    leaflet(crime.data()) %>% 
      setView(lng = -122.3351, lat = 47.6080, zoom = 10) %>%
      addTiles() %>%
      addMarkers(lng = ~Longitude, lat = ~Latitude, clusterOptions = markerClusterOptions())
  })
  #Observer function for searching an address
  observeEvent(input$go, {
      search <- filter(callData, grepl(input$search, `Hundred Block Location`))
      leafletProxy("map") %>%
        setView(lng = search$Longitude[1], lat = search$Latitude[1], zoom = 15)
  })
  
}