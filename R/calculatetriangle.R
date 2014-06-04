
calculateTriangle <- function(alpha, c) {
<<<<<<< HEAD
=======
  
  source("R/degToRad.R")
  
>>>>>>> b690b83c9aa00dfe4ef9842cc5a34b6bbc489abc
  a <- sin(degToRad(alpha)) * c
  b <- cos(degToRad(alpha)) * c
  result <- data.frame(x = round(a, 2), y = round(b, 2))
  return(result)
}
