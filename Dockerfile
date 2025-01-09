# Use the specified base image
FROM us.gcr.io/broad-dsp-gcr-public/terra-jupyter-gatk:2.3.6

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip wget tar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install MaGECK manually
WORKDIR /tmp
RUN wget https://github.com/liulab-dfci/mageck/releases/download/0.5.4/mageck-0.5.4.tar.gz && \
    tar xvzf mageck-0.5.4.tar.gz && \
    cd mageck-0.5.4 && \
    python3 setup.py install --user && \
    cd .. && \
    rm -rf mageck-0.5.4 mageck-0.5.4.tar.gz

# Add MaGECK to PATH
ENV PATH=$PATH:/root/.local/bin

# Optionally set the working directory
WORKDIR /workspace

# Verify installation
RUN mageck --version

# Default command
CMD ["bash"]
