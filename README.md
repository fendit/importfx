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
devtools::install_github("fendit/importfx", build_vignettes = TRUE)
```

### Related resources
For a non-package version please visit this repo [link here](https://github.com/fendit/import-specific-functions)

### Remarks
- This package is an alternative to existing ```import``` package (see [here](https://www.rdocumentation.org/packages/rio/versions/0.5.29/topics/import)), which provides more functionality than this package (in terms of import objects other than functions to the environment). While creating this package, I have neither reviewed nor consulted from the existing package. 
- Both functions in this package produce unexpected results if there is a print/cat command with the word "function" as part of a string in R script that functions are imported from. Thus, use these functions with caution.
