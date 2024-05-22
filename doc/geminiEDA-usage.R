## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ggplot2)
library(dplyr)
library(gtsummary)
library(geminiEDA)
library(ggthemes) 
library(scales)   # Add this line

## ----message=FALSE, warning=FALSE---------------------------------------------
library(ggplot2)
library(geminiEDA)

# Create a sample plot with the default theme
p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()
p

## ----message=FALSE, warning=FALSE---------------------------------------------
p + theme_GEMINI()

## ----message=FALSE, warning=FALSE---------------------------------------------
# Create a sample plot with default scales
p <- ggplot(mtcars, aes(x = factor(cyl), fill = factor(cyl))) +
  geom_bar()
p

## ----message=FALSE, warning=FALSE---------------------------------------------
p + scale_fill_GEMINI()

## ----message=FALSE, warning=FALSE---------------------------------------------
p + 
  scale_fill_GEMINI() +
  theme_GEMINI()

## ----message=FALSE, warning=FALSE---------------------------------------------
eda_univ_autoplot(mtcars, "mpg")

## ----message=FALSE, warning=FALSE---------------------------------------------
mtcars$cyl <- factor(mtcars$cyl)
eda_univ_autoplot(mtcars, "cyl")

## ----message=FALSE, warning=FALSE---------------------------------------------
eda_biv_autoplot(mtcars, "wt", "mpg")

## ----message=FALSE, warning=FALSE---------------------------------------------
eda_biv_autoplot(mtcars, "cyl", "am")

## ----message=FALSE, warning=FALSE---------------------------------------------
eda_biv_autoplot(mtcars, "cyl", "mpg")

## ----message=FALSE, warning=FALSE---------------------------------------------
eda_univ_summary(mtcars, "mpg")

## ----message=FALSE, warning=FALSE---------------------------------------------
eda_biv_summary(mtcars, "cyl", "mpg")

