#' Generate an R Markdown script for Exploratory Data Analysis (EDA)
#'
#' This function generates an R Markdown script for conducting Exploratory Data Analysis (EDA)
#' on a given dataset. The script includes sections for univariate and bivariate analysis of
#' specified covariates and outcomes.
#'
#' @param filename The name of the output R Markdown file.
#' @param covariates A character vector of covariate names to include in the EDA.
#' @param outcomes A character vector of outcome names to include in the EDA.
#' @param author The author of the EDA report.
#' @param project The name of the project or analysis.
#'
#' @return None. The function writes the generated R Markdown script to the specified file.
#'
#' @examples
#' populate_script("eda_report.Rmd", c("age", "gender"), c("income", "score"), "John Doe", "My Analysis")
#'
#' @import glue
#' @import geminiEDA
#' @importFrom utils head
#'
#' @export
populate_script <- function(filename, covariates, outcomes, author, project) {
  con <- file(filename, "w")

  writeLines(glue("---
title: '{project}'
author: '{author}'
date: '`r Sys.Date()`'
output:
  html_document:
    highlight: 'textmate'
    code_folding: show
    code_download: true
    toc: true
    toc_depth: 5
    toc_float:
      collapsed: false
      smooth_scroll: false
    theme:
      font-family: 'Roboto'
      code-font-size: '0.9em'
      background: '#ffffff'
      text-color: '#333333'
      link-color: '#3498db'
      code-background: '#F9F9F9'
      border-left-color: '#3498db'
      border-bottom-color: '#dddddd'
      header-background: '#ffffff'
      header-border-bottom: '3px solid #3498db'
      navbar-background: '#3498db'
---"), con)


  # Writing the initial comments and loading libraries
  writeLines("
```{r, message=FALSE, warning=FALSE, echo=FALSE}
library('tidyverse')
library('gtsummary')
library('ggthemes')
library('scales')
```", con)

  writeLines("
```{r, warning=FALSE, echo=FALSE}
message('This is an auto-generated R script')
```", con)


  ## EDA
  writeLines("# EDA
", con)

  ### Covariates
  writeLines("## Covariates
", con)
  for (cov in covariates){

    writeLines(glue("### {cov}

Variable Name: {cov}

Description:

Variable Type: xxx

Value Range: xxx

Coding: xxx

Measurement Unit: xxx

Data Processing Details: xx


Plot

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_univ_autoplot(data(), '{cov}')
```

Table

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_univ_summary(data(), '{cov}')
```


                    "), con)

  }

  ### Outcomes
  writeLines("## Outcomes
", con)
  for (out in outcomes){
    writeLines(glue("### {out}

Variable Name: {out}

Description:

Variable Type: xxx

Value Range: xxx

Coding: xxx

Measurement Unit: xxx

Data Processing Details: xx


Plot

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_univ_autoplot(data(), '{out}')
```

Table

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_univ_summary(data(), '{out}')
```



                    "), con)

  }

  ### Bi-variate
  writeLines("## Bi-variate analysis
", con)
  for (out in outcomes){
    for (cov in covariates){
      writeLines(glue("### {out} x {cov}


Plot

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_biv_autoplot(data(), '{cov}', '{out}')
```

Table

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_biv_summary(data(), '{cov}', '{out}')
```
                      "), con)
    }
  }

  close(con)

}

#' Generate R Markdown Script for EDA Report
#'
#' This function creates an R Markdown script for an Exploratory Data Analysis (EDA) report.
#' The script includes univariate and bivariate analyses based on selected covariates and outcomes.
#'
#' @param filename Character. The file path to save the R Markdown script.
#' @param covariates Character vector. The selected covariates for the EDA.
#' @param outcomes Character vector. The selected outcomes for the EDA.
#' @param author Character. The author of the report.
#' @param project Character. The project name.
#' @param data_name Character. The name of the dataframe to be used in the EDA report.
#'
#' @return NULL. This function is used for its side effects of writing to a file.
#'
#' @examples
#' \dontrun{
#' populate_script_download("report.Rmd", covariates = c("age", "gender"),
#'                          outcomes = c("income"), author = "John Doe",
#'                          project = "Sample Project", data_name = "my_data")
#' }
#' @import glue
#' @import geminiEDA
#' @importFrom utils head
#'
#' @export
populate_script_download <- function(filename, covariates, outcomes, author,
                                     project, data_name) {
  con <- file(filename, "w")

  writeLines(glue("---
title: '{project}'
author: '{author}'
date: '`r Sys.Date()`'
output:
  html_document:
    highlight: 'textmate'
    code_folding: show
    code_download: true
    toc: true
    toc_depth: 5
    toc_float:
      collapsed: false
      smooth_scroll: false
    theme:
      font-family: 'Roboto'
      code-font-size: '0.9em'
      background: '#ffffff'
      text-color: '#333333'
      link-color: '#3498db'
      code-background: '#F9F9F9'
      border-left-color: '#3498db'
      border-bottom-color: '#dddddd'
      header-background: '#ffffff'
      header-border-bottom: '3px solid #3498db'
      navbar-background: '#3498db'
---"), con)


  # Writing the initial comments and loading libraries
  writeLines("
```{r, message=FALSE, warning=FALSE, echo=FALSE}
library(tidyverse)
library(gtsummary)
library(ggthemes)
library(scales)
library(geminiEDA)
```", con)

  writeLines("
```{r, warning=FALSE, echo=FALSE}
message('This is an auto-generated R script')
```", con)


  ## EDA
  writeLines("# EDA
", con)

  ### Covariates
  writeLines("## Covariates
", con)
  for (cov in covariates){

    writeLines(glue("### {cov}

Variable Name: {cov}

Description:

Variable Type: xxx

Value Range: xxx

Coding: xxx

Measurement Unit: xxx

Data Processing Details: xx


Plot

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_univ_autoplot({data_name}, '{cov}')
```

Table

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_univ_summary({data_name}, '{cov}')
```


                    "), con)

  }

  ### Outcomes
  writeLines("## Outcomes
", con)
  for (out in outcomes){
    writeLines(glue("### {out}

Variable Name: {out}

Description:

Variable Type: xxx

Value Range: xxx

Coding: xxx

Measurement Unit: xxx

Data Processing Details: xx


Plot

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_univ_autoplot({data_name}, '{out}')
```

Table

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_univ_summary({data_name}, '{out}')
```



                    "), con)

  }

  ### Bi-variate
  writeLines("## Bi-variate analysis
", con)
  for (out in outcomes){
    for (cov in covariates){
      writeLines(glue("### {out} x {cov}


Plot

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_biv_autoplot({data_name}, '{cov}', '{out}')
```

Table

```{{r, echo=FALSE, warning=FALSE, message=FALSE}}
eda_biv_summary({data_name}, '{cov}', '{out}')
```
                      "), con)
    }
  }

  close(con)

}

