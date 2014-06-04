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
  Ax<- (x.known)
  Ay<- (y.known)
  Bx<- (y.known+distAB)
  By<- (x.known)
  Dx<- (x.known+distAD)
  Dy<- (y.known)
  Cx<- (B[1]+distBC)
  Cy<- (D[1]+distDC)
  Corners<- data.frame(A=list(x=Ax, y=Ay), B=list(x=Bx, y=By), C=list(x=Cx, y=Cy), D=list(x=Dx, y=Dy))
  Corners
  }
calcCorners(481054, 5645540, 6, 1.48, 48, 30)
load("data/corner_points.RData")
load("data/tree_locations_species_all.RData")