
calculateTriangle <- function(alpha, c) {
  
  source("R/degToRad.R")
  
  a <- sin(degToRad(alpha)) * c
  b <- cos(degToRad(alpha)) * c
  result <- data.frame(x = round(a, 2), y = round(b, 2))
  return(result)
}
