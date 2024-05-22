# geminiEDA

`geminiEDA` is an R package that provides a Shiny app for conducting Exploratory Data Analysis (EDA) on a given dataset. The app allows users to upload a CSV file, select covariates and outcomes of interest, and generate an interactive EDA report in HTML format.

## Features

- Upload a CSV file containing the dataset for analysis
- Select multiple covariates and outcomes for EDA
- Generate an interactive HTML report with univariate and bivariate analysis
- Customize the report with a title, author name, and project name
- View and download the generated R Markdown script for reproducibility

## Installation

You can install the `geminiEDA` package from GitHub using the `devtools` package:

```r
# Install devtools if not already installed
install.packages("devtools")

# Install geminiEDA from GitHub
devtools::install_github("gemini-duke/geminiEDA")
```

## Main usage

To launch the Shiny app, you have two options: running the app with a provided data object or running the app without providing a data object (in which case you will upload a CSV file within the app).

### Option 1: Running the App with a Data Object

You can provide a data object directly when launching the app. This is useful if you already have a dataset loaded in your R environment.

```r
library(geminiEDA)

# Example dataframe
my_data <- data.frame(
  var1 = rnorm(100),
  var2 = rnorm(100),
  outcome = rnorm(100)
)

# Run the Shiny app with the dataframe
eda_app(my_data)
```

### Option 2: Running the App without a Data Object

If you prefer to upload your dataset within the app, simply run the app without any arguments.

```r
library(geminiEDA)
eda_app()
```

This will open the app in your default web browser.

### Using the App

In both scenarios, once the app is open:

1. **If you did not provide a data object**: Upload a CSV file containing your dataset.
2. Select the desired covariates and outcomes for analysis.
3. Enter a title, author name, and project name for the report (optional).
4. Click the "Generate Report" button to generate the EDA report.
5. View the generated report in the "Generated Report" tab.
6. Optionally, download the generated R Markdown script for further customization or reproducibility.

By following these steps, you can easily generate an Exploratory Data Analysis report either by directly using a data object from your R environment or by uploading a CSV file through the app.

## Vignettes
For more detailed examples and usage instructions, see the package vignettes:

```r
browseVignettes(package = "geminiEDA")
```

## Contributing

Contributions to the `geminiEDA` package are welcome! If you find any bugs, have suggestions for improvements, or would like to add new features, please open an issue or submit a pull request on the GitHub repository.

## License

This package is licensed under the MIT License. See the `LICENSE` file for more information.

## Acknowledgments

The `geminiEDA` package was developed by Joao Vitor Perez de Souza as part of the GEMINI group.
