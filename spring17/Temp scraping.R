# # AL jan
# https://www.ncdc.noaa.gov/cag/time-series/us/01/00/tavg/1/01/2001-2017.csv?base_prd=true&begbaseyear=1901&endbaseyear=2000
# 
# # AK jan
# https://www.ncdc.noaa.gov/cag/time-series/us/50/00/tavg/1/01/2001-2017.csv?base_prd=true&begbaseyear=1925&endbaseyear=2000
# 

library(curl)

out <- state <- month <- vector()
for(i in 49:50){
  for(j in 1:12){
  url <- paste("https://www.ncdc.noaa.gov/cag/time-series/us/",
               formatC(i, width = 2, flag = "0"),
               "/00/tavg/1/",
                 formatC(j, width = 2, flag = "0"),
                 "/2001-2016.csv?base_prd=true&begbaseyear=1925&endbaseyear=2000",
                 sep = "")
  con <- curl(url)
  xx <- readLines(con)
  close(con)
  
  x1 <- strsplit(xx[1], ",")
  out <- c(out, xx[6:21])
  state <- c(state, rep(x1[[1]][1], length(xx[6:21])))
  month <- c(month, rep(x1[[1]][3], length(xx[6:21])))
  cat(j, " . ")
  }
cat(i, "\n")
}

xx <- strsplit(out, ",")

dat <- data.frame(state, month, yrmo = as.character(unclass(lapply(xx, function(x) x[1]))),
                         avgt = as.numeric(unclass(lapply(xx, function(x) x[2])))                )

write.csv(dat, file = "data/Avg T by State by Month.csv", row.names = F)
