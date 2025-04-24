# Base image
FROM quay.io/condaforge/miniforge3:24.11.3-2

# Copy environment and renv files
COPY environment.yml renv.lock /var/tmp/

# Create and configure Conda environment named slendr using environment.yml
RUN . /opt/conda/etc/profile.d/conda.sh && \
    mamba env create -f /var/tmp/environment.yml && \
    mamba clean -afy && \
    rm /var/tmp/environment.yml

# Install r-slendr and r-ijtiff using renv and set up slendr Python environment
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    /opt/conda/envs/slendr/bin/R -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv', repos='https://cran.r-project.org'); library(renv)" && \
    /opt/conda/envs/slendr/bin/R -e "renv::restore(lockfile='/var/tmp/renv.lock', repos='https://cran.r-project.org')" && \
    /opt/conda/envs/slendr/bin/R -e "library(slendr); setup_env(quiet=TRUE, agree=TRUE)" && \
    rm /var/tmp/renv.lock

# Copy the start.sh script
COPY start.sh /opt/slendr/start.sh

# Set the entrypoint to mimic %runscript and %startscript behavior
ENTRYPOINT ["/bin/bash", "-c", ". /opt/slendr/start.sh && exec \"$@\"", "/bin/bash"]
CMD ["/bin/bash"]
