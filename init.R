#helpers.installPackages("leaflet","maps","dplyr","shiny", "sf","shinydashboard","ggplot2")

lib<-"~/packages"

repos<-"https://cran.r-project.org/"

install.packages("dplyr", repos=repos, lib=lib)

install.packages("sp", repos=repos, lib=lib)

install.packages("raster", repos=repos, lib=lib)

install.packages("leaflet", repos=repos, lib=lib)

install.packages("maps", repos=repos, lib=lib)

install.packages("shiny", repos=repos, lib=lib)

install.packages("shinydashboard", repos=repos, lib=lib)


.libPaths("~/packages")

library(dplyr)

library(sp)

#library(raster)

library(leaflet)

library(maps)

library(shiny)

library(shinydashboard)

