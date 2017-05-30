library(tidyverse)

df <- read.csv('refine_original.csv', stringsAsFactors = FALSE)
# df <- read_csv('refine_original.csv')

# rename all spelling errors
df[1:6,1] = "philips"
df[7:13,1] = "akzo"
df[14:16,1] = "phillips"
df[17:21,1] = "van houten"
df[22:25,1] = "unilever"

# Separate product code and number
df <- separate(df,Product.code...number, into = c("product_code", "product_number"))

# Add product categories

prod_code <- df$product_code

prod_cate <- prod_code

prod_cate[prod_code == 'p'] <- 'Smartphone'
prod_cate[prod_code == 'v'] <- 'TV'
prod_cate[prod_code == 'x'] <- 'Laptop'
prod_cate[prod_code == 'q'] <- 'Tablet'

df['product_category'] <- prod_cate


# full address for geocoding
df['full_address'] <- paste(df$address, df$city, df$country, sep = ', ')


# MB: fix a column name issue
col_names <- names(df)
col_names[1] <- 'company'
names(df) <- col_names

# adding dummy variables for companies
company <- df$company

df['company_philips'] <- if_else(df$company == 'philips', 1, 0)
df['company_van_houten'] <- if_else(df$company == 'van houten', 1, 0)
df['company_akzo'] <- if_else(df$company == 'akzo', 1, 0)


# adding dummy variables for products
product_name <- df$product_category

df['product_smartphone'] <- if_else(df$product_category == 'Smartphone', 1, 0)
df['product_tv'] <- if_else(df$product_category == 'TV', 1, 0)
df['product_laptop'] <- if_else(df$product_category == 'Laptop', 1, 0)
df['product_tablet'] <- if_else(df$product_category == 'Tablet', 1, 0)

# writing data as csv file
write.csv(df, file = 'refine_clean.csv')


