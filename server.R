## Team Mango - Info 201
## Matthew, Min, Deanna, Keith
## R script for server of the Shiny App
library("shiny")
library("dplyr")
library("leaflet")
library("shinythemes")
library("maps")
library('tidyr')
library('bit64')
library(ggplot2)
library(data.table)

server <- function(input, output) {
  #callData is the original csv, unzipped from bz2 format
  callData <- fread(sprintf("bzcat %s | tr -d '\\000'", "data/Seattle_Police_Department_911_Incident_Response.csv.bz2"))
  
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
  
  ##Min's server function
  #reactive function for filtering data using input values (month and year)
  crime.group <- reactive({
    #remove time from date column 
    if (callData[1,] %>% select(`Event Clearance Date`)== format('%m/%d/%Y %H:%M')) {
      callData$`Event Clearance Date` <- format(as.POSIXct(callData$`Event Clearance Date`, format = '%m/%d/%Y %H:%M'), format = '%m/%d/%Y')
    }
    #filter month and year count frequency of each crime type 
    crime.type <- callData %>% 
      filter(format(as.Date(callData$`Event Clearance Date`, "%m/%d/%Y"), "%m") == input$month &
               format(as.Date(callData$`Event Clearance Date`, "%m/%d/%Y"), "%Y") == input$year) %>%
      group_by(`Event Clearance SubGroup`) %>%
      summarize(frequency = n())
    
  })
  #display histogram
  output$hist <- renderPlot({
    ggplot(crime.group(), aes(x = `Event Clearance SubGroup`, y = frequency)) +
      geom_bar(stat = "identity") + labs(x = "Crime Groups", y = "Crime Frequency") + 
      ggtitle(paste0(input$month, "/",input$year, " crime type frequencies")) + coord_flip()
  })
  #display stat table
  output$stat <- renderTable({
    crime.group() %>% arrange(desc(frequency))
  })
  output$CrimePlot <- renderPlot({
    crime_data <- separate(callData, `Event Clearance Date`, c('Date', 'Time'), sep = ' ') %>%
      separate(`Date`, c('Month', 'Day', 'Year'), sep = '/')
    crime_data <- rename(crime_data, Type = `Event Clearance Group`)  
    data <- filter(crime_data, `Year` == input$YearInput, `Type` == input$CrimeTypeInput)
    monthly <-  
      group_by(data,`Month`) %>% 
      summarize(Frequency = n())
    monthly.chart <- ggplot(data = monthly, mapping = aes(x = Month, y = Frequency )) + 
      geom_point() +
      ggtitle('Crimes Per Month')
    print(monthly.chart)
    
  })
}


