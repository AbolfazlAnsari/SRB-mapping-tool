#helpers.installPackages("leaflet","maps","dplyr","shiny", "sf","shinydashboard","ggplot2")


#my_packages = c("leaflet","maps","dplyr","shiny", "sf","shinydashboard","ggplot2")

path<-getwd()

lib<-paste(path,'/packages',sep="")

repos<-'http://cran.us.r-project.org'

install.packages("devtools",lib=lib,repos=repos,dependencies=TRUE)

install.packages("shinydashboard",lib=lib,repos=repos,dependencies=TRUE)

install.packages("shiny",lib=lib,repos=repos,dependencies=TRUE)

install.packages("leaflet",lib=lib,repos=repos,dependencies=TRUE)

install.packages("maps",lib=lib,repos=repos,dependencies=TRUE)

.libPaths(lib)

library(shiny)

library(shinydashboard)
