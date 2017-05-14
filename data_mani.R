library(tidyverse)
library(tidyr)
library(dplyr)
#blank create mirror files 
refine_original <- read.csv('refine_original.csv')

#working file 

datafile <- read.csv('refine_original.csv')


# rename all spelling errors
datafile[1:6,1] = "philips"
datafile[7:13,1] = "akzo"
datafile[14:16,1] = "phillips"
datafile[17:21,1] = "van houten"
datafile[22:25,1] = "unilever"

# Separate product code and number
datafile <- separate(datafile,Product.code...number, into = c("product_code", "product_number"))

# Add product categories
prod_cate <- c()
prod_code <- datafile$product_code

for (i in 1:nrow(datafile)) {
  if (prod_code[i] == 'p') {
    prod_cate[i] <- 'Smartphone'
  }
  if (prod_code[i] == 'v') {
    prod_cate[i] <- 'TV'
  }
  if (prod_code[i] == 'x') {
    prod_cate[i] <- 'Laptop'
  }
  if (prod_code[i] == 'q') {
    prod_cate[i] <- 'Tablet'
  }
}

datafile['product_category'] <- prod_cate

# full address for geocoding
full_address <- c()
address <- df$address
city <- df$city
country <- df$country

for (i in 1:nrow(df)) {
  full_address[i] <- paste0(address[i],', ', city[i], ', ', country[i])
}

datafile['full_address'] <- full_address

# adding dummy variables for companies
company <- datafile$company

zeroes <- rep(0, nrow(datafile))
phillip_index <- which(company == 'philips')
zeroes[phillip_index] <- 1
datafile['company_philips'] <- zeroes

zeroes <- rep(0, nrow(datafile))
van_houten_index <- which(company == 'van houten')
zeroes[van_houten_index] <- 1
datafile['company_van_houten'] <- zeroes

zeroes <- rep(0, nrow(datafile))
akzo_index <- which(company == 'akzo')
zeroes[akzo_index] <- 1
df['company_akzo'] <- zeroes

zeroes <- rep(0, nrow(datafile))
unilever_index <- which(company == 'unilever')
zeroes[unilever_index] <- 1
df['company_unilever'] <- zeroes

# adding dummy variables for products
product_name <- datafile$product_category

zeroes <- rep(0, nrow(datafile))
smartphone_index <- which(product_name == 'Smartphone')
zeroes[smartphone_index] <- 1
df['product_smartphone'] <- zeroes

zeroes <- rep(0, nrow(datafile))
tv_index <- which(product_name == 'TV')
zeroes[tv_index] <- 1
datafile['product_tv'] <- zeroes

zeroes <- rep(0, nrow(datafile))
tablet_index <- which(product_name == 'Tablet')
zeroes[tablet_index] <- 1
datafile['product_tablet'] <- zeroes

zeroes <- rep(0, nrow(datafile))
laptop_index <- which(product_name == 'Laptop')
zeroes[laptop_index] <- 1
datafile['product_laptop'] <- zeroes

# writing data as csv file
write.csv(datafile, file = 'refine_clean.csv')


