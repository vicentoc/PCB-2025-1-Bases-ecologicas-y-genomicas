# Nicho, Filogenias y comunidades. 

required.libraries <- c("ape", "picante", 
                        "pez", "phytools",
                        "vegan", "adephylo", 
                        "phylobase", "geiger", 
                        "mvMORPH", "OUwie", 
                        "hisse", "BAMMtools",
                        "phylosignal", "Biostrings",
                        "devtools","ggplot2", 
                        "kableExtra", "betapart", "gridExtra",
                        "reshape2")

needed.libraries <- required.libraries[!(required.libraries %in% installed.packages()[,"Package"])]
if(length(needed.libraries)) install.packages(needed.libraries)

# Load all required libraries at once
lapply(required.libraries, require, character.only = TRUE)

### Install ggtree from BiocManager

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree")

set.seed(1)

#############################################################
# Download files from Marc Cadotte's and Jonathan Davies' book 
# "Phylogenies in Ecology: A guide to concepts and methods":
# https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1461-0248.2009.01307.x

##############################
library(ape)

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

sequences_community_yp <- read.GenBank(genebank_access, seq.names = FALSE, species.names = TRUE,
                                       as.character = FALSE, chunk.size = 400, quiet = TRUE)

# cHANGE NAMES
names(sequences_community_yp) <- Species_names 

write.FASTA(sequences_community_yp, "sequences_community_yp", header = NULL, append = FALSE)

###########
tree.primates <- read.tree(text="((((Homo:0.21, Pongo:0.21):0.28, Macaca:0.49):0.13, 
                           Ateles:0.62):0.38, Galago:1.00);")
tree.primates

# A class phylo object distributes the information of phylogenetic trees into six main components:
str(tree.primates)

# species or units
tree.primates$tip.label

# There is a little error in the tip labels, right? We can easily rewrite the labels with this:
tree.primates$tip.label <- c("Homo", "Pongo", "Macaca", "Ateles", "Galago")

# number of nodes  
tree.primates$Nnode

# plot the tree
plot(tree.primates, 
     edge.width = 2, 
     label.offset = 0.05, 
     type = "cladogram")

nodelabels()
tiplabels()
add.scale.bar()

# to keep track of the internal and external nodes of the tree:  
tree.primates$edge
# Amd the length
tree.primates$edge.length

#########################################################################


# Pagel’s δ time-dependent model rescales a tree by 
# raising all node depths to an estimated power greater than 1 (δ). 
#A value greater than 1 means that recent evolution has been relatively fast; 
# and if delta is less than 1, recent evolution has been comparatively slow.

library(geiger)
tree.Ult1 <- rcoal(25)
tree.Ult1.Delta.01 <- rescale(tree.Ult1, 
                              model = "delta", 0.1) # Setting power of 0.1
tree.Ult1.Delta.1 <- rescale(tree.Ult1, 
                             model = "delta", 1) # with power 1; compare this tree with the original tree
tree.Ult1.Delta.10 <- rescale(tree.Ult1, 
                              model = "delta", 10) # with power 10

# Representing all three trees

par(mfrow = c(1,3), cex.main = 2)

plot(tree.Ult1.Delta.01, 
     show.tip.label = FALSE,
     edge.width = 2,
     cex = 2,
     main = expression(paste("A) ", delta," = 0.1")))

plot(tree.Ult1.Delta.1, 
     show.tip.label = FALSE,
     edge.width = 2,
     cex = 2,
     main = expression(paste("B) ", delta," = 1")))

plot(tree.Ult1.Delta.10, 
     show.tip.label = FALSE,
     edge.width = 2,
     cex = 2,
     main = expression(paste("C) ", delta," = 10")))

# Note how δ
# δ captures changes in the rate of trait evolution through time
# = 1 returns the original tree, δ
# < 1 extends the branch lengths of the edges
# > 1 shortens the edge lengths of the tree.

###############################
#Pagel’s κ
# punctuational (speciational) model of trait evolution 
# focus on the number of speciation events between species 
# to assess whether different rates of evolution 
# are associated with branching events. 
# This transformation raises all branch lengths to an estimated power.

# κ is often interpreted in terms of a model where character change is 
# more or less concentrated at speciation events. 
# For this interpretation to be valid, we have to assume that the phylogenetic tree, 
# as given, includes all (or even most) of the speciation events in the history of the clade. 
# The problem with this assumption is that speciation events are almost certainly missing 
# due to sampling: perhaps some living species from the clade have not been sampled, 
# or species that are part of the clade have gone extinct before the present day 
# and are thus not sampled. 

tree.Ult1.kappa.01 <- rescale(tree.Ult1, 
                              model = "kappa", 0.1) # Kappa of 0.1
tree.Ult1.kappa.1 <- rescale(tree.Ult1, 
                             model = "kappa", 1) # Kappa of 1
tree.Ult1.kappa.2 <- rescale(tree.Ult1, 
                             model = "kappa", 2) # Kappa of 2

# Represent these trees

par(mfrow = c(1,3), 
    cex.main = 2)

plot(tree.Ult1.kappa.01, 
     show.tip.label = FALSE,
     edge.width = 2,
     cex = 2,
     main = expression(paste("D) ", kappa," = 0.0001")))
# when κ=0, all branch lengths are one. 
# Each speciation event is accompanied with a lot of change.

plot(tree.Ult1.kappa.1, 
     show.tip.label = FALSE,
     edge.width = 2,
     cex = 2,
     main = expression(paste("E) ", kappa," = 1")))

# When the κ parameter is one, the tree is unchanged 
# and still has a constant-rate Brownian motion process.

plot(tree.Ult1.kappa.2, 
     show.tip.label = FALSE,
     edge.width = 2,
     cex = 2,
     main = expression(paste("F) ", kappa," = 10")))
# Each speciation event is accompanied with no change.


# λ is often used to measure the “phylogenetic signal” in comparative data. 
# λ scales the tree between:
# λ=1 constant-rates model 
# λ=0 every species is statistically independent of every other species in the tree. 

tree.Ult1.lambda.01 <- rescale(tree.Ult1, model = "lambda", 0.1)
tree.Ult1.lambda.05 <- rescale(tree.Ult1, model = "lambda", 0.5)
tree.Ult1.lambda.1 <- rescale(tree.Ult1, model = "lambda", 1)

par(mfrow = c(1,3), 
    cex.main = 2)

plot(tree.Ult1.lambda.01, 
     show.tip.label = FALSE,
     edge.width = 2,
     cex = 2,
     main = expression(paste("G) ", lambda," = 0.1")))

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
# results from an OU model with a high α parameter (see below), 
# which is a model where trait evolution away from the optimal value is, in fact, highly constrained.

############################################################

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

#########################
library(phytools)

data(sunfish.tree)
data(sunfish.data)
## set colors for mapped discrete character
cols<-setNames(c("blue","red"),
               levels(sunfish.data$feeding.mode))
plotTree(sunfish.tree,ftype="i",fsize=0.5,color="darkgrey",
         offset=0.5)

ecomorph_sunfish<-as.factor(getStates(sunfish.tree,"tips"))

tiplabels(pie=to.matrix(ecomorph_sunfish[sunfish.tree$tip.label],
                        levels(ecomorph_sunfish)),piecol=cols,cex=0.3)

phylomorphospace(sunfish.tree,sunfish.data[,3:2],
                 colors=cols,bty="l",ftype="off",node.by.map=TRUE,
                 node.size=c(0.8,1.5),xlab="relative buccal length",
                 ylab="relative gape width")
title(main="Phylomorphospace of buccal morphology in Centrarchidae",
      font.main=3)


###



