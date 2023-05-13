#helpers.installPackages("leaflet","maps","dplyr","shiny", "sf","shinydashboard","ggplot2")


my_packages = c("leaflet","maps","dplyr","shiny", "sf","shinydashboard","ggplot2")

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p, clean=TRUE, quiet=TRUE)
  }
}


library(dplyr)

library(sp)

#library(raster)

library(leaflet)

library(maps)

library(shiny)

library(shinydashboard)

