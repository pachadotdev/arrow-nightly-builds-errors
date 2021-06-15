library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)
library(wesanderson)

f <- list.files(recursive = T, full.names = T, pattern = "^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].gz$")

d2 <- enframe(
  grep("java-jars|test-conda-python-3.7-turbodbc-latest|test-conda-python-3.7-turbodbc-master|test-conda-python-3.8-spark-master|test-ubuntu-18.04-r-sanitizer|ubuntu-groovy-amd64", f, value = T)
)

d2 <- d2 %>%
  separate(value, c("root", "build", "date"), sep = "/") %>%
  select(-root) %>%
  mutate(date = as.Date(gsub("\\.gz", "", date)), value = 1)

ggplot(d2) +
  geom_col(aes(x = date, y = value, fill = build)) +
  scale_fill_manual(values = wes_palette("Zissou1"), name = "Platform") +
  labs(x = "Date", y = "Number of Build Errors", title = "Build Errors on Crossbow") +
  theme_minimal(base_size = 13)
