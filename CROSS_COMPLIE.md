## Cross complie

### # Step 1
```
docker run --rm -it \
  --name 'clp-build-env' \
  -uroot \
  -v$(readlink -f /path/to/clp/components/core):/mnt/clp \
  -v$(readlink -f /path/to/my/logs):/mnt/logs \
  ghcr.io/y-scope/clp/clp-core-dependencies-x86-ubuntu-focal:main \
  /bin/bash

cd /mnt/clp

./tools/scripts/deps-download/download-all.sh
```

Make sure to change `/path/to/clp/components/core` and `/path/to/my/logs` to
the relevant paths on your machine.

### # Step 2
#### ## linux_x86 platform
> ./tools/scripts/lib_install/ubuntu-focal/install-all.sh
> ./tools/scripts/build_linux_x86.sh 

#### ## android_armv8 platform
>./tools/scripts/build_android_armv8.sh

#### ## linux_aarch64 platform
> TODO