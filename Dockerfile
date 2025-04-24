# Base image
FROM quay.io/condaforge/miniforge3:24.11.3-2

# Copy environment file
COPY environment.yml /var/tmp

# Create and configure Conda environment named slendr using environment.yml
RUN . /opt/conda/etc/profile.d/conda.sh && \
    mamba env create -f /var/tmp/environment.yml && \
    mamba clean -afy && \
    rm /var/tmp/environment.yml

# Install r-slendr and r-ijtiff from CRAN
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate slendr && \
    R -e "install.packages(c('ijtiff', 'slendr'), repos='https://cran.r-project.org')" && \
    R -e "library(slendr); setup_env(quiet=TRUE, agree=TRUE)"

# Copy the start.sh script
COPY start.sh /opt/slendr/start.sh

# Set the entrypoint to mimic %runscript and %startscript behavior
ENTRYPOINT ["/bin/bash", "-c", ". /opt/slendr/start.sh && exec \"$@\"", "/bin/bash"]
CMD ["/bin/bash"]
