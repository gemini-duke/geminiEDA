#' Server logic for the EDA Shiny app
#'
#' This function defines the server-side logic for the EDA Shiny app.
#' It handles data input, reactive expressions, and rendering of the generated report.
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @return The server function for the EDA Shiny app.
#' @importFrom shiny reactive reactiveValues renderUI renderText renderUI
#' @import shiny glue rmarkdown
#' @export


server <- function(input, output, session) {

  # Reactive expression for the dataset
  dataset <- reactive({
    inFile <- input$datafile
    if (is.null(inFile)) return(NULL)
    read.csv(inFile$datapath)
  })

  # Create selection boxes using column names
  output$covarInput <- renderUI({
    if (is.null(dataset())) return(NULL)
    selectInput("covariates", "Covariates", choices = colnames(dataset()), multiple = TRUE)
  })

  output$outcomInput <- renderUI({
    if (is.null(dataset())) return(NULL)
    selectInput("outcomes", "Outcomes", choices = colnames(dataset()), multiple = TRUE)
  })

  scriptContent <- eventReactive(input$generate, {
    # Retrieve selected covariates and outcomes
    covariates <- input$covariates
    outcomes <- input$outcomes

    # Retrieve author, project name, and file name
    author <- input$author
    project <- input$project

    # Generate the script
    temp_file <- tempfile(fileext = ".Rmd")
    populate_script(temp_file, covariates, outcomes, author, project)
    return(temp_file)
  })

  # Preview the script (optional and might not be perfect for long scripts)
  output$scriptPreview <- renderText({
    if (is.null(scriptContent())) return(NULL)
    readLines(scriptContent(), warn = FALSE)
  })

  # Render the generated report
  output$renderedReport <- renderUI({
    if (is.null(scriptContent())) return(NULL)
    tryCatch(
      {
        # Render the generated script using rmarkdown
        rendered_report <- rmarkdown::render(scriptContent(), output_format = "html_document")

        # Display the rendered report
        includeHTML(rendered_report)
      },
      error = function(e) {
        # Handle the error, e.g., display an error message
        HTML(paste("Error occurred while rendering the report:", e$message))
      }
    )
  })
}
