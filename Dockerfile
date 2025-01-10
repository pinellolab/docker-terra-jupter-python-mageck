# Use the specified base image
FROM us.gcr.io/broad-dsp-gcr-public/terra-jupyter-gatk:2.3.6

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PATH="/root/.local/bin:$PATH" \
    MAGeCK_VERSION="0.5.4"

# Install required dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip wget tar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install MaGECK
WORKDIR /tmp
RUN wget https://github.com/liulab-dfci/mageck/releases/download/$MAGeCK_VERSION/mageck-$MAGeCK_VERSION.tar.gz && \
    tar xvzf mageck-$MAGeCK_VERSION.tar.gz && \
    cd mageck-$MAGeCK_VERSION && \
    python3 setup.py install --user && \
    cd .. && \
    rm -rf mageck-$MAGeCK_VERSION mageck-$MAGeCK_VERSION.tar.gz

# Verify installation
RUN mageck --version

# Set working directory
WORKDIR /workspace

# Default command
CMD ["bash"]

