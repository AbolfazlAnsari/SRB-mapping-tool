ui <- dashboardPage(
  
  dashboardHeader(title ='Susquehanna River'),            
                  
  
  dashboardSidebar( 
    
    
    
    sidebarMenu(id="menu",
    
    menuItem("Control",
             
             
             menuSubItem('Map'),
    
    
    
    checkboxInput("Levee", label="Levee systems", value = FALSE, width = NULL),
    
    checkboxInput("Reservoir", label="Reservoirs", value = FALSE, width = NULL),
    
    
    menuSubItem('Plot'),
    
    selectInput(inputId="variable", label = "Select:",selected ="Organic N" , choices = c("Water",'Flood event', "Organic N", "Organic P",
                                                           
      
                                                           
                                              "NO3","NO2","NH4","Mineral P", 'Total N','Total P', "Sediment"))
    
    ),
    
    
    menuItem("Scenario",
    
             menuSubItem('Climate Change'),
             
             menuSubItem('Developments'),
             
             menuSubItem('BMPs')
    
    ),
    
    
    
    menuItem("Detailed Analysis"),
    
    menuItem("Raw Data"),
    
    menuItem("Downloads"),
    
    menuItem("About Project"),
    
    menuItem("Contact Us")
    

    
  )
  
  
  
  
),



  
  dashboardBody(
    
  

    
    fluidRow( 
      
      column( width = 12, h2('Map'),h4('Click a location and drag the marker around'),  leafletOutput(outputId = "map"), textOutput("text")),
      
      
      
    ),
    
              
      fluidRow(
        
        column(width=6,h2('Catchment load'),h4(textOutput("information1")),plotOutput(outputId = "local")),
        
         column(width=6,h2('Upstream + catchment load'),h4(textOutput("information2")),plotOutput(outputId = "global") )          
              
              
      )            

  

  
)

) # end of user interface



