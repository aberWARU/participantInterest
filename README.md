# participantInterest

[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) [![R build status](https://github.com/aberWARU/participantInterest/workflows/R-CMD-check/badge.svg)](https://github.com/aberWARU/participantInterest/actions) [![codecov](https://codecov.io/gh/aberWARU/participantInterest/branch/master/graph/badge.svg)](https://codecov.io/gh/aberWARU/participantInterest) ![License](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg "GNU GPL v3.0")


### Installation & Usage

```R
remotes::install_github('aberWARU/participantInterest')
```


```R
library(participantInterest)

JiscExport <- readr::read_csv('example_file.csv', col_types = readr::cols())

Output <- formatExport(JiscExport)

```
