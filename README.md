
Authors: Keith, Min, Matthew, Deanna

This informatics (INFO 201) project is based off of a dataset containing records of 911 calls in the Seattle area from 2010 to 2017. Each record of the dataset offers insights about a 911 call made, including data such as the crime type, the call location, the date and time the call was made, etc.  The dataset was collected and published by the __City of Seattle__ and can be found on their government website [here.](https://data.seattle.gov/Public-Safety/Seattle-Police-Department-911-Incident-Response/3k2p-39jp)

## Analysis

When approaching this dataset, we cultivated a few questions to answer with our visualizations that could be of use to the general population of the Seattle area. Our questions include:

 1. In what areas are certain crimes more frequent, and how does this differ each year?
 2. Are there patterns in frequency of crime in the span of a year (2010-2017)?
 3. Which type of crimes are more frequent in the Seattle Area?

We chose to answer these questions with a series of visualizations, which will be briefly described below. In summary, we found that certain areas do tend to have higher frequency in crimes, these areas include: Downtown Queen Anne (Downtown Seattle), and areas around Rainier Avenue (Columbia City Area). The crime density in these areas were fairly consistent over each year, and could be attributed to higher population density in those areas. Over the span of a year, there tends to be more crime calls in the later months of the year (November - December), but varies greatly from crime type. Lastly, the majority of calls often were regarding minor crimes such as suspicious circumstances, traffic offenses, or minor disturbances. Each of these questions are answered more effectively and in depth by interacting with our visualizations on the other tabs.

## Visualizations

In this app you can find three different interactive visualizations of the dataset as follows:

 1. A map plotting the location of 911 calls in the Seattle area, including widgets to show markers by crime type and year of crime. The map also has a search box useful for observing calls in specific locations.
 2. A plot chart that describes the frequency of calls over a yearly span that includes menus to select the year and crime type of observations.
 3. A bar graph and table that identify the frequencies of each crime of a selected year and selected month.
 
These visualizations were all made in R and utilized libraries/packages including ggplot2, leaflet, and shiny to display the visualizations. The code for these visualizations can be found on our [Github](https://github.com/KeithSRoberts/team-mango-final). 

Link to our Shiny app (the page you are on!) [here](https://keithroberts.shinyapps.io/team-mango-final/)
