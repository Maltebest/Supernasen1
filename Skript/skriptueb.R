load("data/corner_points.RData")
load("data/loc_spec_xyz.RData")
wndw <- owin(poly = list(x = corner.points@coords[c(4:1), 1],
                         y = corner.points@coords[c(4:1), 2]))
loc.spec.xyz.unq <- loc.spec.xyz[!duplicated(loc.spec.xyz$treeID), ]
loc.spec.xyz.unq.ppp <- ppp(x = loc.spec.xyz.unq$tree.loc.x,
                            y = loc.spec.xyz.unq$tree.loc.y,
                            window = wndw)

plot(loc.spec.xyz.unq.ppp)
plot(density(loc.spec.xyz.unq.ppp))
rip.k <- Kest(loc.spec.xyz.unq.ppp)
rip.k
plot(rip.k)
rip.l <- Lest(loc.spec.xyz.unq.ppp)
plot(rip.l)
head(loc.spec.xyz.unq)
# using subset function
newdata <- loc.spec.xyz.unq[which(loc.spec.xyz.unq$species="Buche",)]
newdata
attach(loc.spec.xyz.unq)
species
