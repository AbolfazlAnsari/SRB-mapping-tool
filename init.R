library(leaflet)
library(maps)
library(dplyr)
library(shiny)
library(sf)
library(shinydashboard)
library(ggplot2)




rm(list=ls())

sf_use_s2(FALSE)




# For original NHD catchment dataset --------------------------------------

# NHD_catchment<- subset(NHD_catchment,cor_id %in% flowline$core_id) only include streams catchments

# d<-st_make_valid(NHD_catchment) # correction for shapefile




# load datasets -----------------------------------------------------------

# warning: heck the dataset to haven::wgs1984 projection


Rivers <- st_read("Rivers.shp") # counties


Chemung <- st_read("Chemung.shp")  # SRB boundary


#major_wshed<-st_read("C:/Users/rashi/OneDrive/Desktop/visualization/main_database/major_wshed.shp")


catchment<-st_read("catchments.shp")






flowline<-readRDS("flowline.rds")


floodplain<-st_read("floodplain.shp") 



local_df<-readRDS("vis_data_all_local.rds")


global_df<-readRDS("vis_data_all_global.rds")



# Function ----------------------------------------------------------------


region_data<-function(shapefile,markers){  ###
  
  #removeNotification(id="region_error",session=getDefaultReactiveDomain())
  
  dat<-data.frame(Longitude=markers$lon,Latitude=markers$lat,names=c("points"))
  
  dat<-sf::st_as_sf(dat,coords = c("Longitude","Latitude"))
  
  sf::st_crs(dat)<- sf::st_crs(shapefile)
  
  
  
  return(as.data.frame(shapefile)[which(sapply(sf::st_intersects(shapefile,dat),function(z) if (length(z)==0) NA_integer_ 
                                               
                                               else z[1])==1),])
  
  
}  ### end of function





Upstream<-function(id,flowline){  ###
  
  
  up_node<-flowline$from_cor_id[flowline$core_id==id]
  
  
  set<-c(which(flowline$core_id==id))
  
  n<-c(1)
  
  
  while(length(n)>0){
    
    n<-which(flowline$to_cor_id %in% up_node)
    
    set<-c(set,n)
    
    up_node<-flowline$from_cor_id[n]
    
    
  }
  
  set_id<-unique(flowline$core_id[set])
  
  #set_id<-setdiff(set_id,id)
  
  return(set_id)
  
} ###  end of function







# Shiny body --------------------------------------------------------------

