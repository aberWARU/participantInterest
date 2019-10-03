# participantInterest

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![Build Status](https://travis-ci.org/aberWARU/participantInterest.svg?branch=master)](https://travis-ci.org/aberWARU/participantInterest) [![Build status](https://ci.appveyor.com/api/projects/status/562hhs27ymfp3y94/branch/master?svg=true)](https://ci.appveyor.com/project/wilsontom/participantinterest/branch/master) [![codecov](https://codecov.io/gh/aberWARU/participantInterest/branch/master/graph/badge.svg)](https://codecov.io/gh/aberWARU/participantInterest) ![License](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg "GNU GPL v3.0")


### Installation & Usage

```R
remotes::install_github('aberWARU/participantInterest')
```


```R
library(participantInterest)

JiscExport <- readr::read_csv('example_file.csv', col_types = readr::cols())

Output <- formatExport(JiscExport)

```
