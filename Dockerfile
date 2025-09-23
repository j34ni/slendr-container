# Use the specified Miniforge base image
FROM quay.io/condaforge/miniforge3:25.3.1-0

# Switch to root for installations
USER root

# Copy the environment.yml into the image
COPY environment.yml /opt/slendr/environment.yml

# Create and activate the slendr env using mamba
RUN . /opt/conda/etc/profile.d/conda.sh && \
    mamba env create -f /opt/slendr/environment.yml && \
    conda activate slendr && \
    mamba clean --all -f -y

# Install ijtiff from CRAN source (binaries unavailable for R 4.4; system libs enable compile)
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    R -e "options(repos = c(CRAN = 'https://cran.r-project.org')); install.packages('ijtiff', dependencies = TRUE)"

# Install SLiM 5.1 from source using out-of-source CMake (avoids eidos dir conflict)
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    wget https://github.com/MesserLab/SLiM/archive/refs/tags/v5.1.tar.gz && \
    tar xzf v5.1.tar.gz && \
    cd SLiM-5.1 && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
             -DCMAKE_AR=/opt/conda/envs/slendr/bin/x86_64-conda-linux-gnu-ar \
             -DCMAKE_RANLIB=/opt/conda/envs/slendr/bin/x86_64-conda-linux-gnu-ranlib && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf SLiM-5.1 v5.1.tar.gz

# Install slendr 1.2.0 using remotes (deps=TRUE installs any remaining CRAN binaries)
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    R -e "options(repos = c(CRAN = 'https://cran.r-project.org')); remotes::install_version('slendr', version = '1.2.0', dependencies = TRUE)"

# Run slendr setup for Python env (msprime 1.3.4, tskit 0.6.4, etc.; SLiM now in PATH)
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    R -e "Sys.setenv(CONDA_PLUGINS_AUTO_ACCEPT_TOS = '1'); library(slendr); slendr::setup_env(agree = TRUE, quiet = TRUE)"

# Copy and make executable the startup script for env activation
COPY start.sh /opt/slendr/start.sh
RUN chmod +x /opt/slendr/start.sh

# Entrypoint: Activate env and exec the command (e.g., defaults to R)
ENTRYPOINT ["/bin/bash", "-c", ". /opt/slendr/start.sh && exec \"$@\"", "--"]
