#Skript von Harald basierend auf: JSOn Data über API mit meheren Pages: https://cran.r-project.org/web/packages/jsonlite/vignettes/json-paging.html
#Schleife zum fetchen der Daten



install.packages("jsonlite")
install.packages('curl')

library(jsonlite)

  
baseurl <- "http://api.nestoria.de/api?listing_type=rent&country=de&encoding=json&action=search_listings&south_west=52.424826,13.121796&north_east=52.593664,13.6"
pages <- list()
for(i in 0:50){
  mydata <- fromJSON(paste0(baseurl, "&page=", i))
  message("Retrieving page ", i)
  pages[[i+1]] <- mydata$response$listings
}

#combine all into one
angebote_berlin2 <- rbind.pages(pages)



#check output
nrow(angebote_berlin2)


#Exportieren der Daten

write.csv2(angebote_berlin2, "berlin.csv")
#umwandlung einer spalte von char in numeric und mergen der spalte an anderen datafram mit cbind
size_numeric <- as.numeric(angebote_berlin2$size)
Berlin2 <- cbind(angebote_berlin2,size_numeric)

