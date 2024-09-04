# Filogenias 
library (ape)

# Vector de nombres.
Species_names <- c("Amblycercus_holosericeus",
                   "Arremonops_chloronotus",
                   "Arremonops_rufivirgatus",
                   "Attila_spadiceus",
                   "Automolus_ochrolaemus",
                   "Basileuterus_culicivorus",	
                   "Campylorhynchus_yucatanicus",
                   "Cardinalis_cardinalis",
                   "Caryothraustes_poliogaster",	
                   "Cercomacroides_tyrannina")

# Vector de secuencias.
genebank_access <- c(	"AF099355.1",
                      "FJ547295.1",
                      "FJ547294.1",
                      "FJ175963.1",
                      "HM449831.1",
                      "AF281022.1",
                      "MZ380576",
                      "JF795728",
                      "EF529915.1",
                      "FJ175897")

# From GenenBank
sequences_community_yp <- read.GenBank(genebank_access, seq.names = FALSE, species.names = TRUE)
# cHANGE NAMES
names(sequences_community_yp) <- Species_names 
# Save in different formats
write.FASTA(sequences_community_yp, "sequences_community_yp", header = NULL, append = FALSE)

#####
# Netwick format
tree.primates <- read.tree(text="((((Homo:0.21, Pongo:0.21):0.28, Macaca:0.49):0.13, AteleLs:0.62):0.38, Galago:1.00);")
# Descripcion del objeto
tree.primates
# A class phylo object distributes the information of phylogenetic trees into six main components:
str(tree.primates)

# plot the tree
plot(tree.primates, 
     edge.width = 2, 
     label.offset = 0.05, 
     type = "cladogram")

nodelabels()
tiplabels()
add.scale.bar()

# species or units
tree.primates$tip.label
#Rewrite the labels with this:
tree.primates$tip.label <- c("Homo", "Pongo", "Macaca", "Ateles", "Galago")

# number of nodes  
tree.primates$Nnode

# to keep track of the internal and external nodes of the tree:  
tree.primates$edge

# Amd the length
tree.primates$edge.length

tree.primates2 <- drop.tip(tree.primates, "Galago")

# plot the tree
plot(tree.primates2, 
     edge.width = 2, 
     label.offset = 0.05, 
     type = "cladogram")

nodelabels()
tiplabels()
add.scale.bar()

############
# To plot a much bigger phylogeny
############################################################
# Install ggtree from BiocManager

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ggtree")

library(ggtree)
library(ggplot2)

data(chiroptera, package="ape")

# Separate the genus names from species names
groupInfo <- split(chiroptera$tip.label, 
                   gsub("_\\w+", "", chiroptera$tip.label))

head(groupInfo)

# # Group species accordingly to their genera 
chiroptera <- groupOTU(chiroptera, 
                       groupInfo)

# Plot tree using ggtree
ggtree(chiroptera, 
       aes(color = group), 
       layout='circular') + 
  geom_tiplab(size = 1, 
              aes(angle = angle)) +
  theme(legend.position="NULL") 

##############
library(geiger)
# λ is often used to measure the “phylogenetic signal” in comparative data. 
# λ scales the tree between:
# λ=1 when Brownian motion fits well to the data
# λ=0 every species is statistically independent of every other species in the tree. 

tree.Ult1.lambda.01 <- rescale(tree.Ult1, model = "lambda", 0.01)
tree.Ult1.lambda.05 <- rescale(tree.Ult1, model = "lambda", 0.5)
tree.Ult1.lambda.1 <- rescale(tree.Ult1, model = "lambda", 1)

par(mfrow = c(1,3), 
    cex.main = 2)

plot(tree.Ult1.lambda.01, 
     show.tip.label = FALSE,
     edge.width = 2,
     cex = 2,
     main = expression(paste("G) ", lambda," = 0.01")))

plot(tree.Ult1.lambda.05, 
     show.tip.label = FALSE,
     edge.width = 2,
     cex = 2,
     main = expression(paste("H) ", lambda," = 0.5")))

plot(tree.Ult1.lambda.1, 
     show.tip.label = FALSE,
     edge.width = 2,
     cex = 2,
     main = expression(paste("I) ", lambda," = 1")))

# However, there is some danger is in attributing a statistical result – 
# either phylogenetic signal or not – to any particular biological process. 
# For example, phylogenetic signal is sometimes called a “phylogenetic constraint.” 
# But one way to obtain a high phylogenetic signal (λ near 1) is to evolve traits under 
# a Brownian motion model, which involves completely unconstrained character evolution. 
# Likewise, a lack of phylogenetic signal – which might be called “low phylogenetic constraint”
# results from an OU model with a high α parameter, 
# which is a model where trait evolution away from the optimal value is, in fact, highly constrained.

############
data(sunfish.tree)
sunfish.tree

ggtree(sunfish.tree, 
  layout='circular') + 
  geom_tiplab(size = 3, 
              aes(angle = angle)) +
  theme(legend.position="NULL") 

data(sunfish.data)
sunfish.data

## set colors for mapped discrete character
cols<-setNames(c("blue","red"),
               levels(sunfish.data$feeding.mode))
plotTree(sunfish.tree,ftype="i",fsize=0.5,color="darkgrey",
         offset=0.5)

ecomorph_sunfish<-as.factor(getStates(sunfish.tree,"tips"))

tiplabels(pie=to.matrix(ecomorph_sunfish[sunfish.tree$tip.label],
                        levels(ecomorph_sunfish)),piecol=cols,cex=0.3)

phylomorphospace(sunfish.tree,sunfish.data[,3:2],
                 colors=cols,bty="l",ftype="off", node.by.map=TRUE,
                 node.size=c(0.8,1.5),xlab="relative buccal length",
                 ylab="relative gape width")
title(main="Phylomorphospace of buccal morphology in Centrarchidae",
      font.main=1)




