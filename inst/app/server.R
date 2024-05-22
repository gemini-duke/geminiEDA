#' Server logic for the EDA Shiny app
#'
#' This function defines the server logic for the EDA Shiny app.
#' It handles file uploads and uses data passed from the environment if available.
#'
#' @return The server logic for the EDA Shiny app.
#' @import shiny
#' @export
server <- function(input, output, session) {
  data <- reactive({
    if (exists("uploaded_data", envir = .GlobalEnv)) {
      return(get("uploaded_data", envir = .GlobalEnv))
    } else if (!is.null(input$datafile)) {
      read.csv(input$datafile$datapath)
    } else {
      NULL
    }
  })

  # Create selection boxes using column names
  output$covarInput <- renderUI({
    if (is.null(data())) return(NULL)
    selectInput("covariates", "Covariates", choices = colnames(data()), multiple = TRUE)
  })

  output$outcomInput <- renderUI({
    if (is.null(data())) return(NULL)
    selectInput("outcomes", "Outcomes", choices = colnames(data()), multiple = TRUE)
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

  output$downloadReport <- downloadHandler(
    filename = function() {
      paste("EDA_Report", Sys.Date(), ".Rmd", sep = "")
    },
    content = function(file) {
      report_file <- scriptContent()
      file.copy(report_file, file)
    }
  )
}
