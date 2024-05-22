#' User interface for the EDA Shiny app
#'
#' This function defines the user interface for the EDA Shiny app.
#' It includes input fields for data file, covariates, outcomes, author, and project name.
#' It also displays the generated script preview and the rendered report.
#'
#' @return The user interface for the EDA Shiny app.
#' @import shiny
#' @export

ui <- fluidPage(
  titlePanel("Generate EDA Report"),
  tabsetPanel(
    tabPanel("Report Generator",
             sidebarLayout(
               sidebarPanel(
                 fileInput("datafile", "Choose CSV File",
                           multiple = FALSE,
                           accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                 uiOutput("covarInput"), # Dynamic UI for covariates
                 uiOutput("outcomInput"), # Dynamic UI for outcomes
                 textInput("author", "Author", value = ""),
                 textInput("project", "Project Name", value = ""),
                 actionButton("generate", "Generate Report"),
                 downloadButton("downloadReport", "Download R Markdown Report") # Download button
               ),
               mainPanel(
                 # verbatimTextOutput("scriptPreview")
               )
             )
    ),
    tabPanel("Generated Report",
             fluidRow(
               column(12,
                      uiOutput("renderedReport")
               )
             )
    )
  )
)


