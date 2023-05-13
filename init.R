#helpers.installPackages("leaflet","maps","dplyr","shiny", "sf","shinydashboard","ggplot2")


install.packages("packages/dplyr_1.0.7.tar.gz", repos=NULL, type="source")

install.packages("packages/sp_1.6-0.tar.gz", repos=NULL, type="source")

install.packages("packages/raster_1.0.7.tar.gz", repos=NULL, type="source")

install.packages("packages/leaflet_2.1.2.tar.gz", repos=NULL, type="source")

install.packages("packages/maps_3.4.1.tar.gz", repos=NULL, type="source")

install.packages("packages/shiny_1.7.1.tar.gz", repos=NULL, type="source")

install.packages("packages/shinydashboard_0.7.2.tar.gz", repos=NULL, type="source")

library(dplyr)
library(sp)
library(raster)
library(leaflet)
library(maps)
library(shiny)
library(shinydashboard)

