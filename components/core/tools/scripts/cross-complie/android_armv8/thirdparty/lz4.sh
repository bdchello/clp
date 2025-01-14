#!/bin/bash

# Dependencies:
# - curl
# - make
# - gcc
# NOTE: Dependencies should be installed outside the script to allow the script to be largely distro-agnostic

# Exit on any error
set -e

cUsage="Usage: ${BASH_SOURCE[0]} <version>[ <.deb output directory>]"
if [ "$#" -lt 1 ] ; then
    echo $cUsage
    exit
fi
version=$1

package_name=liblz4
temp_dir=/mnt/clp/build/${package_name}-installation
deb_output_dir=${temp_dir}
if [[ "$#" -gt 1 ]] ; then
  deb_output_dir="$(readlink -f "$2")"
  if [ ! -d ${deb_output_dir} ] ; then
    echo "${deb_output_dir} does not exist or is not a directory"
    exit
  fi
fi

# echo "cp liblz4"
# cp  -rf /mnt/clp/tools/scripts/cross-complie/android_armv8/template/liblz4/* /mnt/clp/build/android_armv8


# Check if already installed
# set +e
# dpkg -l ${package_name} | grep ${version}
# installed=$?
# set -e
# if [ $installed -eq 0 ] ; then
#   # Nothing to do
#   exit
# fi

echo "Checking for elevated privileges..."
privileged_command_prefix=""
if [ ${EUID:-$(id -u)} -ne 0 ] ; then
  sudo echo "Script can elevate privileges."
  privileged_command_prefix="${privileged_command_prefix} sudo"
fi

# Download
mkdir -p $temp_dir
cd $temp_dir
extracted_dir=${temp_dir}/lz4-${version}
if [ ! -e ${extracted_dir} ] ; then
  tar_filename=v${version}.tar.gz
  if [ ! -e ${tar_filename} ] ; then
    curl -fsSL https://github.com/lz4/lz4/archive/${tar_filename} -o ${tar_filename}
  fi

  tar -xf ${tar_filename}
fi

# Build
echo "build lz4"
cd ${extracted_dir}
# /mnt/clp/tools/scripts/cross-complie/ndk/android-ndk-r21e/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang
make lib -j2 ARCH=arm CROSS_COMPLIE=/mnt/clp/tools/scripts/cross-complie/ndk/android-ndk-r21e/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang CC=/mnt/clp/tools/scripts/cross-complie/ndk/android-ndk-r21e/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang 

# # Check if checkinstall is installed
# # set +e
# # command -v checkinstall
# # checkinstall_installed=$?
# # set -e

# # Install
# # install_command_prefix="${privileged_command_prefix}"
# # if [ $checkinstall_installed -eq 0 ] ; then
# #   install_command_prefix="${install_command_prefix} checkinstall --pkgname '${package_name}' --pkgversion '${version}' --provides '${package_name}' --nodoc -y --pakdir \"${deb_output_dir}\""
# # fi
# # ${install_command_prefix} make install

make install PREFIX=${temp_dir}/../android_armv8

# Clean up
# rm -rf $temp_dir
