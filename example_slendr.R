# Example script for slendr, dplyr, and getopt
library(slendr)
library(dplyr)
library(getopt)

spec <- matrix(c(
  'verbose', 'v', 2, 'logical',
  'help', 'h', 0, 'logical'
), byrow=TRUE, ncol=4)
opt <- getopt(spec)
if (!is.null(opt$help)) {
  cat(getopt(spec, usage=TRUE))
  q("no")
}

init_env()
model <- compile_model(
  populations = list(pop = population("pop", time = 1, N = 1000)),
  generation_time = 1,
  direction = "backward"
)
ts <- msprime(model, sequence_length = 1e6, recombination_rate = 1e-8)

summary <- ts %>%
  ts_nodes() %>%
  as_tibble() %>%
  summarise(avg_time = mean(time))
print(summary)
