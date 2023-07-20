#!/usr/bin/env bash
set -ex

export ANDROID_NDK=/mnt/clp/tools/scripts/cross-complie/ndk/android-ndk-r21e

export ANDROID_PREFIX="$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin"

export CC="${ANDROID_PREFIX}/aarch64-linux-android30-clang"
export CXX="${ANDROID_PREFIX}/aarch64-linux-android30-clang++"
export AS="${ANDROID_PREFIX}/aarch64-linux-android-as"
export LD="${ANDROID_PREFIX}/aarch64-linux-android-ld"
export GDB="${ANDROID_PREFIX}/aarch64-linux-android-gdb"
export STRIP="${ANDROID_PREFIX}/aarch64-linux-android-strip"
export RANLIB="${ANDROID_PREFIX}/aarch64-linux-android-ranlib"
export OBJCOPY="${ANDROID_PREFIX}/aarch64-linux-android-objcopy"
export OBJDUMP="${ANDROID_PREFIX}/aarch64-linux-android-objdump"
export AR="${ANDROID_PREFIX}/aarch64-linux-android-ar"
export NM="${ANDROID_PREFIX}/aarch64-linux-android-nm"


# cross complie thirdparty
echo ============ build zstandard ==============
/mnt/clp/tools/scripts/cross-complie/android_armv8/thirdparty/zstandard.sh 1.4.9

echo ============ build boost ==============
/mnt/clp/tools/scripts/cross-complie/android_armv8/thirdparty/install-boost_1_76_0.sh  1.76.0
# /mnt/clp/tools/scripts/cross-complie/android_armv8/thirdparty/install-boost.sh  1.81.0

echo ============ build fmtlib ==============
/mnt/clp/tools/scripts/cross-complie/android_armv8/thirdparty/fmtlib.sh 8.0.1

echo ============ build lz4 ==============
# make 编译，android系统有liblz4.so
/mnt/clp/tools/scripts/cross-complie/android_armv8/thirdparty/lz4.sh 1.8.2

echo ============ build msgpack ==============
# 依赖boost
/mnt/clp/tools/scripts/cross-complie/android_armv8/thirdparty/msgpack.sh 6.0.0

echo ============ build spdlog ==============
/mnt/clp/tools/scripts/cross-complie/android_armv8/thirdparty/spdlog.sh 1.9.2

# -- Could NOT find BZip2 (missing: BZIP2_LIBRARIES BZIP2_INCLUDE_DIR) 
# -- Could NOT find LibLZMA (missing: LIBLZMA_LIBRARY LIBLZMA_INCLUDE_DIR LIBLZMA_HAS_AUTO_DECODER LIBLZMA_HAS_EASY_ENCODER LIBLZMA_HAS_LZMA_PRESET) 
# -- Could NOT find LIBB2 (missing: LIBB2_LIBRARY LIBB2_INCLUDE_DIR) 
# -- Could NOT find LZ4 (missing: LZ4_LIBRARY LZ4_INCLUDE_DIR) 
# -- Found ZSTD: /mnt/clp/build/libarchive-installation/../android_armv8/lib/libzstd.so  
# -- Looking for ZSTD_compressStream
# -- Looking for ZSTD_compressStream - found
# -- Could NOT find OpenSSL, try to set the path to OpenSSL root folder in the system variable OPENSSL_ROOT_DIR (missing: OPENSSL_CRYPTO_LIBRARY OPENSSL_INCLUDE_DIR) 
# -- Could NOT find LibXml2 (missing: LIBXML2_LIBRARY LIBXML2_INCLUDE_DIR) 
echo ============ build libarchive ==============
/mnt/clp/tools/scripts/cross-complie/android_armv8/thirdparty/libarchive.sh 3.6.1


echo ============ build CLP ==============
# cd /mnt/clp
mkdir -p /mnt/clp/build/android_armv8
pushd /mnt/clp/build

    # -DCLP_USE_STATIC_LIBS=TRUE \
# cross comlie core
cmake \
    -DYAML_CPP_INSTALL=ON \
    -DCMAKE_SYSTEM_VERSION=30 \
    -DANDROID_PLATFORM=android-30 \
    -DANDROID_ABI=arm64-v8a \
    -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a \
    -DCMAKE_ANDROID_NDK=${ANDROID_NDK} \
    -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake \
    -DCMAKE_BUILD_TYPE=release \
    -DANDROID=true \
    -DDISABLE_GNU_SOURCE=ON \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX=/mnt/clp/build/android_armv8 \
    -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=BOTH \
    -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=BOTH \
    -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=BOTH \
    ..

cmake --build . 

# make -j2

make install

popd

echo "Congratulation me, clp finished !!!"