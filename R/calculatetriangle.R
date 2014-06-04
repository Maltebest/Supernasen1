calculateTriangle <- function(alpha, c) {
  alphaRad <- alpha * pi/180
  a <- sin(alphaRad) * c
  b <- cos(alphaRad) * c
  result <- data.frame(x = round(a, 2), y = round(b, 2))
  return(result)
}
