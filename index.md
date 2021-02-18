[![R-CMD-check](https://github.com/KWB-R/kwb.orcid/workflows/R-CMD-check/badge.svg)](https://github.com/KWB-R/kwb.orcid/actions?query=workflow%3AR-CMD-check)
[![pkgdown](https://github.com/KWB-R/kwb.orcid/workflows/pkgdown/badge.svg)](https://github.com/KWB-R/kwb.orcid/actions?query=workflow%3Apkgdown)
[![codecov](https://codecov.io/github/KWB-R/kwb.orcid/branch/master/graphs/badge.svg)](https://codecov.io/github/KWB-R/kwb.orcid)
[![Project Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/kwb.orcid)]()

R package for checking ORCID use at KWB. It is a wrapper for the
R package [rorcid](https://github.com/ropensci/rorcid).

## Installation

```r                                                                                                                                          
### Optionally: specify GitHub Personal Access Token (GITHUB_PAT)"                                                                             
### See here why this might be important for you:"                                                                                             
### https://kwb-r.github.io/kwb.pkgbuild/articles/install.html#set-your-github_pat"                                                            
                                                                                                                                      
# Sys.setenv(GITHUB_PAT = \"mysecret_access_token\")"                                                                                          
                                                                                                                                      
# Install package \"remotes\" from CRAN"                                                                                                       
"if (! require(\"remotes\")) {"                                                                                                                 
 install.packages(\"remotes\", repos = \"https://cloud.r-project.org\")"                                                                      
}                                                                                                                                             
                                                                                                                                        
# Install KWB package 'kwb.orcid' from GitHub"                                                                                                 
                                                                                                                                              
remotes::install_github("kwb-r/kwb.orcid")                                                                                                  
```
