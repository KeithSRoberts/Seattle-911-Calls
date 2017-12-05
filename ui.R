## Team Mango - Info 201
## Matthew, Min, Deanna, Keith
## R script for UI of the Shiny App

ui <- fluidPage(theme = shinytheme("sandstone"),
  #Page Title
  navbarPage("Seattle Area 911 Calls",
             #Overview Tab <--- Assigned to Deanna
             #Details on what to include in our overview are in the README
             tabPanel("Overview",
              titlePanel("911 Calls in Seattle - About the Project"),
              #This Tab is linked to our README.md, so we only need to modify the README
              includeMarkdown("README.md")
             ),
             
             #Map of Calls Tab <--- Assigned to Keith
             #Widgets to include:
             # - Search by address / SidePanel
             # - Filter by crime / Side Panel
             #Main Page:
             # - Include map that plots the crimes from the data set
             tabPanel("Map of Calls",
              titlePanel("Visual Map of Calls In Seattle"),
              sidebarLayout(
                sidebarPanel(
                 # Put search by address widget here
                 textInput("search", h3("Search Map"), value = "Enter Address"),
                 actionButton("go", "Search"),
                 # Put filter by crime widget here  
                 selectInput("crime", label = h3("Choose Crime"), choices = sort(unique(callData$`Event Clearance Group`)), selected = "ACCIDENT INVESTIGATION"),
                 # Year Filter
                 selectInput("years", label = h3("Select Year"), choices = c("ALL" = "8", "2010" = "0", "2011" = "1", "2012" = "2", "2013" = "3", "2014" = "4", "2015" = "5", "2016" = "6", "2017"= "7"))
               ),
               mainPanel(
                 # Put Leaflet Map here
                 h3("Map of 911 Calls"),
                 leafletOutput("map", height = "400px")
               )
              )
             ),
             
             #Calls Overtime Graph Tab <--- Assigned to Matthew
             #Widgets:
             # - Radio Buttons to Select Year / SidePanel
             # - Dropdown Menu to select Crime type / SidePanel
             #Main Panel:
             # - Graph of frequency in crime for each month of selected year and crime type
             tabPanel("Calls Overtime",
              titlePanel("Visualization of 911 Calls Overtime"),        
              sidebarLayout(
                sidebarPanel(
                  #Radio button widget here
                  radioButtons("year", "Select Year",
                               c("2012"="p", "2013"="l")
                  )
                  #Dropdown crime select here
                ),
                mainPanel(
                  #Crime Graph here          
               )
              )
             ),
             
             #Calls by Crime Tab <--- Assigned to Min
             #Widgets: 
             # - Dropdown to select month for graph
             #MainPanel:
             # - Include a graph showing frequency of crimes for chosen month
             tabPanel("Calls by Crime",
              titlePanel("Calls by Crime in the Seattle Area"),
              sidebarLayout(
               sidebarPanel(
                 #Dropdown month select widget here
               ),
               mainPanel(
                  #Graph of frequency -> crime here   
               )
              )
             )
  )
)