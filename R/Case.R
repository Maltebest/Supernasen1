Case<- function(alpha, c) {
  a <- c * sin(alpha * pi/180)
  b <- c * cos(alpha * pi/180)
  AB <- list(x = round(a, 2), y = round(b, 2))
  return(AB)
}