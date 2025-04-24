# Base image
FROM quay.io/condaforge/miniforge3:24.11.3-2

# Copy environment file
COPY environment.yml /var/tmp/

# Create and configure Conda environment named slendr using environment.yml
RUN . /opt/conda/etc/profile.d/conda.sh && \
    mamba env create -f /var/tmp/environment.yml && \
    mamba clean -afy

# Install r-slendr and r-ijtiff and set up slendr Python environment
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    /opt/conda/envs/slendr/bin/R -e "install.packages(c('slendr', 'ijtiff'), repos='https://cran.r-project.org')" && \
    /opt/conda/envs/slendr/bin/R -e "library(slendr); setup_env(quiet=TRUE, agree=TRUE)" && \
    rm /var/tmp/environment.yml

# Copy the start.sh script
COPY start.sh /opt/slendr/start.sh

# Set the entrypoint to mimic %runscript and %startscript behavior
ENTRYPOINT ["/bin/bash", "-c", ". /opt/slendr/start.sh && exec \"$@\"", "/bin/bash"]
CMD ["/bin/bash"]
