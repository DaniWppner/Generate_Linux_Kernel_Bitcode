## Tested for linux v.6.10

### 1 Launch the docker container and get inside

```bash
docker compose up linux_wllvm_environ -d
docker exec -it CONTAINERNAME bash

```

### 2 Apply linux patch to understand .llvm_bc section in object files
You should use `git apply` to apply the patch in this repo


### 2 Compile with LLVM stack but wllvm instead of clang
```bash
cd linux
make LLVM=1 CC=gclang HOSTCC=gclang defconfig
make LLVM=1 CC=gclang HOSTCC=gclang -j $(nproc)
```

### 3 Extract bitcode
```bash
get-bc vmlinux.o
```
