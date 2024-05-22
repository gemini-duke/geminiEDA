#' Run the Shiny app
#'
#' This function launches the Shiny app for generating EDA reports.
#' It can accept a dataframe from the current environment.
#'
#' @param data Optional dataframe to use in the Shiny app.
#' @export
eda_app <- function(data = NULL) {
  if (!is.null(data)) {
    dataframe_name <- deparse(substitute(data))
    assign("uploaded_data", data, envir = .GlobalEnv)
    assign("dataframe_name", dataframe_name, envir = .GlobalEnv)
  }
  shiny::runApp(system.file("app", package = "geminiEDA"))
}
