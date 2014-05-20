calcCorners <- function(x.known, y.known, 
                        orientation, declination,
                        size.x, size.y) {
  
  calculateTriangle <- function(alpha, c) {
    alphaRad <- alpha * pi/180
    a <- sin(alphaRad) * c
    b <- cos(alphaRad) * c
    result <- data.frame(x = round(a, 2), y = round(b, 2))
    return(result)
  }
  
  alpha<- orientation+declination
  alpha2<-alpha+90
  alpha3<-alpha+270
  distAB<- calculateTriangle(alpha, size.y)
  distAD<- calculateTriangle(alpha, size.x)
  distBC<- calculateTriangle(alpha2, size.x)
  distDC<- calculateTriangle(alpha3, size.y)
  A<- (c(x.known, y.known))
  B<- (c(y.known+distAB, x.known))
  D<- (c(x.known+distAD, y.known))
  C<- (c(B[1]+distBC, D[1]+distDC))
  Corners<- (c(A,B,C,D))
  Corners
  }
calcCorners(481054, 5645540, 6, 1.48, 48, 30)
