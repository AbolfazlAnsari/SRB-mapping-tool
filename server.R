server<-function(input,output){
  
  
  output$map<-renderLeaflet({
    
    
    
    leaflet() %>%
      
      setView(lng=-77.86,lat=40.79,zoom=6) %>%
      
      addProviderTiles('Esri.WorldImagery') # %>%
      
      # addTiles(urlTemplate = "https://mts1.google.com/vt/lyrs=s&hl=en&src=app&x={x}&y={y}&z={z}&s=G", attribution = 'Google')
      
      # addTiles()
      
     # addPolygons(data=SRB,color='black')%>%
      
     # addPolygons(data=Counties,color='black',weight = 1)%>%
      
     # addMarkers(lng=-77.86,lat=40.79,options = markerOptions(draggable = TRUE))
    
    
    
  })
}
