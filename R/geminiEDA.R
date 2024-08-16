#' Run the Shiny app
#'
#' This function launches the Shiny app for generating EDA reports.
#' It can accept a dataframe from the current environment.
#'
#' @param data Optional dataframe to use in the Shiny app.
#' @export
eda_app <- function(data = NULL) {
  # Create the 'styles' directory if it doesn't exist
  if (!dir.exists("styles")) {
    dir.create("styles")
  }

  # Define the path for the SCSS file
  scss_file_path <- file.path("styles", "styles.scss")

  # Create the 'styles.scss' file with default content if it doesn't exist
  if (!file.exists(scss_file_path)) {
    writeLines(
      c(
        "/*-- scss:defaults --*/",
        "// Define Duke University colors",
        "$primary: #012169; // Duke Blue",
        "$body-color: #333333; // Dark gray for body text",
        "",
        "/*-- scss:rules --*/",
        "",
        "// Apply Duke Blue to h1 and h2 titles only",
        "h1, h2 {",
        "  color: $primary !important;",
        "}",
        "",
        "// Apply dark gray (or black) to all other text elements",
        "body, h3, h4, h5, h6, p, li, blockquote, pre, code, a {",
        "  color: $body-color !important;",
        "}",
        "",
        "// Remove background and border color settings",
        ".navbar,",
        ".btn-primary,",
        ".bg-primary,",
        ".text-primary {",
        "  background-color: transparent !important;",
        "  border-color: transparent !important;",
        "}"
      ),
      scss_file_path
    )
  }

  # Assign data to global environment if provided
  if (!is.null(data)) {
    dataframe_name <- deparse(substitute(data))
    assign("uploaded_data", data, envir = .GlobalEnv)
    assign("dataframe_name", dataframe_name, envir = .GlobalEnv)
  }

  # Launch the Shiny app
  shiny::runApp(system.file("app", package = "geminiEDA"))
}
