# Download data from databases
library(rgbif)
library(maps)

# Set a working directory
setwd("C:/Users/vicen/OneDrive/Escritorio/pcb_curso_2025-1_bases_ecologicas_y_genomicas/PCB-2025-1-Bases-ecologicas-y-genomicas/Unidad_2/modelos_de_nicho_en_r")

species_gbif <- c("Amblycercus holosericeus",
                  "Attila spadiceus",
                  "Automolus ochrolaemus",
                  "Basileuterus culicivorus",
                  "Cardinalis cardinalis"
                  # "Cercomacroides tyrannina",
                  # "Chlorophanes spiza",
                  #  "Coereba flaveola"
                  )

vector_names <- c()
species_reference_number  <- c()
for (i in seq_along(species_gbif)) {
  vector_nam <- paste0("species_", i)
  vector_names <- c(vector_names, vector_nam)
  species_reference_number <- c(species_reference_number ,c(paste(vector_nam, species_gbif[i])))
}

## Check Objects
# vector_names
# species_reference_number

# download GBIF occurrence data for these species; this may take a long time if there are many data points!
for (i in seq_along(species_gbif)) { 
  gbif_data <- occ_data(scientificName = species_gbif[i], hasCoordinate = TRUE, limit = 10000)  # decrease the 'limit' if you just want to see how many records there are without waiting all the time that it will take to download the whole dataset
  assign(vector_names[i], gbif_data)
  print(paste0(i))
}

#Objects
vector_names[3]
species_3


# NOTES
# if, for any species, "Records found" is larger than "Records returned", you need to increase the 'limit' argument above -- see help(occ_data) for options and limitations
# get the DOI for citing these data properly:

# if your species are widespread but you want to work on a particular region, you can download records within a specified window of coordinates:
#gbif_data <- occ_data(scientificName = myspecies, hasCoordinate = TRUE, limit = 20000) #, decimalLongitude = "-10, 10", decimalLatitude = "35, 55")  # note that coordinate ranges must be specified this way: "smaller, larger" (e.g. "-5, -2")
#gbif_data

# check how the data are organized:


# create and fill a list with only the 'data' section for each species:

for (i in seq_along(vector_names)) {
  get_gbif <- get(vector_names[i])
  coords <- get_gbif$data[ , c("decimalLongitude", "decimalLatitude", "year")]
  myspecies_coords_list <- data.frame(species = species_gbif[i], coords)
  #lapply(myspecies_coords_list, head)
  
  # collapse the list into a data frame:
  myspecies_coords <- as.data.frame(myspecies_coords_list)
  
  assign(paste0(vector_names[i],"_table") , myspecies_coords)
}

# Names
species_5_table

write.table(species_5_table,  file = "results/species_5.csv", sep=",")
cardi<-read.csv("results/species_5.csv", head=T, sep=",")
cardi_df<- as.data.frame (cardi)
cardi_db<-select(cardi_df, species, decimalLatitude,	decimalLongitude, year)
cardi_db_sub<-subset(cardi_db, year>= 1950) 

