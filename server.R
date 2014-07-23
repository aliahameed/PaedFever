calculateAge <- function(years, months) {
  # return age in months
  (years * 12) + months
}

calculateTemp <- function(method, ctemp, ftemp, scale) {
  # convert to Celsius first
  if (scale == 'fhr') {
    temp = (ftemp - 32) * 0.56
  } else {
    temp = ctemp
  }
  
  # return rectal (the most accurate) temperature
  if (method == "orally") {
    temp = temp + 0.3
  } else if (method == "under the arm") {
    temp = temp + 0.6
  }
  temp
}

getRecommendation <- function(years, months, method, ctemp, ftemp, scale) {
  # determine course of action based on child's age in months 
  age <- calculateAge(years, months)
  
  # and body temperature in Celsius
  temp = calculateTemp(method, ctemp, ftemp, scale)
  
  if (temp < 37.3) {
    "No fever."
  } else if (temp < 38.4) {
    "This is considered a \"low-grade\" fever. Low-grade fevers are useful in fighting off infection. There is no reason to treat a low-grade fever."
  } else if ((age < 2) && (temp > 38.3)) {
    "MEDICAL EMERGENCY: A doctor should evaluate your infant right away, either during business hours, or in an emergency room after hours. Do not give any fever-reducing medications until a doctor has seen your child."
  } else if ((age < 4) && (temp > 38.3)) {
    "Make an appointment with your doctor within the next several hours."
  } else if (temp > 39.7) {
    "This is a high fever. Before calling your doctor, try to bring the temperature down with medication. Acetaminophen or ibuprofen can safely be administered to children. (Never give aspirin to children aged 12 and under.) A lukewarm bath and cool washcloth can be used as well as cool liquids to drink. If these measures don't bring the fever down, or if your child develops any other unusual symptoms (lethargy, irritability, stiff neck or pain in the back of the neck, light sensitivity, vomiting or headache), call your doctor without delay."
  } else {
    "This is considered a \"common\" fever. This is generally not serious and can wait until morning to be evaluated. If your child develops any other unusual symptoms (lethargy, irritability, stiff neck or pain in the back of the neck, light sensitivity, vomiting or headache), call your doctor without delay"
  }  
  
}
shinyServer(
  function(input, output) {
    output$age <- renderText({paste(input$years, "year(s) and", input$months, "month(s)")})
    output$temperature <- renderText({input$ftemp})
    output$method <- renderText({input$method})
    output$recommendation <- renderText({getRecommendation(input$years, input$months, input$method, input$ctemp, input$ftemp, input$scale)})
  }
)