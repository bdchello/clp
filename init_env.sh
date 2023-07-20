#!/bin/bash
  # -u$(id -u):$(id -g) \
docker run --rm -it \
  --name 'clp-build-env' \
  -uroot \
  -v$(readlink -f /mnt/data/TOOLS/clp/components/core):/mnt/clp \
  -v$(readlink -f /mnt/data/TOOLS/clp/logs):/mnt/logs \
  ghcr.io/y-scope/clp/clp-core-dependencies-x86-ubuntu-focal:main \
  /bin/bash
