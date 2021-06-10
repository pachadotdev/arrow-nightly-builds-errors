f <- list.files(recursive = T, full.names = T, pattern = "^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]$")

for (x in f) {
  system(sprintf("gzip %s", x))
}

f <- list.files(recursive = T, full.names = T, pattern = "^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].gz$")

m <- sapply(
  f,
  function(x) {
    gsub("\\s+.*", "", system(sprintf("md5sum %s", x), intern = T))
  }
)

d <- tibble::tibble(
  log = f,
  md5sum = m
)

stopifnot(length(unique(d$md5sum)) == nrow(d))

readr::write_csv(d, "00-md5sums.csv")
