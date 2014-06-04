fls <- list.files("data", pattern = "locations.csv", full.names = TRUE)
fls
loc.list <- lapply(fls, function(...) {
  read.csv(..., stringsAsFactors = FALSE, fill = TRUE)
})
str(loc.list)
loc <- do.call("rbind", loc.list)
str(loc)
spec <- read.csv("data/species_inventory.csv",
                 stringsAsFactors = FALSE, fill = TRUE)
loc.spec <- merge(loc, spec)
str(loc.spec)
save(loc.spec, file = "data/tree_locations_species_all.RData")
load("data/tree_locations_species_all.RData")