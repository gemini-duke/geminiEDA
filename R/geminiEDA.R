#' Run the Shiny app
#'
#' This function launches the Shiny app for generating EDA reports.
#'
#' @export
run_app <- function() {
  shiny::runApp(system.file("app", package = "geminiEDA"))
}
