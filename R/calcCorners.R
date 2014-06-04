calcCorners <- function(x.known, y.known, orientation, declination, size.x, 
                        size.y) {
  source("R/degToRad.R")
  source("R/calculateTriangle.R")
  
  alpha1 <- orientation + declination
  alpha2 <- alpha1 + 90
  alpha3 <- alpha1 + 180
  alpha4 <- alpha1 + 270
  
  distAB <- calculateTriangle(alpha1, size.y)
  distAD <- calculateTriangle(alpha1, size.x)
  distBC <- calculateTriangle(alpha2, size.x)
  distDC <- calculateTriangle(alpha3, size.y)
  
  Ax <- x.known
  Ay <- y.known
  Bx <- x.known
  By <- y.known + distAB
  Dx <- x.known + distAD 
  Dy <- y.known
  Cx <- B[1] + distBC 
  Cy <- D[1] + distDC
  
  Corners <- data.frame(A = list(x = Ax, y = Ay), B = list(x = Bx, y = By), C = list(x = Cx, y = Cy), D = list(x =Dx, y = Dy))
  return(Corners)
}