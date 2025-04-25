FROM quay.io/condaforge/miniforge3:24.11.3-2

COPY environment.yml /opt/slendr/environment.yml
COPY start.sh /opt/slendr/start.sh
COPY example_slendr.R /opt/slendr/example_slendr.R

RUN chmod +x /opt/slendr/start.sh

RUN set -e && \
    export PIP_ROOT_USER_ACTION=ignore && \
    . /opt/conda/etc/profile.d/conda.sh && \
    mamba env create -f /opt/slendr/environment.yml && \
    conda activate slendr && \
    conda create -n Python-3.12_msprime-1.3.3_tskit-0.5.8_pyslim-1.0.4_tspop-0.0.2 python=3.12 msprime=1.3.3 tskit=0.5.8 pyslim=1.0.4 pip -c conda-forge && \
    /opt/conda/envs/Python-3.12_msprime-1.3.3_tskit-0.5.8_pyslim-1.0.4_tspop-0.0.2/bin/pip install tspop==0.0.2 && \
    /opt/conda/envs/slendr/bin/R -e "install.packages(c('ijtiff', 'slendr'), repos='https://cran.r-project.org')" && \
    /opt/conda/envs/slendr/bin/R -e "reticulate::use_condaenv('Python-3.12_msprime-1.3.3_tskit-0.5.8_pyslim-1.0.4_tspop-0.0.2', required = TRUE)" && \
    mamba clean -afy && \
    conda clean --all -y

ENTRYPOINT ["/bin/bash", "-c", ". /opt/slendr/start.sh && exec \"$@\"", "--"]
CMD ["/bin/bash"]
