#create new repo for this project 
library(usethis)

use_git()
git_default_branch_rename()
use_github() #will open browser to new repo

#create new folder
dir.create("data")
dir.create("scratch")
dir.create("reports")
dir.create("docs")

#download data 
download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")

#create scratch script
file.edit("scratch/lesson3.R") #saves and opens new script in RStudio with that name and saved in that folder
