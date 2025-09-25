# slendr-container
This repository provides a Dockerfile starting from a rocker/geospatial:4.4.3 image to run slendr-1.2.0

```
docker run -it --rm slendr R

R version 4.4.3 (2025-02-28) -- "Trophy Case"
Copyright (C) 2025 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> library(slendr)
> init_env()
The interface to all required Python modules has been activated.
> check_env() 
Summary of the currently active Python environment:

Python binary: /root/.local/share/r-miniconda/envs/Python-3.12_msprime-1.3.4_tskit-0.6.4_pyslim-1.0.4_tspop-0.0.2/bin/python 
Python version: 3.12.11 | packaged by conda-forge | (main, Jun  4 2025, 14:45:31) [GCC 13.3.0] 

slendr requirements:
 - tskit: version 0.6.4 ✓ 
 - msprime: version 1.3.4 ✓ 
 - pyslim: version 1.0.4 ✓ 
 - tspop: present ✓ 
> quit()
```

