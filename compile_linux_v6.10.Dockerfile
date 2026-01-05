# Use the same base image as KLEE (and SyzSpec since it's based on KLEE)
FROM ubuntu:jammy-20230126

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install kernel, llvm, golang dependencies
RUN apt-get update && apt-get install -y \
    # These are needed to build the linux kernel    
    make flex bison bc libelf-dev libssl-dev rsync file \ 
    # LLVM 14 toolchain 
    clang-14 llvm-14 lld-14 \
    # golang (to use with
    # github.com/ZHYfeng/Generate_Linux_Kernel_Bitcode/tree/master)
    golang-go ca-certificates \

    && rm -rf /var/lib/apt/lists/*

# 2. Install gllvm
RUN go install github.com/SRI-CSL/gllvm/cmd/...@v1.3.1 
ENV PATH="$PATH:$HOME/go/bin"

RUN apt-get update && apt-get install -y \
    # These are needed to run clang commands in parallel    
    parallel \

    && rm -rf /var/lib/apt/lists/*

# 3. Set LLVM 14 as the default version
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-14 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-14 100 && \
    update-alternatives --install /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-14 100 && \
    update-alternatives --install /usr/bin/llvm-nm llvm-nm /usr/bin/llvm-nm-14 100 && \
    update-alternatives --install /usr/bin/llvm-objcopy llvm-objcopy /usr/bin/llvm-objcopy-14 100 && \
    update-alternatives --install /usr/bin/llvm-objdump llvm-objdump /usr/bin/llvm-objdump-14 100 && \
    update-alternatives --install /usr/bin/llvm-readelf llvm-readelf /usr/bin/llvm-readelf-14 100 && \
    update-alternatives --install /usr/bin/llvm-strip llvm-strip /usr/bin/llvm-strip-14 100 && \
    update-alternatives --install /usr/bin/llvm-link llvm-link /usr/bin/llvm-link-14 100 && \
    update-alternatives --install /usr/bin/llvm-as llvm-as /usr/bin/llvm-as-14 100 && \
    update-alternatives --install /usr/bin/llvm-dis llvm-dis /usr/bin/llvm-dis-14 100 && \
    update-alternatives --install /usr/bin/opt opt /usr/bin/opt-14 100 && \
    update-alternatives --install /usr/bin/llc llc /usr/bin/llc-14 100 && \
    update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-14 100 && \
    update-alternatives --install /usr/bin/llvm-profdata llvm-profdata /usr/bin/llvm-profdata-14 100 && \
    update-alternatives --install /usr/bin/llvm-cov llvm-cov /usr/bin/llvm-cov-14 100 && \
    update-alternatives --install /usr/bin/ld.lld ld.lld /usr/bin/ld.lld-14 100
