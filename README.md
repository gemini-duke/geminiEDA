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
devtools::install_github("yourusername/geminiEDA")
```

Replace `"yourusername"` with your actual GitHub username.

## Usage

To launch the Shiny app, run the following code in your R console:

```r
library(geminiEDA)
run_app()
```

This will open the app in your default web browser.

In the app:

1. Upload a CSV file containing your dataset
2. Select the desired covariates and outcomes for analysis
3. Enter a title, author name, and project name for the report (optional)
4. Click the "Generate Report" button to generate the EDA report
5. View the generated report in the "Generated Report" tab
6. Optionally, download the generated R Markdown script for further customization or reproducibility

## Examples

Here's an example of how to use the `geminiEDA` package to generate an EDA report:

```r
library(geminiEDA)

# Load example dataset
data(iris)
write.csv(iris, "iris.csv", row.names = FALSE)

# Run the app
run_app()
```

In the app, upload the `iris.csv` file, select the desired covariates and outcomes, and click "Generate Report" to create an EDA report for the iris dataset.

## Contributing

Contributions to the `geminiEDA` package are welcome! If you find any bugs, have suggestions for improvements, or would like to add new features, please open an issue or submit a pull request on the GitHub repository.

## License

This package is licensed under the MIT License. See the `LICENSE` file for more information.

## Acknowledgments

The `geminiEDA` package was developed by [Your Name] as part of the [GEMINI project]. Special thanks to the contributors and the open-source community for their valuable input and support.
