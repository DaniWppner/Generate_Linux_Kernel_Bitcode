# I DO NOT LONGER KNOW WHAT THIS DOCKERFILE IS FOR.
# THE MOST REASONABLE THING TO DO WOULD BE DELETING IT.
# syzspec:default PROBABLY REFERS TO A LOCALLY BUILT IMAGE
# FROM THE ROOT DOCKERFILE IN https://github.com/seclab-ucr/SyzSpec.git


# Use the SyzSpec image as the base (provides LLVM 14 and wllvm natively)
FROM syzspec:default

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# switch user to root to install packages
# and for compatibility with mounting the linux source tree
USER root

# 1. Install general linux build essentials
RUN apt-get update && apt-get install -y \
    flex bison bc libelf-dev libssl-dev rsync file \ 
    && rm -rf /var/lib/apt/lists/*

# 2. Install go (to use with
# github.com/ZHYfeng/Generate_Linux_Kernel_Bitcode/tree/master)
RUN apt-get update && apt-get install -y \
    golang-go \
    && rm -rf /var/lib/apt/lists/*