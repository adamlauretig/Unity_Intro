# Toy function for ASC unity demo
# Paste a number and a letter together
# Output: a data_table
# Author: Adam Lauretig
# 2017
library(parallel)
library(data.table)
load("~/fake_data.rdata") # note that we're using short filepaths

paste_number_letter <- function(i = NULL, letter_vector = NULL){
  data.table(paste0(letter_vector[i], "_", i))
}

length_of_letters <- length(fake_data)

function_out <- mclapply(1:length_of_letters, paste_number_letter, 
  letter_vector = fake_data, mc.cores = 3)

toy_dt <- rbindlist(function_out)

save(toy_dt, file = "~/toy_dt.rdata")