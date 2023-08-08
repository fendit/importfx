# importfx
### Introduction
`importfx` package works similar to import function in Python.

At the start of a R script, user can decide which function(s) should be included or excluded when importing to the environment from another R script.

**Note that it is recommended to use this package at the start of running a R script (similar to Python) to prevent any current function objects in the environment being removed during importing.**

### Examples
See the package vignette [here](https://htmlpreview.github.io/?https://github.com/fendit/importfx/blob/main/vignettes/Introduction.html) for detailed information.

### Downloading package
Press the copy button below and paste the following command in your RStudio:
```
devtools::install_github("fendit/importfx")
```

### Related resources
For a non-package version please visit this repo [link here](https://github.com/fendit/import-specific-functions)

### Remarks
This package is different from existing ```import``` package (see [here](https://www.rdocumentation.org/packages/rio/versions/0.5.29/topics/import)) in terms of:
- objects to be imported
- which user-defined functions to be included or excluded when importing
