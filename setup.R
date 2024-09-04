suppressPackageStartupMessages({
  library(here)
  library(readr)
  library(readxl)
  library(dplyr)
  library(ggplot2)
})

here::i_am("setup.R")

for (f in list.files("functions", full.names = TRUE)){
  source(f)
}
