#enmeval

#libraries
library(raster)
library(stringr)
library(sp)
library(dismo)
library(ENMeval)
library(rJava)

# Manual
# https://jamiemkass.github.io/ENMeval/articles/ENMeval-2.0-vignette.html#select

install.packages("ENMeval")
## Stack de variables
species.subset.vars <- raster::subset(wlclim_stack, c("bio02","bio03", "bio05","bio13", "bio15","bio18"))

# cut all  with  calibration area
total_areas_calibration_stack <- crop(species.subset.vars, extent(colliei_aream))
plot(total_areas_calibration_stack)
total_areas_calibration_stack_mask <- mask(total_areas_calibration_stack, colliei.formosa.psilorhinus)
plot(total_areas_calibration_stack_mask)

# Stack proyeccion
#total_areas_calibration_stack

#cacicus_puntos de presencia data frame
# table_colliei_thin

bg <- dismo::randomPoints(total_areas_calibration_stack[[1]], n = 10000) %>% as.data.frame()
colnames(bg) <- colnames(table_colliei_thin[ , c(1,2)])

#evaluar los parámetros
# Importante tener fit and test data
enmeval_colliei<- ENMevaluate(occs = table_colliei_thin[ , c(1,2)], 
                           envs = total_areas_calibration_stack, 
                           bg = bg, 
                           algorithm = 'maxnet', partitions = 'block', 
                           tune.args = list(fc = c("L", "Q", "P", "H", "LP", "LQ"), 
                                            rm = seq(0.5, 4, 0.5)))
# Overlap betwween models
overlap <- calc.niche.overlap(enmeval_hfus@predictions, overlapStat = "D")
# D Shoener: Index between 0 and 1, 1 for identical models.

# plot average validation AUC and omission rates for the models we tuned.
evalplot.stats(e = enmeval_hfus, stats = c("or.mtp", "auc.val"), color = "fc", x.var = "rm", 
               error.bars = FALSE)

res <- eval.results(enmeval_hfus)
# Select the model with delta AICc equal to 0, or the one with the lowest AICc score.
# In practice, models with delta AICc scores less than 2 are usually considered 
# statistically equivalent.
opt.aicc <- res %>% filter(delta.AICc == 0)
opt.aicc

opt.seq <- res %>% 
  filter(or.10p.avg == min(or.10p.avg)) %>% 
  filter(auc.val.avg == max(auc.val.avg))

mod.seq <- eval.models(enmeval_hfus)[[opt.seq$tune.args]]
# Here are the non-zero coefficients in our model.
mod.seq$betas

# And these are the marginal response curves for the predictor variables wit non-zero 
# coefficients in our model. We define the y-axis to be the cloglog transformation, which
# is an approximation of occurrence probability (with assumptions) bounded by 0 and 1
# (Phillips et al. 2017).
plot(mod.seq, type = "cloglog")

#guardar la tabla de resultados
write.csv(enmeval_hfus@results, file="hfusc_enmeval.csv")

