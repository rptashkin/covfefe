library(png)
library(jpeg)



make_covfefe_colors<- function(path){

  # load an image
  if(grepl(".jpg", path)){
    a_file <- readJPEG(path)
  }else if (grepl(".jpeg", path)){
    a_file <- readJPEG(path)
  }else{
    a_file <- readPNG(path)
  }
  # make a matrix -- one row per pixel
  #  columns as rgb
  ff <- matrix(c(as.vector(a_file[,,1]),
                 as.vector(a_file[,,2]),
                 as.vector(a_file[,,3])),ncol=3)

  # get the unique rows == unique colours
  ff <- unique(ff)

  #grab the dominant colors from the image
  k_means <- kmeans(ff, centers = 8, iter.max = 30)

  # turn the unique rows into RGB hex values
  covfefe <- apply(k_means$centers, 1, function(x) rgb(x[1],x[2], x[3]))
  return(covfefe)
}

paths <- dir("covfefe_images",full.names=TRUE)

covfefe_colours <- lapply(paths, make_covfefe_colors)
