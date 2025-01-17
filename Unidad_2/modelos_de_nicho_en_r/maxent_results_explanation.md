<title>Maxent model for colliei_9</title>
<CENTER><H1>Maxent model for colliei_9</H1></CENTER>
<br> This page contains some analysis of the Maxent model for colliei_9, created Thu Aug 29 19:38:35 CST 2024 using Maxent version 3.4.4.  If you would like to do further analyses, the raw data used here is linked to at the end of this page.<br>
<br><HR><H2>Analysis of omission/commission</H2>
The following picture shows the omission rate and predicted area as a function of the cumulative threshold.  The omission rate is calculated both on the training presence records, and (if test data are used) on the test records.  The omission rate should be close to the predicted omission, because of the definition of the cumulative threshold.

Definiciones: 
<br>
**Tasa de omisión:** proportion of evaluation localities that are not correctly predicted as present, and measures model overfitting. Overfit models have omission rates higher than theoretical expectations. <br>
**Cumulative threshold:** is a chosen threshold for which a species occurrence is considered a presence or absence. <br>
Este gráfico acopaña la tabla de abajo.
<br><img src="plots\colliei_9_omission.png"><br>
<br> The next picture is the receiver operating characteristic (ROC) curve for the same data.  Note that the specificity is defined using predicted area, rather than true commission (see the paper by Phillips, Anderson and Schapire cited on the help page for discussion of what this means).  This implies that the maximum achievable AUC is less than 1.  If test data is drawn from the Maxent distribution itself, then the maximum possible test AUC would be 0.926 rather than 1; in practice the test AUC may exceed this bound.
<br><img src="plots\colliei_9_roc.png"><br>
<br>
**Explicación:** Si hay 0 especificidad, esto es 100 % del área es predicha, entonces la tasa de omision es 0, el modelo es demasiado sensible (1).
Si tengo 0 % del área predicha, entonces la tasa de omision es 1, mi modelo no es sensible. 
20 % del área predicha parece (especificidad = 0.8), parece un buen modelo, i.e., con poca área predigo mmuchos datos.

<br>
Some common thresholds and corresponding omission rates are as follows.  If test data are available, binomial probabilities are calculated exactly if the number of test samples is at most 25, otherwise using a normal approximation to the binomial.  These are 1-sided p-values for the null hypothesis that test points are predicted no better than by a random prediction with the same fractional predicted area.  The "Balance" threshold minimizes 6 * training omission rate + .04 * cumulative threshold + 1.6 * fractional predicted area.<br>
<br><table border cols=6 cellpadding=3><tr><th>Cumulative threshold</th><th>Cloglog threshold</th><th>Description</th><th>Fractional predicted area</th><th>Training omission rate</th><th>Test omission rate</th><th>P-value</th><tr align=center><td>1.000</td><td>0.013</td><td>Fixed cumulative value 1</td><td>0.498</td><td>0.000</td><td>0.000</td><td>3.766E-3</td><tr align=center><td>5.000</td><td>0.067</td><td>Fixed cumulative value 5</td><td>0.281</td><td>0.000</td><td>0.000</td><td>3.883E-5</td><tr align=center><td>10.000</td><td>0.133</td><td>Fixed cumulative value 10</td><td>0.195</td><td>0.012</td><td>0.000</td><td>2.058E-6</td><tr align=center><td>9.196</td><td>0.124</td><td>Minimum training presence</td><td>0.205</td><td>0.000</td><td>0.000</td><td>3.124E-6</td><tr align=center><td>23.293</td><td>0.336</td><td>10 percentile training presence</td><td>0.099</td><td>0.099</td><td>0.250</td><td>2.189E-5</td><tr align=center><td>23.293</td><td>0.336</td><td>Equal training sensitivity and specificity</td><td>0.099</td><td>0.099</td><td>0.250</td><td>2.189E-5</td><tr align=center><td>14.920</td><td>0.208</td><td>Maximum training sensitivity plus specificity</td><td>0.147</td><td>0.049</td><td>0.000</td><td>2.132E-7</td><tr align=center><td>18.100</td><td>0.254</td><td>Equal test sensitivity and specificity</td><td>0.125</td><td>0.086</td><td>0.125</td><td>3.407E-6</td><tr align=center><td>17.562</td><td>0.246</td><td>Maximum test sensitivity plus specificity</td><td>0.128</td><td>0.086</td><td>0.000</td><td>7.353E-8</td><tr align=center><td>5.156</td><td>0.068</td><td>Balance training omission, predicted area and threshold value</td><td>0.277</td><td>0.000</td><td>0.000</td><td>3.476E-5</td><tr align=center><td>11.522</td><td>0.153</td><td>Equate entropy of thresholded and original distributions</td><td>0.177</td><td>0.037</td><td>0.000</td><td>9.744E-7</td></table><br>
<br><HR><H2>Pictures of the model</H2>
This is a representation of the Maxent model for colliei_9.  Warmer colors show areas with better predicted conditions.  White dots show the presence locations used for training, while violet dots show test locations.  Click on the image for a full-size version.<br>
<br><a href = "plots/colliei_9.png"> <img src="plots/colliei_9.png" width=600></a><br>
<br>Click <a href=colliei_9_explain.bat type=application/bat>here<a> to interactively explore this prediction using the Explain tool.  If clicking from your browser does not succeed in starting the tool, try running the script in C:\Users\vicen\OneDrive\Escritorio\pcb_curso_2025-1_bases_ecologicas_y_genomicas\Unidad_2\maxent\colliei_9_explain.bat directly.  This tool requires the environmental grids to be small enough that they all fit in memory.<br><br>
This is the projection of the Maxent model for colliei_9 onto the environmental variables in C:\Users\vicen\OneDrive\Escritorio\pcb_curso_2025-1_bases_ecologicas_y_genomicas\Unidad_2\maxent\lgm.  Warmer colors show areas with better predicted conditions.  White dots show the presence locations used for training, while violet dots show test locations.  Click on the image for a full-size version.<br>
<br><a href = "plots/colliei_9_lgm.png"> <img src="plots/colliei_9_lgm.png" width=600></a><br>
<br>Click <a href=colliei_9_lgm_explain.bat type=application/bat>here<a> to interactively explore this prediction using the Explain tool.  If clicking from your browser does not succeed in starting the tool, try running the script in C:\Users\vicen\OneDrive\Escritorio\pcb_curso_2025-1_bases_ecologicas_y_genomicas\Unidad_2\maxent\colliei_9_lgm_explain.bat directly.  This tool requires the environmental grids to be small enough that they all fit in memory.<br><br>
The following picture shows where the prediction is most affected by variables being outside their training range, while projecting the Maxent model onto the environmental variables in C:\Users\vicen\OneDrive\Escritorio\pcb_curso_2025-1_bases_ecologicas_y_genomicas\Unidad_2\maxent\lgm.  The values shown in the picture give the absolute difference in predictions when using vs not using clamping.  (Clamping means that environmental variables and features are restricted to the range of values encountered during training.)  Warmer colors show areas where the treatment of variable values outside their training ranges is likely to have a large effect on predicted suitability.
<br><a href = "plots/colliei_9_lgm_clamping.png"> <img src="plots/colliei_9_lgm_clamping.png" width=600></a><br>
<br>The following two pictures compare the environmental similarity of variables in lgm to the environmental data used for training the model.  In the first picture (MESS), areas in red have one or more environmental variables outside the range present in the training data, so predictions in those areas should be treated with strong caution.  The second picture (MoD) shows the most dissimilar variable, i.e., the one that is furthest outside its training range.  For details, see Elith et al., Methods in Ecology and Evolution, 2010
<br><a href = "colliei_9_lgm_novel.png"> <img src="colliei_9_lgm_novel.png" width=600></a><br>
<br><a href = "colliei_9_lgm_novel_limiting.png"> <img src="colliei_9_lgm_novel_limiting.png" width=600></a><br>
<br><HR><H2>Response curves</H2>
<br>These curves show how each environmental variable affects the Maxent prediction.
The 
curves show how the predicted probability of presence changes as each environmental variable is varied, keeping all other environmental variables at their average sample value. Click on a response curve to see a larger version.  Note that the curves can be hard to interpret if you have strongly correlated variables, as the model may depend on the correlations in ways that are not evident in the curves.  In other words, the curves show the marginal effect of changing exactly one variable, whereas the model may take advantage of sets of variables changing together.<br><br>
<a href = "plots/colliei_9_bio02.png"> <img src="plots/colliei_9_bio02_thumb.png"></a>
<a href = "plots/colliei_9_bio03.png"> <img src="plots/colliei_9_bio03_thumb.png"></a>
<a href = "plots/colliei_9_bio05.png"> <img src="plots/colliei_9_bio05_thumb.png"></a>
<a href = "plots/colliei_9_bio13.png"> <img src="plots/colliei_9_bio13_thumb.png"></a>
<a href = "plots/colliei_9_bio15.png"> <img src="plots/colliei_9_bio15_thumb.png"></a>
<a href = "plots/colliei_9_bio18.png"> <img src="plots/colliei_9_bio18_thumb.png"></a>
<br>
<br>In contrast to the above marginal response curves, each of the following curves represents a different model, namely, a Maxent model created using only the corresponding variable.  These plots reflect the dependence of predicted suitability both on the selected variable and on dependencies induced by correlations between the selected variable and other variables.  They may be easier to interpret if there are strong correlations between variables.<br><br>
<a href = "plots/colliei_9_bio02_only.png"> <img src="plots/colliei_9_bio02_only_thumb.png"></a>
<a href = "plots/colliei_9_bio03_only.png"> <img src="plots/colliei_9_bio03_only_thumb.png"></a>
<a href = "plots/colliei_9_bio05_only.png"> <img src="plots/colliei_9_bio05_only_thumb.png"></a>
<a href = "plots/colliei_9_bio13_only.png"> <img src="plots/colliei_9_bio13_only_thumb.png"></a>
<a href = "plots/colliei_9_bio15_only.png"> <img src="plots/colliei_9_bio15_only_thumb.png"></a>
<a href = "plots/colliei_9_bio18_only.png"> <img src="plots/colliei_9_bio18_only_thumb.png"></a>
<br>
<br><HR><H2>Analysis of variable contributions</H2><br>
The following table gives estimates of relative contributions of the environmental variables to the Maxent model.  To determine the first estimate, in each iteration of the training algorithm, the increase in regularized gain is added to the contribution of the corresponding variable, or subtracted from it if the change to the absolute value of lambda is negative.  For the second estimate, for each environmental variable in turn, the values of that variable on training presence and background data are randomly permuted.  The model is reevaluated on the permuted data, and the resulting drop in training AUC is shown in the table, normalized to percentages.  As with the variable jackknife, variable contributions should be interpreted with caution when the predictor variables are correlated.<br>
<br><table border cols=3><tr><th>Variable</th><th>Percent contribution</th><th>Permutation importance</th><tr align=right><td>bio15</td><td>73.6</td><td>78</td></tr><tr align=right><td>bio18</td><td>15</td><td>10</td></tr><tr align=right><td>bio13</td><td>5.7</td><td>6.8</td></tr><tr align=right><td>bio05</td><td>4.3</td><td>2.6</td></tr><tr align=right><td>bio03</td><td>1.2</td><td>1.5</td></tr><tr align=right><td>bio02</td><td>0.2</td><td>1.1</td></tr></table><br><br>
The following picture shows the results of the jackknife test of variable importance.  The environmental variable with highest gain when used in isolation is bio15, which therefore appears to have the most useful information by itself.  The environmental variable that decreases the gain the most when it is omitted is bio15, which therefore appears to have the most information that isn't present in the other variables.<br>
<br><img src="plots\colliei_9_jacknife.png"><br>
<br>The next picture shows the same jackknife test, using test gain instead of training gain.  Note that conclusions about which variables are most important can change, now that we're looking at test data.
<br><img src="plots\colliei_9_jacknife_test.png"><br>
<br>Lastly, we have the same jackknife test, using AUC on test data.
<br><img src="plots\colliei_9_jacknife_auc.png"><br>
<br><HR><H2>Raw data outputs and control parameters</H2><br>
The data used in the above analysis is contained in the next links.  Please see the Help button for more information on these.<br>
<a href = "colliei_9.asc">The model applied to the training environmental layers</a><br>
<a href = "colliei_9_lgm.asc">The model applied to the environmental layers in C:\Users\vicen\OneDrive\Escritorio\pcb_curso_2025-1_bases_ecologicas_y_genomicas\Unidad_2\maxent\lgm</a><br>
<a href = "colliei_9.lambdas">The coefficients of the model</a><br>
<a href = "colliei_9_omission.csv">The omission and predicted area for varying cumulative and raw thresholds</a><br>
<a href = "colliei_9_samplePredictions.csv">The prediction strength at the training and (optionally) test presence sites</a><br>
<a href = "maxentResults.csv">Results for all species modeled in the same Maxent run, with summary statistics and (optionally) jackknife results</a><br>
<br><br>
Regularized training gain is 1.730, training AUC is 0.951, unregularized training gain is 1.919.<br>
Unregularized test gain is 1.733.<br>
Test AUC is 0.940, standard deviation is 0.017 (calculated as in DeLong, DeLong & Clarke-Pearson 1988, equation 2).<br>
Algorithm converged after 340 iterations (0 seconds).<br>
<br>
The follow settings were used during the run:<br>
81 presence records used for training, 8 for testing.<br>
10076 points used to determine the Maxent distribution (background points and presence points).<br>
Environmental layers used (all continuous): bio02 bio03 bio05 bio13 bio15 bio18<br>
Regularization values: linear/quadratic/product: 0.104, categorical: 0.250, threshold: 1.190, hinge: 0.500<br>
Feature types used: linear quadratic<br>
responsecurves: true<br>
jackknife: true<br>
outputdirectory: C:\Users\vicen\OneDrive\Escritorio\pcb_curso_2025-1_bases_ecologicas_y_genomicas\Unidad_2\maxent<br>
projectionlayers: C:\Users\vicen\OneDrive\Escritorio\pcb_curso_2025-1_bases_ecologicas_y_genomicas\Unidad_2\maxent\lgm<br>
samplesfile: C:\Users\vicen\OneDrive\Escritorio\pcb_curso_2025-1_bases_ecologicas_y_genomicas\Unidad_2\maxent\colliei_20km_thin1.csv<br>
environmentallayers: C:\Users\vicen\OneDrive\Escritorio\pcb_curso_2025-1_bases_ecologicas_y_genomicas\Unidad_2\maxent\present<br>
randomseed: true<br>
skipifexists: true<br>
betamultiplier: 1.5<br>
replicates: 10<br>
product: false<br>
hinge: false<br>
autofeature: false<br>
Command line used: <br>
<br>
