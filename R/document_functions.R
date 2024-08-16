
#' Generate a Quarto Reveal.js Presentation Document
#'
#' This function generates a Quarto presentation document in the Reveal.js format, based on an EDA (Exploratory Data Analysis) report created by a Shiny app. The resulting presentation is ready for use and can be further edited if needed.
#'
#' @param file_path Character. The file path to the EDA report (in .qmd format) on which the presentation will be based.
#'
#' @return NULL. This function does not return a value; instead, it creates a new Quarto presentation document as a side effect.
#'
#' @details The function reads the specified EDA report, extracts relevant sections and metadata (title, author, date), and compiles them into a new Quarto document with a Reveal.js format. The generated presentation file is named `presentation_<basename>.qmd`, where `<basename>` is the original file name without its extension.
#'
#' @examples
#' \dontrun{
#' generate_revealjs_presentation("path_to_file.qmd")
#' }
#'
#' @import glue
#' @import geminiEDA
#' @importFrom utils head
#' @export
generate_revealjs_presentation <- function(file_path) {
  lines <- readLines(file_path)
  labels <- grep("^#\\| label:", lines, value = TRUE)
  labels <- sub("^#\\| label: (.+)$", "\\1", labels)
  title_line <- sub("^title: ", "", lines[grepl("^title:", lines)])
  author_line <- sub("^author: ", "", lines[grepl("^author:", lines)])
  date_line <- sub("^date: ", "", lines[grepl("^date:", lines)])

  # Generate the output file path with a .qmd extension
  output_file_path <- paste0("presentation_", tools::file_path_sans_ext(basename(file_path)), ".qmd")

  # Open a connection to the output file
  con <- file(output_file_path, "wt")

  # Write the YAML header to the file
  writeLines(c(
    "---",
    paste("title:", title_line),
    paste("author:", author_line),
    paste("date:", date_line),
    "format:",
    "  revealjs:",
    "    theme: simple",
    "editor: visual",
    "embed-resources: true",
    "html-table-processing: none",
    "---"
  ), con)

  # Write the content for each label
  for (label in labels) {
    writeLines(c(
      paste("##", label),
      "",
      paste0("{{< embed ", basename(file_path), "#", label, " >}}"),  # Using relative path
      "",
      ""
    ), con)
  }

  # Close the connection to the file
  close(con)
}
