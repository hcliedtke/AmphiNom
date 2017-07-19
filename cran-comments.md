## Test environments
* local OS X install, R 3.4.0 (2017-04-21)
* ubuntu 14.04.5 LTS (on travis-ci), R 3.4.0
* win-builder (devel and release)


## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* checking data for non-ASCII characters ... NOTE
  Note: found 83 marked Latin-1 strings
  Note: found 71 marked UTF-8 strings

Example files contain names of people and locations with non-ASCII characters.

## Downstream dependencies
I have also run R CMD check on downstream dependencies of defrostR 
(https://github.com/hcliedtke/defrostR.Rcheck).
