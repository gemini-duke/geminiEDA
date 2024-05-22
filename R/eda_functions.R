#' Set a custom GEMINI theme for ggplot2 plots
#'
#' This function applies a custom GEMINI theme to ggplot2 plots, adjusting elements like text, background, axes, and legends to fit a predefined style.
#' @param base_size Base font size for the plot elements (default is 14).
#' @param base_family Base font family for the plot text (default is "helvetica").
#' @return A ggplot2 theme object that can be added to ggplot plots.
#' @import ggplot2 ggthemes
#' @export
theme_GEMINI <- function(base_size=14, base_family="helvetica") {
  (ggthemes::theme_foundation(base_size=base_size, base_family=base_family) +
     theme(
       plot.title = element_text(face = "bold", size = rel(1.2), hjust = 0.5, color = "#333333"),
       text = element_text(color = "#333333"),
       panel.background = element_rect(fill = "white", colour = NA),
       plot.background = element_rect(fill = "white", colour = NA),
       panel.border = element_rect(fill = NA, colour = "#333333", linewidth = 0.5),
       axis.title = element_text(face = "plain", size = rel(1), color = "#333333"),
       axis.title.y = element_text(angle=90, vjust = 2),
       axis.title.x = element_text(vjust = -0.2),
       axis.text = element_text(color = "#333333"),
       axis.line = element_line(colour="#333333"),
       axis.ticks = element_line(color = "#333333"),
       panel.grid.major = element_line(colour="#f0f0f0"),
       panel.grid.minor = element_blank(),
       legend.key = element_rect(fill = "white", colour = "#f0f0f0"),
       legend.position = "bottom",
       legend.direction = "horizontal",
       legend.key.size= unit(0.2, "cm"),
       legend.margin = unit(0, "cm"),
       legend.title = element_text(face="plain", color = "#333333"),
       plot.margin = unit(c(10, 10, 10, 10), "mm"),
       strip.background = element_rect(fill="white", colour="#f0f0f0", linewidth=0.5),
       strip.text = element_text(face="bold", color = "#333333")
     ) +
     theme(legend.key = element_blank()))
}

#' Set a custom fill scale for ggplot2 plots in the GEMINI style
#'
#' This function defines a custom fill color scale for ggplot2 plots according to the GEMINI style, using a predefined set of colors.
#' @param ... Additional parameters passed to `discrete_scale()`.
#' @return A ggplot2 scale object for fill aesthetics.
#' @export
scale_fill_GEMINI <- function(...){
  discrete_scale("fill", "Nature",
                 manual_pal(values = c("#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3", "#a6d854", "#ffd92f", "#e5c494", "#b3b3b3")),
                 ...)
}

#' Set a custom color scale for ggplot2 plots in the GEMINI style
#'
#' This function defines a custom color scale for ggplot2 plots according to the GEMINI style, using a predefined set of colors.
#' @param ... Additional parameters passed to `discrete_scale()`.
#' @return A ggplot2 scale object for color aesthetics.
#' @export
scale_colour_GEMINI <- function(...){
  discrete_scale("colour", "Nature",
                 manual_pal(values = c("#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#666666")),
                 ...)
}



#' Create a univariate plot based on variable type
#'
#' Generates a univariate plot for a specified variable in the dataset, distinguishing between numeric and categorical variables.
#' @param data The dataset containing the variable.
#' @param var The name of the variable to plot.
#' @return A ggplot2 object displaying the histogram or bar plot based on the variable type.
#' @export
eda_univ_autoplot <- function(data, var) {
  # Check if variable is numeric, binary, or categorical
  var_type <- ifelse(is.numeric(data[[var]]) & length(unique(data[[var]])) > 2, "numeric",
                     ifelse(length(unique(data[[var]])) == 2, "categorical", "categorical"))

  # Create plot based on variable type
  if (var_type == "numeric") {
    # Histogram plot for numeric variables
    hist_plot <- ggplot(data, aes(x = !!sym(var))) +
      geom_histogram(binwidth = 1) +
      theme_GEMINI() +
      labs(title = paste("Histogram plot of", var))

    print(hist_plot)

  } else if (var_type == "categorical") {
    # Barplot for categorical variables
    bar_plot <- ggplot(data, aes(x = !!sym(var), fill = (var))) +
      geom_bar() +
      theme_GEMINI() +
      labs(title = paste("Bar plot of", var))

    print(bar_plot)
  }
}

#' Create a univariate plot based on variable type
#'
#' Generates a univariate plot for a specified variable in the dataset, distinguishing between numeric and categorical variables.
#' @param data The dataset containing the variable.
#' @param var The name of the variable to plot.
#' @return A ggplot2 object displaying the histogram or bar plot based on the variable type.
#' @export
eda_biv_autoplot <- function(data, covar, out) {
  # Identify the types of the covariate and outcome
  covar_type <- ifelse(is.numeric(data[[covar]]) & length(unique(data[[covar]])) > 2, "numeric",
                       ifelse(length(unique(data[[covar]])) == 2, "categorical", "categorical"))
  out_type <- ifelse(is.numeric(data[[out]]) & length(unique(data[[out]])) > 2, "numeric",
                     ifelse(length(unique(data[[out]])) == 2, "categorical", "categorical"))


  # Create plot based on variable types
  if (covar_type == "numeric" & out_type == "numeric") {
    # Scatterplot for numeric x numeric
    scatter_plot <- data %>%
      ggplot(aes(x = !!sym(covar), y = !!sym(out))) +
      geom_point() +
      theme_GEMINI() +
      labs(title = paste("Scatter plot of", covar, "vs", out))

    print(scatter_plot)

  } else if (covar_type == "categorical" & out_type == "categorical") {
    # Barplot for categorical x categorical
    bar_plot <- data %>%
      ggplot(aes(x = !!sym(covar), fill = !!sym(out))) +
      geom_bar(position = "stack") +
      theme_GEMINI() +
      scale_fill_GEMINI() +
      labs(title = paste("Bar plot of", covar, "vs", out))

    print(bar_plot)

  } else if ((covar_type == "categorical" & out_type == "numeric")) {
    # Raincloud plot for categorical x numeric
    raincloud_plot <- data %>%
      ggplot(aes(y = !!sym(covar), x = !!sym(out), fill=!!sym(covar))) +
      ggdist::stat_halfeye(
        adjust = .5,
        width = .6,
        .width = 0,
        justification = -.3,
        point_colour = NA) +
      geom_boxplot(
        width = .25,
        outlier.shape = NA
      ) +
      geom_point(
        size = 1.5,
        alpha = .2,
        position = position_jitter(
          seed = 1, width = .1
        )
      ) +
      coord_cartesian(clip = "off") +
      labs(title = paste("Raincloud plot of", covar, "vs", out)) +
      theme_GEMINI() +
      scale_fill_GEMINI()

    print(raincloud_plot)
  } else if ((covar_type == "numeric" & out_type == "categorical")) {
    # Raincloud plot for categorical x numeric
    raincloud_plot <- data %>%
      ggplot(aes(y = !!sym(out), x = !!sym(covar), fill=!!sym(out))) +
      ggdist::stat_halfeye(
        adjust = .5,
        width = .6,
        .width = 0,
        justification = -.3,
        point_colour = NA) +
      geom_boxplot(
        width = .25,
        outlier.shape = NA
      ) +
      geom_point(
        size = 1.5,
        alpha = .2,
        position = position_jitter(
          seed = 1, width = .1
        )
      ) +
      coord_cartesian(clip = "off") +
      labs(title = paste("Raincloud plot of", covar, "vs", out)) +
      theme_GEMINI() +
      scale_fill_GEMINI()

    print(raincloud_plot)
  }
}


#' Create a univariate summary table based on variable type
#'
#' Generates a summary table for a specified variable in the dataset, distinguishing between numeric and categorical variables.
#' @param data The dataset containing the variable.
#' @param var The name of the variable to summarize.
#' @return A gtsummary table object with appropriate statistics for the variable type.
#' @export
eda_univ_summary <- function(data, var) {
  # Check if variable is numeric, binary, or categorical
  var_type <- ifelse(is.numeric(data[[var]]) & length(unique(data[[var]])) > 2, "numeric",
                     ifelse(length(unique(data[[var]])) == 2, "categorical", "categorical"))

  # Create summary based on variable type
  if (var_type == "numeric") {
    # Numeric summary
    table_numeric <- data %>%
      select(!!sym(var)) %>%
      tbl_summary(
        type = list(!!sym(var) ~ "continuous2"),
        statistic = list(all_continuous() ~ c("{mean} ({sd})", # Display mean and standard deviation for continuous variables
                                              "{median} ({p25}, {p75})",
                                              "{min}, {max}"))) %>%
      bold_labels() %>%
      tbl_butcher()

    return(table_numeric)

  } else if (var_type == "categorical") {
    # Categorical summary
    table_categorical <- data %>%
      select(!!sym(var)) %>%
      tbl_summary(
        type = list(!!sym(var) ~ "categorical"),
        statistic = list(all_categorical() ~  "{n} / {N} ({p}%)")) %>%
      bold_labels() %>%
      tbl_butcher()

    return(table_categorical)
  }
}

#' Create a bivariate summary table based on variable types
#'
#' Generates a summary table comparing two variables in the dataset based on their types (numeric or categorical).
#' @param data The dataset containing the variables.
#' @param covar The name of the covariate variable.
#' @param out The name of the outcome variable.
#' @return A gtsummary table object with statistics based on the types of the covariate and outcome variables.
#' @export
eda_biv_summary <- function(data, covar, out) {
  # Identify the types of the covariate and outcome
  covar_type <- ifelse(is.numeric(data[[covar]]) & length(unique(data[[covar]])) > 2, "numeric",
                       ifelse(length(unique(data[[covar]])) == 2, "categorical", "categorical"))

  # Create summary based on variable type
  if (covar_type == "numeric") {
    # Numeric summary by outcome
    table_numeric_by_out <- data %>%
      select(!!sym(covar), !!sym(out)) %>%
      tbl_summary(
        by = !!sym(out),
        type = list(!!sym(covar) ~ "continuous2"),
        statistic = list(all_continuous() ~ c("{mean} ({sd})", # Display mean and standard deviation
                                              "{median} ({p25}, {p75})",
                                              "{min}, {max}"))) %>%
      bold_labels() %>%
      tbl_butcher()

    return(table_numeric_by_out)

  } else if (covar_type == "categorical") {
    # Categorical summary by outcome
    table_categorical_by_out <- data %>%
      select(!!sym(covar), !!sym(out)) %>%
      tbl_summary(
        by = !!sym(out),
        type = list(!!sym(covar) ~ "categorical"),
        statistic = list(all_categorical() ~  "{n} / {N} ({p}%)")) %>%
      bold_labels() %>%
      tbl_butcher()

    return(table_categorical_by_out)
  }
}

