package_df <- read.csv(file.path("./", "packages.csv"))
package_list <- as.character(package_df$Package)
install.packages(package_list)