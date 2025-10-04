# GENE FLOW - FROM D.YAKUBA TO D. MELANOGASTER WITH NO BOTTLENECK

# Load packages
library(slendr)
library(dplyr)
library(reticulate)

# Set working directory to the mounted volume
setwd("/opt/uio")

# Initiate environment
init_env()

# Set seed for the run
seed <- 1005
seed

# Parameters (scaled down for quick testing)
seq_len <- 1e5 # reduced from 1e6
rec_rate <- 1e-8 # recombination rate
mut_rate <- 1e-9 # mutation rate
name <- "geneflow_P3toP1_Nobn_small"
chr_name <- "Chr1"

# Model
#
#                       /\
#                      /  \
#                     /\   \
#                    /  \   \
#                   /    \   \
#                  /\     \   \
#                 /<-\-----\   \
#                p1  p2    p3  out
#
# p1: Drosophila melanogaster
# p2: D. simulans
# p3: D. yakuba
# Out: D. eugracilis (Outgroup)
# *: Bottleneck
# -->: Gene flow

# Set populations for my simulation (reduced N for quick testing)
# Divergence time are set according to Suvorov et al. 2022
eugracilis <- population("eugracilis", time = 9.9e6, N = 10000)
yakuba <- population("yakuba", time = 7e6, N = 10000, parent = eugracilis)
simulans <- population("simulans", time = 3.3e6, N = 10000, parent = yakuba)
melano <- population("melano", time = 3.3e6, N = 10000, parent = yakuba)

# Gene flow event - P3 (yakuba) to P1 (melano)
# rate: 0-1 specifying the proportion of migration over given time period
gf <- gene_flow(from = yakuba,
                to = melano,
                start = 1.9e6,
                end = 1.8e6,
                rate = 0.2)

# Compile model - Gene flow
# Generationn time for drosophila is aprox 0.1 (10 generation a year)
drosophila_gf_p3p1 <- compile_model(populations = list(eugracilis, yakuba, simulans, melano), # nolint: line_length_linter.
                                    gene_flow = gf,
                                    generation_time = 0.1)

# Samples from the model (reduced to 5 per pop for quick testing)
samples_gf_p3p1 <- schedule_sampling(drosophila_gf_p3p1,
                                     times = 0,
                                     list(melano, 5),
                                     list(yakuba, 5),
                                     list(simulans, 5),
                                     list(eugracilis, 5))

# Run simulation with msprime
cat("Starting msprime simulation...\n")  # For progress visibility
msprime_gf_p3p1 <- msprime(drosophila_gf_p3p1,
                           sequence_length = seq_len,
                           recombination_rate = rec_rate,
                           samples = samples_gf_p3p1,
                           random_seed = seed,
                           verbose = TRUE)
cat("msprime simulation completed.\n")

msprime_gf_p3p1

# Mutate the sequences
msprime_gf_p3p1 <- ts_mutate(msprime_gf_p3p1, mut_rate, random_seed = seed)
msprime_gf_p3p1

# Save tree sequence to a file
ts_name <- paste0(name, ".trees")
ts_write(msprime_gf_p3p1, ts_name)

# Save as vcf file (already using ts_vcf() here)
vcf_name <- paste0(name, ".vcf.gz")
ts_vcf(msprime_gf_p3p1, vcf_name, chrom = chr_name, individuals = NULL)
cat("Main VCF generated with ts_vcf():", vcf_name, "\n")

# F4 calculations
# Populations (adjusted for fewer samples)
melano_pop <- paste0("melano_", 1:5)
simulans_pop <- paste0("simulans_", 1:5)
yakuba_pop <- paste0("yakuba_", 1:5)
eugracilis_pop <- paste0("eugracilis_", 1:5)

# F4
cal_f4 <- ts_f4(ts = msprime_gf_p3p1,
                W = melano_pop,
                X = simulans_pop,
                Y = yakuba_pop,
                Z = eugracilis_pop)
cal_f4

# Write table with results
table_name <- paste0(name, "_F4.csv")
write.table(cal_f4, table_name)

## Extract ancestry proportions

# Extract tracts
drosophila_tracts <- ts_tracts(msprime_gf_p3p1, census = 1.9e6)
drosophila_tracts

# Table with ancestry proportions
summary_tracts <- drosophila_tracts %>%
  group_by(name, node_id, pop, source_pop) %>%
  summarise(prop = sum(length) / seq_len)
summary_tracts

# Write table with results
table_tracts <- paste0(name, "_AncestryProportions.csv")
write.table(summary_tracts, table_tracts)

# Demo: Use ts_vcf() on a non-slendr tree sequence (improved in slendr >=1.1.0)
cat("Demo: Testing ts_vcf() on a direct msprime (non-slendr) tree sequence...\n")
msprime_py <- import("msprime")  # Access msprime directly via reticulate
simple_ts <- msprime_py$sim_ancestry(samples = 2, sequence_length = 1e5, random_seed = 42)
simple_ts <- msprime_py$mutate(simple_ts, rate = 1e-9, random_seed = 42)  # Add mutations for non-empty VCF
simple_vcf_name <- "simple_non_slendr.vcf.gz"
ts_vcf(simple_ts, simple_vcf_name, chrom = "test_chr")
cat("Demo VCF generated with ts_vcf() on non-slendr ts:", simple_vcf_name, "\n")
