setwd('~/Desktop/Spring 2016/Data Mining/project/')

library(linkcomm)
head(lesmiserables)

lc <- getLinkCommunities(lesmiserables, hcmethod = "single")
plot(lc, type = "graph", layout = layout.fruchterman.reingold)
plot(lc, type = "graph", layout = "spencer.circle")
plot(lc, type = "graph", layout = "spencer.circle", shownodesin = 3)
plot(lc, type = "members")
cc <- getCommunityCentrality(lc)
head(sort(cc, decreasing = TRUE))
head(lc$numclusters)
cm <- getCommunityConnectedness(lc, conn = "modularity")
plot(lc, type = "commsumm", summary = "modularity")

## expirement with my data ##

frame<- read.csv('data/YouTube-dataset/data/group-edges.csv', header = FALSE)
lc <- getLinkCommunities(frame, hcmethod = "single")
plot(lc, type = "graph", layout = layout.fruchterman.reingold)
saveRDS(lc, 'data/youtube_group.rds')
cc <- getCommunityCentrality(lc)
head(sort(cc, decreasing = TRUE))
head(lc$numclusters)
cm <- getCommunityConnectedness(lc, conn = "modularity")


# Load the igraph package (install if needed)

# the following example comes from this page (http://www.r-bloggers.com/network-visualization-in-r-with-the-igraph-package/)

require(igraph)

bsk<-read.table("http://www.dimiter.eu/Data_files/edgesdata3.txt", sep='\t', dec=',', header=T)
bsk.network<-graph.data.frame(bsk, directed=F)
V(bsk.network)
E(bsk.network)
degree(bsk.network)
plot(bsk.network)


require(igraph)
# igraph with youtube data
t<-read.csv('data/YouTube-dataset/data/edges.csv',header = FALSE)
net<-graph.data.frame(t, directed=T)
V(net)
E(net)
degree(net)
plot(net)
bad.vs<-V(net)[degree(net)<100]
bsk.network<-delete.vertices(net, bad.vs)
plot(bsk.network)

g2 <- make_full_graph(4) + (make_full_graph(4) - path(1,2))
predict_edges(g2)
