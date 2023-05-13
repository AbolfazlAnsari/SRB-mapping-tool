my_packages<-c('leaflet','maps','dplyr','shiny', 'sf','shinydashboard','ggplot2')

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
