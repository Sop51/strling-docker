# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

WORKDIR /home/ubuntu/

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential

# Install nim
#RUN apt-get update && \
#  apt-get install -y curl xz-utils gcc openssl ca-certificates git && \
#  curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- -y && \
#  apt -y autoremove && \
#  apt -y clean

#ENV PATH=/home/ubuntu/.nimble/bin:$PATH

#install strling
#RUN git clone https://github.com/quinlan-lab/STRling.git && \
#    cd STRling && \
#    nimble install -y && \
#    nim c -d:danger -d:release src/strling.nim && \
#    cd ..

RUN wget https://github.com/quinlan-lab/STRling/releases/download/v0.5.2/strling && \
    chmod +x strling

ENV PATH=/home/ubuntu/strling:$PATH

# Copy your application code into the container
COPY run_strling.sh .

# Set the entrypoint command
CMD ["run_strling.sh"]