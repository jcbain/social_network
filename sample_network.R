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
s<-t[sample(nrow(t),100),]
net<-graph.data.frame(t, directed=T)
V(net)
E(net)
degree(net)
plot(net)
bad.vs<-V(net)[degree(net)<100]
bsk.network<-delete.vertices(net, bad.vs)
plot(bsk.network)

#https://www.r-project.org/conferences/useR-2008/slides/Csardi.pdf
is.connected(net) 
no.clusters(net)
table(clusters(net)$csize)
max(degree(net, mode="in")) 
max(degree(net, mode="out")) 
max(degree(net, mode="all"))
plot(degree.distribution(net, mode="out"), log="xy")


cl <- clusters(net)
net2 <- subgraph(net, which(cl$membership == which.max(cl$csize)-1)-1)
summary(net2)
graph.density(net2) 
g <- erdos.renyi.game(vcount(net), ecount(net), type="gnm")
transitivity(g)
transitivity(net)
g2 <- degree.sequence.game(degree(net,mode="all"), method="vl")
transitivity(g2)


fc <- fastgreedy.community(simplify(as.undirected(net)))
memb<- community.to.membership(net,fc$merges,whic.max(fc$modularity))
lay <- layout.drl(net)
net2 <- graph.empty(n=vcount(net))
colbar <- rainbow(5)
col <- colbar[memb$membership+1]
col[is.na(col)] <- "grey"
plot(net2, layout=lay, vertex.size=1,
    vertex.label=NA, asp=FALSE,
    vertex.color=col,
    vertex.frame.color=col)

# scale free network
g <- barabasi.game(10000)
#to look up
# http://horicky.blogspot.com/2012/04/basic-graph-analytics-using-igraph.html