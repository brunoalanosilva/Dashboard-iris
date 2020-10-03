library(shiny)
library(shinydashboard)
library(plotly)
library(shinyjs)
library(stringr)

data(iris)
inicio <- TRUE
variaveis_nomes <- factor(x=1:5,labels = c("Sepal Length","Sepal Width","Petal Length","Petal Width","Species"))
escolhas_conf = c("Inserir curva linear","inserir curva quadrático","inserir curva cúbico","inserir curva suavisado")

shinyServer(function(input, output,session) {
   output$teste <- renderText(
      ""
   )
   output$teste2 <- renderText(
       input$conf[1]
   )
   

   
   
   
   
   
   
     output$grafico1 <- renderPlotly({
         plot_ly(x = iris[,variaveis_nomes %in% input$variavel1], type = 'histogram',marker = list(color = "#df5247"),height = 250)%>%
             layout(barmode = "overlay")
     })
     
     output$grafico2 <- renderPlotly({
        plot_ly(x = iris[,variaveis_nomes %in% input$variavel2], type = 'histogram',marker = list(color = "#df5247"),height = 250)%>%
           layout(barmode = "overlay")
     })
     
     output$grafico3 <- renderPlotly({
        variavel1 <- iris[,variaveis_nomes %in% input$variavel1]
        variavel2 <- iris[,variaveis_nomes %in% input$variavel2]
         p <-  plot_ly() 
       
         if(input$variavel1 == input$variavel2){
            shinyjs::hide("conf")
            shinyjs::reset("conf")
            plot_ly(x = iris[,variaveis_nomes %in% input$variavel1], type = 'histogram',marker = list(color = "#df5247"))%>%
               layout(barmode = "overlay")
         }else if(input$variavel1 == variaveis_nomes[5] | input$variavel2 == variaveis_nomes[5]){
            shinyjs::hide("conf")
            shinyjs::reset("conf")
         }else {
            shinyjs::show("conf")
            p <- p %>%
               add_trace(x = variavel1 ,y=variavel2,mode="markers", showlegend = FALSE)
            
            xx <- data.frame(variavel1 =seq(min(variavel1),max(variavel1),0.1) )
            
            if(escolhas_conf[1] %in% input$conf){
               modelo_linear <- lm( variavel2 ~ variavel1)
               p <- p %>%
                  add_lines(x = xx[,1],y=predict(object = modelo_linear,newdata =xx),mode="lines",
                            name="curva linear")
            }
            if(escolhas_conf[2] %in% input$conf){
               modelo_quadratico <- lm( variavel2 ~ variavel1 + I(variavel1^2))
               p <- p %>%
                  add_lines(x = xx[,1],y=predict(object = modelo_quadratico,newdata =xx),mode="lines",
                            name="curva quadrática")
            }
            if(escolhas_conf[3] %in% input$conf){
               modelo_cubico <- lm( variavel2 ~ variavel1 + I(variavel1^2) + I(variavel1^3))
               p <- p %>%
                  add_lines(x = xx[,1],y=predict(object = modelo_cubico,newdata =xx),mode="lines",
                            name="curva cúbica")
            }
            if(escolhas_conf[4] %in% input$conf){
               p <- p %>%
                  add_lines(x = variavel1, y = ~fitted(loess(variavel2 ~ variavel1)),
                            line = list(color = '#07A4B5'),
                            name = "curva suavisada", showlegend = TRUE)
            }
            
            
            p   
               
         }
         
        
       
        
     })
     
     output$grafico_specie_1 <- renderPlotly({
        plot_ly(y = iris[,variaveis_nomes %in% input$var_specie_1],color = iris$Species, type = "box",boxpoints = "all", jitter=0.3,pointpos = -1.8)
     })
     output$grafico_specie_2 <- renderPlotly({
        plot_ly(y = iris[,variaveis_nomes %in% input$var_specie_2],color = iris$Species, type = "box",boxpoints = "all", jitter=0.3,pointpos = -1.8)
     })
     
     output$grafico_specie_3 <- renderPlotly({
        variavel1 <- iris[,variaveis_nomes %in% input$var_specie_1]
        variavel2 <- iris[,variaveis_nomes %in% input$var_specie_2]
       
        
        if(input$var_specie_1 == input$var_specie_2){
            plot_ly(y = iris[,variaveis_nomes %in% input$var_specie_2],color = iris$Species, type = "box",boxpoints = "all", jitter=0.3,pointpos = -1.8)
        }else {
           p <- plot_ly(x=variavel1, y=variavel2,mode = 'markers',
                        text = paste(" Specie: ", iris$Species,
                                     "<br>",names(iris)[variaveis_nomes %in% input$var_specie_1],": ", variavel1,
                                     "<br>",names(iris)[variaveis_nomes %in% input$var_specie_2],": ", variavel2),
                        hoverinfo = 'text',
                        color=iris$Species)
           p  
        }
        
        
     })
     
     
})

