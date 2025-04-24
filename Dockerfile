# Base image
FROM quay.io/condaforge/miniforge3:24.11.3-2

# Create and configure Conda environment named slendr
RUN . /opt/conda/etc/profile.d/conda.sh && \
    mamba create -y --name slendr && \
    mamba install -y --name slendr -c conda-forge \
    r-base=4.3.3 \
    r-ggplot2 \
    r-png \
    r-reticulate \
    r-httpuv \
    r-shiny \
    r-shinywidgets \
    r-sf \
    r-stars \
    r-rnaturalearth \
    r-codetools \
    r-getopt \
    r-dplyr \
    libtiff \
    libpng \
    libuv \
    zlib \
    libzlib \
    libjpeg-turbo \
    slim \
    gcc \
    gxx \
    make \
    python \
    pip && \
    mamba clean -afy

# Install Python dependencies for slendr with specific versions
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    pip install msprime==1.3.3 tskit==0.5.8 pyslim==1.0.4 tspop==0.0.2 pandas

# Install r-slendr and r-ijtiff from CRAN
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    R -e "install.packages(c('ijtiff', 'slendr'), repos='https://cran.r-project.org')"

# Set up slendr Python environment non-interactively
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    R -e "library(slendr); setup_env(quiet=TRUE, agree=TRUE)"

# Copy the start.sh script
COPY ./start.sh /opt/slendr/start.sh

# Set the entrypoint to mimic %runscript and %startscript behavior
ENTRYPOINT ["/bin/bash", "-c", ". /opt/slendr/start.sh && exec \"$@\"", "/bin/bash"]
CMD ["/bin/bash"]
