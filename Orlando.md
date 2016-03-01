---
title: "Orlando"
layout: page
order: 5
---

## Getting ready for the seminar

Candidates are expected to have R and RStudio installed prior to arrival. Although we'll try to help people work through any installation issues, everything will work much more smoothly if you try to install before you get to Dallas. Please contact me using the details in the introductory e-mail you should have received. Basic installation instructions may be found under the [Installations](../Installation) tab of this website.

In addition, you will need to run a short script to install a set of packages that we'll use. 

```
install.packages("devtools")
devtools::install_github("PirateGrunt/raw@package", dependencies = TRUE)
```

You must be connected to the internet for this to work. Further, you may have an issue if you have a firewall or something which restricts access to particular sites. On my machine this took quite a while. There will be various messages and warnings that might look scary. Don't worry.

If this doesnt work, don't panic. Give me a call and I'll try to sort things out before you get to Florida.
