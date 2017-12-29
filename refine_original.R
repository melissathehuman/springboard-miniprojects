library(tidyverse)

mydata <- read_csv("refine_original.csv")

#clean up brand names
mydata$company <- gsub("Phillips|philips|phillipS|phllips|phillps|fillips|phlips", "phillips", mydata$company)

mydata$company <- gsub("Akzo|AKZO|akz0|ak zo", "azko", mydata$company)

mydata$company <- gsub("Van Houten|van Houten", "van houten", mydata$company)

mydata$company <- gsub("unilver|Unilever", "unilever", mydata$company)

#Separate the product code and product number into separate columns 
mydata <- separate(mydata, "Product code / number", c("product_code", "product_number"), sep = "-")

#add product categories (p = smartphone, v=TV, x=laptop, q=tablet)
mydata$product_category <- mydata$product_code
mydata$product_category <- if_else(
  mydata$product_category == "p", "smartphone", mydata$product_category)
mydata$product_category <- if_else(
  mydata$product_category == "v", "TV", mydata$product_category)
mydata$product_category <- if_else(
  mydata$product_category == "x", "laptop", mydata$product_category)
mydata$product_category <- if_else(
  mydata$product_category == "q", "tablet", mydata$product_category)

#Add full address for geocoding
mydata <- unite(mydata, "full_address", 4:6, sep = ", ", remove = FALSE)

#create dummy variables for company and product category
mydata <- within(mydata, {
  company_philips = if_else(company == 'philips', 1, 0)
  company_akzo = if_else(company == 'akzo', 1, 0)
  company_van_houten = if_else(company == 'van houten', 1, 0)
  company_unilever = if_else(company == 'unilever', 1, 0)
  
  product_smartphone = if_else(product_category == 'Smartphone', 1, 0)
  product_tv = if_else(product_category == 'TV', 1, 0)
  product_laptop = if_else(product_category == 'Laptop', 1, 0)
  product_tablet = if_else(product_category == 'Tablet', 1, 0)
  
})

#Save new dataset 
write.csv(mydata, file = "refine_clean.csv")
