% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_eda_markdown.R
\name{populate_script}
\alias{populate_script}
\title{Generate an R Markdown script for Exploratory Data Analysis (EDA)}
\usage{
populate_script(filename, covariates, outcomes, author, project)
}
\arguments{
\item{filename}{The name of the output R Markdown file.}

\item{covariates}{A character vector of covariate names to include in the EDA.}

\item{outcomes}{A character vector of outcome names to include in the EDA.}

\item{author}{The author of the EDA report.}

\item{project}{The name of the project or analysis.}
}
\value{
None. The function writes the generated R Markdown script to the specified file.
}
\description{
This function generates an R Markdown script for conducting Exploratory Data Analysis (EDA)
on a given dataset. The script includes sections for univariate and bivariate analysis of
specified covariates and outcomes.
}
\examples{
populate_script("eda_report.Rmd", c("age", "gender"), c("income", "score"), "John Doe", "My Analysis")

}
