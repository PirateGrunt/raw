---
title: "The raw Package"
layout: page
order: 30
---

I've created a package called `raw` for use with this workshop. The package contains data sets which should be of general interest to actuaries and make good illustrations. In addition, the package may be used to install other packages which you'll want.

To install it, enter these lines into the R console:

```
install.packages("devtools")
devtools::install_github("PirateGrunt/raw@package", dependencies = TRUE)
```

Read about the data [here](../Data).

This package is not yet on CRAN. Given that it's primarily a repository for data, it may never see a CRAN release.