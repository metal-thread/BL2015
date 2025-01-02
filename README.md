# BL2015

The code in this repo refactors [an example from BL2015](https://www.chrisbilder.com/categorical/Chapter1/COVID19vaccine.R). There are 4 changes:

1. Remove unused variables (increase cohesion).
1. Use names to denote the intention of functions and variables (increase cohesion).
1. Encapsulate logic in each block so that it serves the same purpose (increase cohesion).
1. Reserve dots for accessing the members of an object (to [avoid confusion](https://style.tidyverse.org/syntax.html)).

See the code in [COVID19Vaccine.R](./COVID19Vaccine.R)
