
my_packages<-c('leaflet','maps','dplyr','shiny', 'sf','shinydashboard','ggplot2')

install.packages(packages)


install_if_missing<-function(p){
if(p %in% rownames(installed.packages())==FALSE){install.packages(p)}

}

invisible(sapply(my_packages, install_if_missing))


library(leaflet)
library(maps)
library(dplyr)
library(shiny)
library(sf)
library(shinydashboard)
library(ggplot2)



ui <- dashboardPage(
  
  dashboardHeader(title = "Susquehanna River Basin Interactive Mapping Tool"),
  
  dashboardSidebar(
    
    selectInput("variable", label = "Select:", choices = c("Water", "Flood events", "Organic N", "Organic P",
                                                              
                                                              "NO3","NO2","NH4","Total N","Mineral P","Total P", "Sediment"  ))
    
    
  ),
  
  dashboardBody(
    
              leafletOutput(outputId = "map"),
                
               textOutput("text"),
                
              box(width = 6, height =4,   plotOutput(outputId = "local")),
                
               box(width =6,height= 4, plotOutput(outputId = "global")) 
                
  )
  
  
)
