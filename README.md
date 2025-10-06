# Slendr-container
This repository provides a Dockerfile starting from a rocker/geospatial:4.4.3 image to run slendr-1.2.0

The corresponding container is available on `quay.io/jeani/slendr:main`

A file `example.R` is also included here for testing, place it in your *current directory* and run it as follows with Docker (typically on your laptop) or Singularity/Apptainer (on HPC):

### With Docker

```
docker pull quay.io/jeani/slendr:latest
```
```
docker run -it --rm -v $PWD:/opt/uio slendr:latest Rscript /opt/uio/example.R
```
```
Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

The interface to all required Python modules has been activated.
[1] 1005
Starting msprime simulation...
msprime simulation completed.
╔═══════════════════════════╗
║TreeSequence               ║
╠═══════════════╤═══════════╣
║Trees          │        522║
╟───────────────┼───────────╢
║Sequence Length│    100,000║
╟───────────────┼───────────╢
║Time Units     │generations║
╟───────────────┼───────────╢
║Sample Nodes   │         40║
╟───────────────┼───────────╢
║Total Size     │   94.6 KiB║
╚═══════════════╧═══════════╝
╔═══════════╤═════╤═════════╤════════════╗
║Table      │Rows │Size     │Has Metadata║
╠═══════════╪═════╪═════════╪════════════╣
║Edges      │1,876│ 58.6 KiB│          No║
╟───────────┼─────┼─────────┼────────────╢
║Individuals│   20│584 Bytes│          No║
╟───────────┼─────┼─────────┼────────────╢
║Migrations │    0│  8 Bytes│          No║
╟───────────┼─────┼─────────┼────────────╢
║Mutations  │    0│ 16 Bytes│          No║
╟───────────┼─────┼─────────┼────────────╢
║Nodes      │  619│ 16.9 KiB│          No║
╟───────────┼─────┼─────────┼────────────╢
║Populations│    4│357 Bytes│         Yes║
╟───────────┼─────┼─────────┼────────────╢
║Provenances│    1│  2.7 KiB│          No║
╟───────────┼─────┼─────────┼────────────╢
║Sites      │    0│ 16 Bytes│          No║
╚═══════════╧═════╧═════════╧════════════╝

╔═══════════════════════════╗
║TreeSequence               ║
╠═══════════════╤═══════════╣
║Trees          │        522║
╟───────────────┼───────────╢
║Sequence Length│    100,000║
╟───────────────┼───────────╢
║Time Units     │generations║
╟───────────────┼───────────╢
║Sample Nodes   │         40║
╟───────────────┼───────────╢
║Total Size     │    1.3 MiB║
╚═══════════════╧═══════════╝
╔═══════════╤══════╤═════════╤════════════╗
║Table      │Rows  │Size     │Has Metadata║
╠═══════════╪══════╪═════════╪════════════╣
║Edges      │ 1,876│ 58.6 KiB│          No║
╟───────────┼──────┼─────────┼────────────╢
║Individuals│    20│584 Bytes│          No║
╟───────────┼──────┼─────────┼────────────╢
║Migrations │     0│  8 Bytes│          No║
╟───────────┼──────┼─────────┼────────────╢
║Mutations  │20,596│744.2 KiB│          No║
╟───────────┼──────┼─────────┼────────────╢
║Nodes      │   619│ 16.9 KiB│          No║
╟───────────┼──────┼─────────┼────────────╢
║Populations│     4│357 Bytes│         Yes║
╟───────────┼──────┼─────────┼────────────╢
║Provenances│     2│  3.4 KiB│          No║
╟───────────┼──────┼─────────┼────────────╢
║Sites      │18,605│454.2 KiB│          No║
╚═══════════╧══════╧═════════╧════════════╝

Main VCF generated with ts_vcf(): geneflow_P3toP1_Nobn_small.vcf.gz 
# A tibble: 1 × 5
  W                                            X             Y     Z          f4
  <chr>                                        <chr>         <chr> <chr>   <dbl>
1 melano_1+melano_2+melano_3+melano_4+melano_5 simulans_1+s… yaku… eugr… 0.00289

PopAncestry summary
Number of ancestral populations: 	4
Number of sample chromosomes: 		40
Number of ancestors: 			215
Total length of genomes: 		4000000.000000
Ancestral coverage: 			4000000.000000

# A tibble: 50 × 10
   name     haplotype  time pop    source_pop  left right length source_pop_id
   <chr>        <int> <dbl> <chr>  <fct>      <dbl> <dbl>  <dbl>         <dbl>
 1 melano_1         1     0 melano yakuba     63508 63837    329             1
 2 melano_1         1     0 melano yakuba     67833 69052   1219             1
 3 melano_1         1     0 melano yakuba     71880 73263   1383             1
 4 melano_1         1     0 melano yakuba     74013 74539    526             1
 5 melano_1         1     0 melano yakuba     80569 90429   9860             1
 6 melano_1         2     0 melano yakuba     63508 63837    329             1
 7 melano_1         2     0 melano yakuba     67833 69052   1219             1
 8 melano_1         2     0 melano yakuba     71880 73263   1383             1
 9 melano_1         2     0 melano yakuba     74013 74539    526             1
10 melano_1         2     0 melano yakuba     80569 90429   9860             1
# ℹ 40 more rows
# ℹ 1 more variable: node_id <dbl>
`summarise()` has grouped output by 'name', 'node_id', 'pop'. You can override using the `.groups` argument.
# A tibble: 10 × 5
# Groups:   name, node_id, pop [10]
   name     node_id pop    source_pop  prop
   <chr>      <dbl> <chr>  <fct>      <dbl>
 1 melano_1      10 melano yakuba     0.133
 2 melano_1      11 melano yakuba     0.133
 3 melano_2      12 melano yakuba     0.133
 4 melano_2      13 melano yakuba     0.133
 5 melano_3      14 melano yakuba     0.133
 6 melano_3      15 melano yakuba     0.133
 7 melano_4      16 melano yakuba     0.133
 8 melano_4      17 melano yakuba     0.133
 9 melano_5      18 melano yakuba     0.133
10 melano_5      19 melano yakuba     0.133
Demo: Testing ts_vcf() on a direct msprime (non-slendr) tree sequence...
Warning message:
Attempting to extract genotypes from a tree sequence without mutations 
Demo VCF generated with ts_vcf() on non-slendr ts: simple_non_slendr.vcf.gz 

```
which should create in your current directory the following files:

```
geneflow_P3toP1_Nobn_small_AncestryProportions.csv
geneflow_P3toP1_Nobn_small_F4.csv
geneflow_P3toP1_Nobn_small.trees
geneflow_P3toP1_Nobn_small.vcf.gz
simple_non_slendr.vcf.gz
```

### With Singularity (or Apptainer)
Pull the container image first
```
singularity pull docker://quay.io/jeani/slendr:latest
```
then execute it (and do not forget the `--env RETICULATE_MINICONDA_PATH=/root/.local/share/r-miniconda`)
```
singularity exec --env RETICULATE_MINICONDA_PATH=/root/.local/share/r-miniconda --bind $PWD:/opt/uio slendr_latest.sif Rscript /opt/uio/example.R
```
you should get something like
```
Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

The interface to all required Python modules has been activated.
[1] 1005
Starting msprime simulation...
msprime simulation completed.
╔═══════════════════════════╗
║TreeSequence               ║
╠═══════════════╤═══════════╣
║Trees          │        522║
╟───────────────┼───────────╢
║Sequence Length│    100,000║
╟───────────────┼───────────╢
║Time Units     │generations║
╟───────────────┼───────────╢
║Sample Nodes   │         40║
╟───────────────┼───────────╢
║Total Size     │   94.6 KiB║
╚═══════════════╧═══════════╝
╔═══════════╤═════╤═════════╤════════════╗
║Table      │Rows │Size     │Has Metadata║
╠═══════════╪═════╪═════════╪════════════╣
║Edges      │1,876│ 58.6 KiB│          No║
╟───────────┼─────┼─────────┼────────────╢
║Individuals│   20│584 Bytes│          No║
╟───────────┼─────┼─────────┼────────────╢
║Migrations │    0│  8 Bytes│          No║
╟───────────┼─────┼─────────┼────────────╢
║Mutations  │    0│ 16 Bytes│          No║
╟───────────┼─────┼─────────┼────────────╢
║Nodes      │  619│ 16.9 KiB│          No║
╟───────────┼─────┼─────────┼────────────╢
║Populations│    4│357 Bytes│         Yes║
╟───────────┼─────┼─────────┼────────────╢
║Provenances│    1│  2.7 KiB│          No║
╟───────────┼─────┼─────────┼────────────╢
║Sites      │    0│ 16 Bytes│          No║
╚═══════════╧═════╧═════════╧════════════╝

╔═══════════════════════════╗
║TreeSequence               ║
╠═══════════════╤═══════════╣
║Trees          │        522║
╟───────────────┼───────────╢
║Sequence Length│    100,000║
╟───────────────┼───────────╢
║Time Units     │generations║
╟───────────────┼───────────╢
║Sample Nodes   │         40║
╟───────────────┼───────────╢
║Total Size     │    1.3 MiB║
╚═══════════════╧═══════════╝
╔═══════════╤══════╤═════════╤════════════╗
║Table      │Rows  │Size     │Has Metadata║
╠═══════════╪══════╪═════════╪════════════╣
║Edges      │ 1,876│ 58.6 KiB│          No║
╟───────────┼──────┼─────────┼────────────╢
║Individuals│    20│584 Bytes│          No║
╟───────────┼──────┼─────────┼────────────╢
║Migrations │     0│  8 Bytes│          No║
╟───────────┼──────┼─────────┼────────────╢
║Mutations  │20,596│744.2 KiB│          No║
╟───────────┼──────┼─────────┼────────────╢
║Nodes      │   619│ 16.9 KiB│          No║
╟───────────┼──────┼─────────┼────────────╢
║Populations│     4│357 Bytes│         Yes║
╟───────────┼──────┼─────────┼────────────╢
║Provenances│     2│  3.4 KiB│          No║
╟───────────┼──────┼─────────┼────────────╢
║Sites      │18,605│454.2 KiB│          No║
╚═══════════╧══════╧═════════╧════════════╝

Main VCF generated with ts_vcf(): geneflow_P3toP1_Nobn_small.vcf.gz 
# A tibble: 1 × 5
  W                                            X             Y     Z          f4
  <chr>                                        <chr>         <chr> <chr>   <dbl>
1 melano_1+melano_2+melano_3+melano_4+melano_5 simulans_1+s… yaku… eugr… 0.00289

PopAncestry summary
Number of ancestral populations: 	4
Number of sample chromosomes: 		40
Number of ancestors: 			215
Total length of genomes: 		4000000.000000
Ancestral coverage: 			4000000.000000

# A tibble: 50 × 10
   name     haplotype  time pop    source_pop  left right length source_pop_id
   <chr>        <int> <dbl> <chr>  <fct>      <dbl> <dbl>  <dbl>         <dbl>
 1 melano_1         1     0 melano yakuba     63508 63837    329             1
 2 melano_1         1     0 melano yakuba     67833 69052   1219             1
 3 melano_1         1     0 melano yakuba     71880 73263   1383             1
 4 melano_1         1     0 melano yakuba     74013 74539    526             1
 5 melano_1         1     0 melano yakuba     80569 90429   9860             1
 6 melano_1         2     0 melano yakuba     63508 63837    329             1
 7 melano_1         2     0 melano yakuba     67833 69052   1219             1
 8 melano_1         2     0 melano yakuba     71880 73263   1383             1
 9 melano_1         2     0 melano yakuba     74013 74539    526             1
10 melano_1         2     0 melano yakuba     80569 90429   9860             1
# ℹ 40 more rows
# ℹ 1 more variable: node_id <dbl>
`summarise()` has grouped output by 'name', 'node_id', 'pop'. You can override using the `.groups` argument.
# A tibble: 10 × 5
# Groups:   name, node_id, pop [10]
   name     node_id pop    source_pop  prop
   <chr>      <dbl> <chr>  <fct>      <dbl>
 1 melano_1      10 melano yakuba     0.133
 2 melano_1      11 melano yakuba     0.133
 3 melano_2      12 melano yakuba     0.133
 4 melano_2      13 melano yakuba     0.133
 5 melano_3      14 melano yakuba     0.133
 6 melano_3      15 melano yakuba     0.133
 7 melano_4      16 melano yakuba     0.133
 8 melano_4      17 melano yakuba     0.133
 9 melano_5      18 melano yakuba     0.133
10 melano_5      19 melano yakuba     0.133
Demo: Testing ts_vcf() on a direct msprime (non-slendr) tree sequence...
Warning message:
Attempting to extract genotypes from a tree sequence without mutations 
Demo VCF generated with ts_vcf() on non-slendr ts: simple_non_slendr.vcf.gz 

```
which will also create in your current directory the following files:

```

Should you use this container for your research, or distribute it, please cite Jean Iaquinta. (2025). j34ni/slendr-container: Version 1.2.0 (1.2.0). Zenodo. https://doi.org/10.5281/zenodo.17276069


geneflow_P3toP1_Nobn_small_AncestryProportions.csv
geneflow_P3toP1_Nobn_small_F4.csv
geneflow_P3toP1_Nobn_small.trees
geneflow_P3toP1_Nobn_small.vcf.gz
simple_non_slendr.vcf.gz
```

## Citation

If you use this container recipe and/or image please cite:

Jean Iaquinta. (2025). j34ni/slendr-container: Version 1.2.0 (1.2.0). Zenodo. https://doi.org/10.5281/zenodo.17276069
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17276069.svg)](https://doi.org/10.5281/zenodo.17276069)
