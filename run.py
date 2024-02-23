import rpy2.robjects as robjects
import rpy2.robjects.packages as rpackages
from rpy2.robjects.vectors import StrVector

# import R's utility package
utils = rpackages.importr('utils')

# select a mirror for R packages
utils.chooseCRANmirror(ind=1) # select the first mirror in the list

# R package names
packnames = ('devtools', 'tidyverse', 'tsibble', 'forecast', 'tsfeatures', 'smooth', 'Rcatch22', 'glmnet')

# Selectively install what needs to be install.
# We are fancy, just because we can.
names_to_install = [x for x in packnames if not rpackages.isinstalled(x)]
if len(names_to_install) > 0:
    utils.install_packages(StrVector(names_to_install))

r = robjects.r
r.source('run.R')

calculate_features = robjects.r['calculate_features']

do_fixed_horizon_local_forecasting = robjects.r['do_fixed_horizon_local_forecasting']
do_fixed_horizon_global_forecasting = robjects.r['do_fixed_horizon_global_forecasting']

do_fixed_horizon_local_forecasting("bitcoin_without_missing", "ses", "bitcoin_dataset_without_missing_values.tsf", "series_name", "start_timestamp", 8)
do_fixed_horizon_global_forecasting("bitcoin_without_missing", 25, "bitcoin_dataset_without_missing_values.tsf", "pooled_regression", "series_name", "start_timestamp", 8)
