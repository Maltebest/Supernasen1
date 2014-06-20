load("data/tree_locations_species_all.RData")
source("Funktion/degtoRad.R")
source("Funktion/calculateTriangle.R")
obs.dis <- calculateTriangle(loc.spec$inclination, loc.spec$distance)
loc.spec$distance_adj <- obs.dis$y
decl <- 1.78
loc.spec$bearing_adj <- ifelse(loc.spec$bearing < decl,
                               loc.spec$bearing - decl + 360,
                               loc.spec$bearing - decl)
load("data/corner_points.RData")
tree.offset <- calculateTriangle(loc.spec.xyz$bearing_adj, 
                         loc.spec.xyz$distance_adj)

loc.spec.xyz$offset.x <- tree.offset$x
loc.spec.xyz$offset.y <- tree.offset$y

loc.spec.xyz$tree.loc.x <- loc.spec.xyz$origin.x + loc.spec.xyz$offset.x
loc.spec.xyz$tree.loc.y <- loc.spec.xyz$origin.y + loc.spec.xyz$offset.y
while(any(is.na(loc.spec.xyz$origin.x))) {
  ind.mis <- which(is.na(loc.spec.xyz$origin.x))
  for (i in ind.mis) {
    ori.tree <- loc.spec.xyz$origin[i]
    
    ori.x <- loc.spec.xyz$tree.loc.x[loc.spec.xyz$treeID == ori.tree]
    loc.spec.xyz$origin.x[loc.spec.xyz$origin == ori.tree] <- mean(ori.x)
    
    ori.y <- loc.spec.xyz$tree.loc.y[loc.spec.xyz$treeID == ori.tree]
    loc.spec.xyz$origin.y[loc.spec.xyz$origin == ori.tree] <- mean(ori.y)
    
  }
  tree.offset <- calculateTriangle(loc.spec.xyz$bearing_adj, 
                           loc.spec.xyz$distance_adj)
  
  loc.spec.xyz$offset.x <- tree.offset$x
  loc.spec.xyz$offset.y <- tree.offset$y
  
  loc.spec.xyz$tree.loc.x <- loc.spec.xyz$origin.x + loc.spec.xyz$offset.x
  loc.spec.xyz$tree.loc.y <- loc.spec.xyz$origin.y + loc.spec.xyz$offset.y
  
}
install.packages(c("latticeExtra", "gridExtra"))
library(latticeExtra)
library(gridExtra)
trees.p <- xyplot(tree.loc.y ~ tree.loc.x, data = loc.spec.xyz, 
                  asp = "iso", pch = 19,
                  col = brewer.pal(length(unique(loc.spec.xyz$spec)), 
                                   "Set1")[as.factor(loc.spec.xyz$spec)])
corners.df <- coords.ele
corners.df[5, ] <- corners.df[1, ]
corners.p <- xyplot(origin.y ~ origin.x, data = corners.df, type = "l", 
                    asp = "iso", col = "grey90", 
                    panel = function(...) {
                      grid.rect(gp = gpar(fill = "grey10"))
                      panel.xyplot(...)})
p <- corners.p + as.layer(trees.p)
print(update(p, main = paste("Tree locations\n", 
                             "(colour coded according to species)"),
             xlab = "X", ylab = "Y", scales = list(y = list(rot = 90))))
