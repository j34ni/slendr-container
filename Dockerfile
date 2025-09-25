FROM rocker/geospatial:4.4.3

# Install utils and build tools
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    cmake \
    build-essential \
    libpng-dev \
    vim \
    python3 \
    python3-pip \
    python3-venv \
    libgsl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install SLiM 5.1 
RUN wget -q -nc --no-check-certificate -P /var/tmp https://github.com/MesserLab/SLiM/archive/refs/tags/v5.1.tar.gz && \
    tar xf /var/tmp/v5.1.tar.gz -C /var/tmp -z && \
    cd /var/tmp/SLiM-5.1 && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
    make && \
    make install && \
    rm -rf /var/tmp/SLiM-5.1 /var/tmp/v5.1.tar.gz

# Pre-install Miniconda to a system-wide path and accept TOS
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -u -p /opt/r-miniconda && \
    rm /tmp/miniconda.sh

RUN /opt/r-miniconda/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    /opt/r-miniconda/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

RUN /opt/r-miniconda/bin/conda update --yes --name base conda -c conda-forge

# Set system-wide reticulate config to use the new Miniconda path
RUN echo 'RETICULATE_MINICONDA_PATH="/opt/r-miniconda"' >> /etc/R/Renviron

# Install latest slendr from CRAN (post-1.2.0 version requires/supports SLiM 5, avoiding filter() redef error)
RUN R -e "install.packages('remotes', repos='https://cran.r-project.org'); install.packages('slendr', repos='https://cran.r-project.org')"

# Install spatial dependencies explicitly
RUN R -e "install.packages(c('sf', 'stars', 'rnaturalearth'), repos='https://cran.r-project.org')"

# Set up the slendr Python environment (non-interactive), using the system-wide path
RUN R -e "Sys.setenv(RETICULATE_MINICONDA_PATH = '/opt/r-miniconda'); library(slendr); setup_env(agree = TRUE, quiet = TRUE)"

COPY example_slendr.R /var/tmp/example_slendr.R

CMD ["bash"]
