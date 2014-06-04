## Auflisten aller „location.csv“-Dateien aus dem data-Ordner
fls <- list.files("data", pattern = "locations.csv", full.names = TRUE)

## Daten laden
loc.list <- lapply(fls, function(...) {
  read.csv(..., stringsAsFactors = FALSE, fill = TRUE)
})

## Fügt die Daten zu einem einzigen Datensatz zusammen
loc <- do.call("rbind", loc.list)


## Hinzufügen der Baumarten (species_inventory) aus dem data-Ordner
spec <- read.csv("data/species_inventory.csv",
                 stringsAsFactors = FALSE, fill = TRUE)

## Verbinden der species_inventory-Daten mit den location-Daten
loc.spec <- merge(loc, spec)


## Speichert die aufbereiteten Daten als neue Datei im data-Ordner
save(loc.spec, file = "data/tree_locations_species_all.RData")




## Laden der Datei “tree_locations_species_all
load("data/tree_locations_species_all.RData")


## Laden bzw. Verfügbarmachen der Funktionen
source("R/degToRad.R")
source("R/dirDis2XY.R")


## …
obs.dis <- dirDis2XY(loc.spec$inclination, loc.spec$distance)
loc.spec$distance_adj <- obs.dis$y


## …
decl <- 1.78
loc.spec$bearing_adj <- ifelse(loc.spec$bearing < decl,
                               loc.spec$bearing - decl + 360,
                               loc.spec$bearing - decl)



## Laden der Datei corner_points aus den data-Ordner
load("data/corner_points.RData")



## …
coords.ele <- data.frame(origin = corner.points@data$corner,
                         origin.x = corner.points@coords[, 1],
                         origin.y = corner.points@coords[, 2],
                         origin.z = corner.points@data$ele)

##...
loc.spec.xyz <- merge(loc.spec, coords.ele, all.x = TRUE)


## …
tree.offset <- dirDis2XY(loc.spec.xyz$bearing_adj, 
                         loc.spec.xyz$distance_adj)

loc.spec.xyz$offset.x <- tree.offset$x
loc.spec.xyz$offset.y <- tree.offset$y

loc.spec.xyz$tree.loc.x <- loc.spec.xyz$origin.x + loc.spec.xyz$offset.x
loc.spec.xyz$tree.loc.y <- loc.spec.xyz$origin.y + loc.spec.xyz$offset.y




## do as long as origin.x still has NA values
while(any(is.na(loc.spec.xyz$origin.x))) {
  
  ## which rows have missing origin coordinates
  ind.mis <- which(is.na(loc.spec.xyz$origin.x))
  
  ## loop through all missing origin coordinates and provide 
  ## appropriate values based on treeID
  for (i in ind.mis) {
    
    ori.tree <- loc.spec.xyz$origin[i]
    
    ori.x <- loc.spec.xyz$tree.loc.x[loc.spec.xyz$treeID == ori.tree]
    loc.spec.xyz$origin.x[loc.spec.xyz$origin == ori.tree] <- mean(ori.x)
    
    ori.y <- loc.spec.xyz$tree.loc.y[loc.spec.xyz$treeID == ori.tree]
    loc.spec.xyz$origin.y[loc.spec.xyz$origin == ori.tree] <- mean(ori.y)
    
  }
  
  ## calculate offset again and add to origin
  tree.offset <- dirDis2XY(loc.spec.xyz$bearing_adj, 
                           loc.spec.xyz$distance_adj)
  
  loc.spec.xyz$offset.x <- tree.offset$x
  loc.spec.xyz$offset.y <- tree.offset$y
  
  loc.spec.xyz$tree.loc.x <- loc.spec.xyz$origin.x + loc.spec.xyz$offset.x
  loc.spec.xyz$tree.loc.y <- loc.spec.xyz$origin.y + loc.spec.xyz$offset.y
  
}


##...
save(loc.spec.xyz, file = "data/loc_spec_xyz.RData")


## load packages needed for plotting
library(latticeExtra)
library(gridExtra)

## create tree plotting object
trees.p <- xyplot(tree.loc.y ~ tree.loc.x, data = loc.spec.xyz, 
                  asp = "iso", pch = 19,
                  col = brewer.pal(length(unique(loc.spec.xyz$spec)), 
                                   "Set1")[as.factor(loc.spec.xyz$spec)])

## used coords.ele for corner points
corners.df <- coords.ele
## replicate first corner point to close polygon
corners.df[5, ] <- corners.df[1, ]

## create corner point plotting object
corners.p <- xyplot(origin.y ~ origin.x, data = corners.df, type = "l", 
                    asp = "iso", col = "grey90", 
                    panel = function(...) {
                      grid.rect(gp = gpar(fill = "grey10"))
                      panel.xyplot(...)})

## create layered plotting object
p <- corners.p + as.layer(trees.p)

## final plot
print(update(p, main = paste("Tree locations\n", 
                             "(colour coded according to species)"),
             xlab = "X", ylab = "Y", scales = list(y = list(rot = 90))))




