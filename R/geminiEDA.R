#' Run the Shiny app
#'
#' This function launches the Shiny app for generating EDA reports.
#' It can accept a dataframe from the current environment.
#'
#' @param data Optional dataframe to use in the Shiny app.
#' @export
run_app <- function(data = NULL) {
  if (!is.null(data)) {
    assign("uploaded_data", data, envir = .GlobalEnv)
  }
  shiny::runApp(system.file("app", package = "geminiEDA"))
}
