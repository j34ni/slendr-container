FROM quay.io/condaforge/miniforge3:25.3.1-0

USER root

COPY environment.yml /opt/slendr/environment.yml

RUN . /opt/conda/etc/profile.d/conda.sh && \
    mamba env create -f /opt/slendr/environment.yml && \
    conda activate slendr && \
    mamba clean --all -f -y

RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    R -e "options(repos = c(CRAN = 'https://cran.r-project.org')); install.packages('ijtiff', dependencies = TRUE)"

RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    wget -q -nc --no-check-certificate -P /opt/src https://github.com/MesserLab/SLiM/archive/refs/tags/v5.1.tar.gz && \
    tar xf /opt/src/v5.1.tar.gz -C /opt/src -z && \
    cd /opt/src/SLiM-5.1 && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX \
             -DCMAKE_AR=$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-ar \
             -DCMAKE_RANLIB=$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-ranlib && \
    make && \
    make install && \
    rm -rf /opt/src/SLiM-5.1 /opt/src/v5.1.tar.gz

RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    R -e "options(repos = c(CRAN = 'https://cran.r-project.org')); remotes::install_version('slendr', version = '1.2.0', dependencies = TRUE)"

RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    R -e "Sys.setenv(CONDA_PLUGINS_AUTO_ACCEPT_TOS = '1'); library(slendr); slendr::setup_env(agree = TRUE, quiet = TRUE)"

COPY start.sh /opt/slendr/start.sh
COPY example_slendr.R /opt/slendr/example_slendr.R

RUN chmod +x /opt/slendr/start.sh

ENTRYPOINT ["/bin/bash", "-c", ". /opt/slendr/start.sh && exec \"$@\"", "--"]
CMD ["/bin/bash"]
