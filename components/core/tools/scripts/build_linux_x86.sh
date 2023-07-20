

mkdir -p /mnt/clp/build-linux_x86
pushd /mnt/clp/build-linux_x86
cmake ..

make -j2

make install

popd