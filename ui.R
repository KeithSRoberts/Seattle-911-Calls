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
                                        selectInput(inputId = "YearInput", label = "Choose a Year:", 
                                                    choices = c('2010' = 10, 
                                                                '2011' = 11, 
                                                                '2012' = 12,
                                                                '2013' = 13,
                                                                "2014" = 14,
                                                                "2015" = 15,
                                                                "2016" = 16,
                                                                "2017" = 17),
                                                    selected = '2017'),
                                        selectInput(inputId= "CrimeTypeInput", label = "Select a crime:", 
                                                    choices = sort(unique(callData$`Event Clearance Group`)), selected = "ACCIDENT INVESTIGATION")
                                      ),
                                      mainPanel(
                                        plotOutput("CrimePlot")
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
                                        #Dropdown year and month select widget here
                                        selectInput("year", label = h3("Select Year"), 
                                                    choices = list("2010"= "2010", "2011"="2011","2012"="2012","2014"="2014",
                                                                   "2015"="2015", "2016"="2016", "2017"="2017"), selected = "2010"),
                                        selectInput("month", label = h3("Select Month"), 
                                                    choices = list("January" = "01", "Feburary" = "02", "March" = "03", "April" = "04",
                                                                   "May" ="05", "June"='6',"July"="07","August"='08',"September"='09',
                                                                   "October"='10', "November"='11',"December"='12'), selected = "July"),
                                        tableOutput("stat")
                                      ),
                                      mainPanel(
                                        #Graph of frequency -> crime here 
                                        plotOutput("hist")
                                      )
                                    )
                           )
                )
)
