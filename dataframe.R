library(readxl)
library(dplyr)
library(openxlsx)

folder_path <- "C:/Users/AKHNA/Desktop/MCA/R/data"
excel_files <- list.files(folder_path, pattern = "\\.xlsx?$", full.names = T, ignore.case = T)

files <- lapply(excel_files, read_excel)

df <- read_excel("C:/Users/AKHNA/Desktop/MCA/R/data/train.xlsx")

required_columns <- c("Loan_ID", "Gender", "Married", "Dependents", "Education", "Self-Employed", "Applicant_Income", "Coapplicant_Income", "Loan_Amount", "Loan_Amount_Term", "Credit_History", "Loan_Status", "Property_Area")

process_file <- function(file){
  df <- read_excel(file)
  if(ncol(df) != length(required_columns)){
    df$Loan_Status <- NA_character_
    df <- df %>% relocate(Loan_Status, .before = Property_Area)
    colnames(df) <- required_columns
  }else{
    df <- df %>% relocate(Loan_Status, .before = PropertyArea)
    colnames(df) <- required_columns
    
  }
  
  return(df)
}

processed_files <- lapply(excel_files, process_file)

final_data <- bind_rows(processed_files)
View(final_data)


write.xlsx(x = final_data, file = "C:/Users/AKHNA/Desktop/MCA/R/final_data.xlsx")



