shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Child Fever - When to Call the Doctor"),
    sidebarPanel(
      
      tags$head(
        tags$style(type="text/css", "label.radio { display: inline-block; line-height: 20px; margin-right:10px}"),
        tags$style(type="text/css", "input.shiny-bound-input { max-width: 50px;display: inline-block; }"),
        tags$style(type="text/css", "textarea { max-width: 185px; }"),
        tags$style(type="text/css", ".jslider { max-width: 200px; }"),
        tags$style(type='text/css', ".span4 { max-width: 310px; }"),
        tags$style(type='text/css', "label { display: inline-block; line-height: 30px; }"),
        tags$style(type="text/css", "label.control-label { display: block; }"),
        tags$style(type="text/css", ".help-block { color: black; }"),
        tags$style(type="text/css", ".well input[type='text'], .well input[type='number'], .well select { max-width: 50px; }")
      ),
      
      helpText("Please enter your child's age, temperature and method used to record temperature (either oral, rectal, or under the arm) to receive advice on how best to treat his/her fever."),
      helpText("Age of Child:"),
      numericInput('years', 'Years', 0, min = 0, max = 16, step = 1),
      numericInput('months', 'Months', 0, min = 0, max = 11, step = 1),      
      
      radioButtons("scale", "Temperature:", c("Fahrenheit" = "fhr", "Celsius" = "cls")),
      
      conditionalPanel(
        condition = "input.scale == 'fhr'",
        sliderInput('ftemp', '',value = 96, min = 96, max = 106, step = 0.1,)        
      ),
      
      conditionalPanel(
        condition = "input.scale == 'cls'",
        sliderInput('ctemp', '',value = 36, min = 36, max = 41, step = 0.1,)        
      ),
      
      radioButtons("method", "Method:", c("Oral" = "orally", "Axillary" = "under the arm", "Rectal" = "rectally"))      
      
    ),
    
    mainPanel(
      h4('for a child aged'),
      verbatimTextOutput("age"),
      h4('with a temperature of '),
      verbatimTextOutput("temperature"),
      h4('taken'),
      verbatimTextOutput("method"),
      h3('Recommendation:'),
      verbatimTextOutput("recommendation")
    )
  )
)