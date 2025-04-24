#!/bin/bash

echo "Activating environment..."

. /opt/conda/etc/profile.d/conda.sh && conda activate slendr

export RETICULATE_PYTHON=/root/.slendr/Python-3.12_msprime-1.3.3_tskit-0.5.8_pyslim-1.0.4_tspop-0.0.2/bin/python

exec "$@"
