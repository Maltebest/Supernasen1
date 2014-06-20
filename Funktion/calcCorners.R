calcCorners <- function(x.known, y.known, orientation, declination, size.x, 
                        size.y) {
  
  alpha1 <- orientation + declination
  alpha2 <- alpha1 + 90
  alpha3 <- alpha1 + 270
  
  distAB <- calculateTriangle(alpha1, size.y)
  distDA <- calculateTriangle(alpha3, size.x)
  distBC <- calculateTriangle(alpha2, size.x)
  
  Ax <- x.known + distDA[,1]
  Ay <- y.known + distDA[,2]
  Bx <- Ax + distAB[,1]
  By <- Ay + distAB[,2]
  Cx <- Bx + distBC[,1]
  Cy <- By + distBC[,2]
  Dx <- x.known
  Dy <- y.known
  
  Corners <- data.frame(A = list(x = Ax, y = Ay), B = list(x = Bx, y = By), C = list(x = Cx, y = Cy), D = list(x =Dx, y = Dy))
  return(Corners)
}
calcCorners(481054, 5645540, 6, 1.5, 48,30)
