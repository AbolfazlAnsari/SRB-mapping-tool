server<-function(input,output){
  
  
  output$map<-renderLeaflet({
    
    
    
    leaflet() %>%
      
      setView(lng=-77.40,lat=42.20,zoom=8) %>%
      
      addProviderTiles('Esri.WorldImagery') %>%
      
      # addTiles(urlTemplate = "https://mts1.google.com/vt/lyrs=s&hl=en&src=app&x={x}&y={y}&z={z}&s=G", attribution = 'Google')
      
      # addTiles()
      
      addPolygons(data=Chemung,color='black')%>%
      
      addPolygons(data=Rivers,color='#ccffff', fillColor='#ccffff',fillOpacity=0.2,weight = 1)%>%
      
      
      addMarkers(lng=-77.40,lat=42.20,options = markerOptions(draggable = TRUE))
      
      
        
    
    
  
    
  })
  
 
  
  
  current_markers<-reactiveValues(
    
    lon = -77.40,
    
    lat= 42.2
    
  )
  
  
  #current_variable<-reactiveValues(input$variable)
  
  
  
  
  
  
  
  observeEvent(input$map_marker_dragend,{
    
    showModal(modalDialog("LOADING ...", footer=NULL))
    
    rd<-region_data(shapefile=catchment,
                    
                    markers=data.frame(lon=input$map_marker_dragend$lng,lat=input$map_marker_dragend$lat))
    
    
    
    if(nrow(rd)==0){
      
      
      showNotification("Error: no data this location",id="region_error")
      
      map<- leafletProxy(mapId = "map")%>%
        
        removeShape(layerId=c('floodplain','catchment','upstream'))
      
   
      output$local<-renderPlot({
        
        months_label<-c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
        
        data<-data.frame(month=rep(NA,12), value=rep(NA,12))
        
        
        data$month<-1:12
        
        
        data$value<-rep(0,12)
        
        
        ggplot(data=data, aes(x=month, y=value)) +
          geom_bar(stat="identity",fill='#0072B2')+
          
          xlab('Month')+
          ylab("")+
          
          ylim(0,1)+
          
          scale_x_continuous(breaks = c(1:12),label = months_label)+
          theme(panel.background = element_rect(fill = "white"),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                panel.border = element_rect(colour = 'black', fill=NA, size=1),axis.text=element_text(size=28),
                axis.title=element_text(size=30),legend.text=element_text(size=28),legend.title=element_blank(),legend.background = element_rect(fill = "transparent"),
                legend.box.background = element_rect(colour = NA,fill = "transparent"),legend.key = element_rect(colour = NA, fill = NA),axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
        
        
        
        
        
      })
      
      
      output$global<-renderPlot({
        
        months_label<-c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
        
        data<-data.frame(month=rep(NA,12), value=rep(NA,12))
        
        
        data$month<-1:12
        
        
        data$value<-rep(0,12)
        
        
        ggplot(data=data, aes(x=month, y=value)) +
          geom_bar(stat="identity",fill='#0072B2')+
          
          xlab('Month')+
          ylab("")+
          
          ylim(0,1)+
          
          scale_x_continuous(breaks = c(1:12),label = months_label)+
          theme(panel.background = element_rect(fill = "white"),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                panel.border = element_rect(colour = 'black', fill=NA, size=1),axis.text=element_text(size=28),
                axis.title=element_text(size=30),legend.text=element_text(size=28),legend.title=element_blank(),legend.background = element_rect(fill = "transparent"),
                legend.box.background = element_rect(colour = NA,fill = "transparent"),legend.key = element_rect(colour = NA, fill = NA),axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
        
        
        
        
        
      })
      
      
      
      output$information1 <- renderText({
        
        
        paste('Catchment drainage area:', sep="  ")
        
        
        
      })
      
      
      output$information2 <- renderText({
        
        
        paste('Total drainage area:',sep="  " )
        
        
      })
      
      
      
      
      
    }else{
      
      
      
      
      output$information1 <- renderText({
        
        
        paste('Catchment drainage area:', round(flowline$AreaSqKm[which(flowline$core_id==rd$cor_id[1])],digits = 2),'SqKm',sep="  ")
             
        
        
      })
      
      
      output$information2 <- renderText({
        
        
        paste('Total drainage area:', round(flowline$TotDASqKm[which(flowline$core_id==rd$cor_id[1])],digits = 2),'SqKm',sep="  " )
        
        
      })
      
      
      
      
      
      
      
      
      current_markers$lon<-input$map_marker_dragend$lng
      
      current_markers$lat<-input$map_marker_dragend$lat
      
      ups<-Upstream(id=rd$cor_id[1],flowline=flowline)
      
      
    
      
      if(length(ups)>0){
        
        cm<-st_combine(catchment[catchment$cor_id %in% ups,])
        
        
        
      }else{
        
        cm<-catchment[catchment$cor_id==rd$cor_id[1],]
        
      }
      
      
      # fp <- st_as_sf(st_combine(st_intersection(floodplain,cm))) 
      
      
      
      tryCatch({
        fp<-st_combine(st_intersection(floodplain,cm))
        
      }, error = function(e) {
        NULL
      }, finally = {
        #Cleanup
      })
      
      
      
      
      # clear map
      
      
      map<- leafletProxy(mapId = "map")%>%
      
      removeShape(layerId=c('floodplain','catchment','upstream'))
      
      
      
      
      
      
      # update map
      
      tryCatch({
        
        map<- leafletProxy(mapId = "map")  %>%
          
          addPolygons(data=catchment[catchment$cor_id==rd$cor_id[1],],color='#000000',
                      
                      fillColor='#FF0000',fillOpacity = 0.25  ,weight = 2,layerId = "catchment")
        
        
      }, error = function(e) {
        NULL
      }, finally = {
        #Cleanup
      })
      
      
      
      
       
      
      if(length(ups)>1) {
        
        
        tryCatch({
          
          map<-addPolygons(map=map,data=cm, fillColor ='#FF0000' ,
                           
                           fillOpacity = 0.1,weight = 0,layerId = "upstream")
          
          
        }, error = function(e) {
          NULL
        }, finally = {
          #Cleanup
        })
        
        
        
        
      }
      
      
      
      tryCatch({
        
        addPolygons(map=map,data=fp, fillColor ='#0000ff' , color='#0000ff',
                    
                    fillOpacity = 0.25,weight = 1,layerId = "floodplain")
      }, error = function(e) {
        NULL
      }, finally = {
        #Cleanup
      })
      
      
      
      
     
  
      
      
       output$local<-renderPlot({
         
         
         if (input$variable %in% c("Water","Organic N","Organic P","Mineral P","NO3","Sediment") ){
         
         
         if(input$variable=="Water"){
           
           col_num<-c(2:13)
           
           ylabel<-expression ("Volume,"~m^3)
           
         }
         
         if(input$variable=="Organic N"){
           
           col_num<-c(14:25)
           
           ylabel<-'Organic N, kg'
           
         }
         
         
         if(input$variable=="Organic P"){
           
           col_num<-c(26:37)
           
           ylabel<-'Organic, kg'
           
         }
         
         if(input$variable=="NO3"){
           
           col_num<-c(38:49)
           
           ylabel<-' NO3, kg'
           
         }
         
         
         if(input$variable=="Mineral P"){
           
           col_num<-c(50:61)
           
           ylabel<-'Mineral P, kg'
           
         }
         
         
         if(input$variable=="Sediment"){
           
           col_num<-c(62:73)
           
           ylabel<-'Sediment, ton'
           
         }
         
         
         months_label<-c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
         
         
         
         
        
         
         
         df<-local_df[local_df$Reach==rd$cor_id[1],col_num]
         
         
       
           
         data<-data.frame(month=rep(NA,12), value=rep(NA,12))
         
        
         data$month<-1:12
         
         
         data$value<-c(df[[1]],df[[2]],df[[3]],df[[4]],df[[5]],df[[6]],df[[7]],df[[8]],df[[9]],df[[10]],df[[11]],df[[12]])
         
         
         
        ggplot(data=data, aes(x=month, y=value)) +
           geom_bar(stat="identity",fill='#0072B2')+
           
           xlab('Month')+
           ylab(ylabel)+
           scale_x_continuous(breaks = c(1:12),label = months_label)+
           theme(panel.background = element_rect(fill = "white"),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                 panel.border = element_rect(colour = 'black', fill=NA, size=1),axis.text=element_text(size=28),
                 axis.title=element_text(size=30),legend.text=element_text(size=28),legend.title=element_blank(),legend.background = element_rect(fill = "transparent"),
                 legend.box.background = element_rect(colour = NA,fill = "transparent"),legend.key = element_rect(colour = NA, fill = NA),axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
      
         
         }
         
         
       })
      
      
      
       output$global<-renderPlot({
       
       
         if(input$variable=="Flood event"){
           
           col_num<-c(2:5)
           
           ylabel<- expression ("Flood event,"~m^3/s)
           
           
           df<-global_df[global_df$Reach==rd$cor_id[1],col_num]
           
           
           
           
           data<-data.frame(rp=rep(NA,4), value=rep(NA,4))
           
           RP<-c("5-YR", "10-YR","50-YR","100-YR")
           
           
           
           
           
           
           data$rp<-1:4
           
           
           
           data$value<-c(df[[1]],df[[2]],df[[3]],df[[4]])
           
           
           
           
           ggplot(data=data, aes(x=rp, y=value)) +
             geom_bar(stat="identity",fill='#0072B2')+
             
             xlab('Flood event')+
             ylab(ylabel)+
             scale_x_continuous(breaks = c(1:4),label = RP)+
             theme(panel.background = element_rect(fill = "white"),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                   panel.border = element_rect(colour = 'black', fill=NA, size=1),axis.text=element_text(size=28),
                   axis.title=element_text(size=30),legend.text=element_text(size=28),legend.title=element_blank(),legend.background = element_rect(fill = "transparent"),
                   legend.box.background = element_rect(colour = NA,fill = "transparent"),legend.key = element_rect(colour = NA, fill = NA),axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
           
         
           
           
           
           
           
           
         }else{
           
           
           if(input$variable !='Water'){
           
         
         if(input$variable=="Organic N"){
           
           col_num<-c(6:17)
           
           ylabel<-'Organic N, kg'
           
         }
         
         
         if(input$variable=="Organic P"){
           
           col_num<-c(66:77)
           
           ylabel<-' Organic P, kg'
           
         }
         
         
         if(input$variable=="NO2"){
           
           col_num<-c(18:29)
           
           ylabel<-'NO2, kg'
           
         }
         
         
         if(input$variable=="NO3"){
           
           col_num<-c(30:41)
           
           ylabel<-'NO3, kg'
           
         }
         
         if(input$variable=="NH4"){
           
           col_num<-c(42:53)
           
           ylabel<-'NH4, kg'
           
         }
         
         
         
         
         
         if(input$variable=="Mineral P"){
           
           col_num<-c(78:89)
           
           ylabel<-'Mineral P, kg'
           
         }
         
         
         if(input$variable=="Sediment"){
           
           col_num<-c(102:113)
           
           ylabel<-'Sediment, ton'
           
         }
         
         
         if(input$variable=="Total N"){
           
           col_num<-c(54:65)
           
           ylabel<-'Total N, kg'
           
         }
         
         
         if(input$variable=="Total P"){
           
           col_num<-c(90:101)
           
           ylabel<-'Total P, kg'
           
         }
         
         
         
         
         months_label<-c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
         
         
      
         
         
         df<-global_df[global_df$Reach==rd$cor_id[1],col_num]
         
         
         
         
         data<-data.frame(month=rep(NA,12), value=rep(NA,12))
         
        
         
         
         
         data$month<-1:12
         
         
         data$value<-c(df[[1]],df[[2]],df[[3]],df[[4]],df[[5]],df[[6]],df[[7]],df[[8]],df[[9]],df[[10]],df[[11]],df[[12]])
         
         
         
         
         ggplot(data=data, aes(x=month, y=value)) +
           geom_bar(stat="identity",fill='#0072B2')+
           
           xlab('Month')+
           ylab(ylabel)+
           scale_x_continuous(breaks = c(1:12),label = months_label)+
           theme(panel.background = element_rect(fill = "white"),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                 panel.border = element_rect(colour = 'black', fill=NA, size=1),axis.text=element_text(size=28),
                 axis.title=element_text(size=30),legend.text=element_text(size=28),legend.title=element_blank(),legend.background = element_rect(fill = "transparent"),
                 legend.box.background = element_rect(colour = NA,fill = "transparent"),legend.key = element_rect(colour = NA, fill = NA),axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
         
        
         
         
         
         
         
           }
         
         
         
         
         
         
         
         
         
         }
         
         
       
       
       
       }) 
       
      
    }
    
    
    
    
    
    removeModal()
    
    
    
  }
  
  )
  
  
  
  observeEvent(input$map_shape_click,{
    
    
    current_markers$lon<-input$map_shape_click$lng
    
    current_markers$lat<-input$map_shape_click$lat
    
    
    leafletProxy(mapId ="map" ) %>%
      
      clearMarkers() %>%
      
      addMarkers(data=data.frame(lat=input$map_shape_click$lat, lng=input$map_shape_click$lng),
                 
                 options = markerOptions(draggable = TRUE))
    
    
    
  })
  
  
  
  
  
  
  
  
  
  output$text <- renderText({
    
    

      
        paste(round(as.numeric(current_markers$lon), digits = 4),
              round(as.numeric(current_markers$lat),digits = 4),sep=" ")
        
    
    
    
  })
  
  
  
  
  
  
  
  
    


  
} # server
