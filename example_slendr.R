library(slendr)
library(dplyr)

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
