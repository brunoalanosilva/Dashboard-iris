library(shiny)
library(shinydashboard)
library(plotly)
library(shinyjs)

data(iris)


variaveis_nomes <- factor(x=1:5,labels = c("Sepal Length","Sepal Width","Petal Length","Petal Width","Species"))

header <- dashboardHeader(title = "Dashboard Iris")


body <- dashboardBody(
    shinyjs::useShinyjs(),
    tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    
    tabItems(
        tabItem(tabName = "inicio",
            h2(shiny::HTML("<b><u>Sobre este aplicativo</u></b>")),
            p("Este dashboard foi criado com o objetivo de treinar a utilização dos pacotes ",strong("Shiny"), " e ",strong("Plotly")," do ",strong("R"),"."),
            HTML("<h2><b><u>Sobre o banco de dados Iris</h2></b></u>"),
            HTML("<p>O banco iris é um famoso conjunto de dados de R.A. Fisher que contêm as medidas de 
             <b>comprimento</b>  e <b>largura</b> da <b>sepála</b> (Sepal Length e Sepal Width) e <b>comprimento</b> e <b>largura</b> da <b>pétala</b> (Sepal Length e Sepal Width) de 3 diferentes <b>espécies de flor</b> (<b>setosa</b>, <b>versicolor</b> e <b>virginica</b>), sendo <b>50 amostras</b> para cada espécie. </p>"),
            HTML("</br></br>"),
            HTML("<h4>Contato</h2>"),
            HTML("<a href='https://www.linkedin.com/in/bruno-alano-a7561a13a' class='contato'>"),icon("linkedin"),HTML("Linkedin</a>"),
            HTML("</br><a href='https://github.com/brunoalanosilva' class='github'>"),icon("github"),HTML("GitHub</a>")
                
        ),            
    tabItem(tabName = "grafico",
            fluidRow(
                box(title = "1ª variável",width = 6,solidHeader = TRUE,status = "danger",height = 360,
                    selectInput(inputId = "variavel1",choices = variaveis_nomes[-5],label = NULL),
                    plotlyOutput(outputId = "grafico1")),
                box(title = "2ª variável",width = 6,solidHeader = TRUE,status = "danger",height = 360,
                    selectInput(inputId = "variavel2",choices = variaveis_nomes[-5],label = NULL,selected = variaveis_nomes[2]),
                    plotlyOutput(outputId = "grafico2"))
            ),
            
            
            
            fluidRow(
                box(title = "Gráfico da interação das 2 variáveis",width = 10,solidHeader = TRUE,status = "danger",height = 500,
                    textOutput("teste"),
                    plotlyOutput(outputId = "grafico3")),
                box(title = "Configurações",icon("tools"),height =500,width = 2,solidHeader = TRUE,status = "danger",
                    checkboxGroupInput(inputId = "conf",
                                       choices = c("Inserir curva linear","inserir curva quadrático","inserir curva cúbico","inserir curva suavisado"),label=""))
            )
            
            
    ),
    tabItem(tabName = "species",
            fluidRow(
                box(title = "1ª variável",width = 6,solidHeader = TRUE,status = "danger",height = 360,
                    selectInput(inputId = "var_specie_1",choices = variaveis_nomes[-5],label = NULL),
                    plotlyOutput(outputId = "grafico_specie_1",height = 250)),
                box(title = "2ª variável",width = 6,solidHeader = TRUE,status = "danger",height = 360,
                    selectInput(inputId = "var_specie_2",choices = variaveis_nomes[-5],label = NULL,selected = variaveis_nomes[2]),
                    plotlyOutput(outputId = "grafico_specie_2",height = 250))
            ),
            
            
            
            fluidRow(
                box(title = "Gráfico da interação das 2 variáveis",width = 12,solidHeader = TRUE,status = "danger",height = 500,
                    plotlyOutput(outputId = "grafico_specie_3",height = 430))
            )
            
    )
    ))
    

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem(text = "Início", tabName = "inicio", icon = icon("bars")),
        menuItem(text = "Gráficos", tabName = "grafico", icon = icon("chart-bar"),startExpanded = TRUE,
                 menuSubItem(text = "Contínuas",tabName = "grafico"),
                 menuSubItem(text = "Interação com species",tabName = "species"))
    ))


shinyUI(dashboardPage(header, sidebar, body,skin = "red"))






