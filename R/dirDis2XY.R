dirDis2XY <- function(alpha,c){
rad <- alpha*pi/180
geka <- sin(rad)*c
anka <- cos(rad)*c

wert <- list(x=round(geka,2),y=round(anka,2))
return(wert)
}