#!/usr/bin/env bash

# Exit on error
set -e

cUsage="Usage: ${BASH_SOURCE[0]} <version>"
if [ "$#" -lt 1 ] ; then
    echo $cUsage
    exit
fi
version=$1
version_with_underscores=${version//./_}

echo "Checking for elevated privileges..."
# if [ ${EUID:-$(id -u)} -ne 0 ] ; then
#   sudo echo "Script can elevate privileges."
# fi

# Get number of cpu cores
num_cpus=$(grep -c ^processor /proc/cpuinfo)

package_name=boost

# Create temp dir for installation
temp_dir=/mnt/clp/build/${package_name}-installation
mkdir -p $temp_dir

cd $temp_dir

echo `pwd`

# Download source
tar_filename=boost_${version_with_underscores}.tar.gz
echo  ${tar_filename}

if [ ! -f "${tar_filename}" ]; then
  echo  https://sourceforge.net/projects/boost/files/boost/${version}/${tar_filename}
  curl -# -fsSL https://sourceforge.net/projects/boost/files/boost/${version}/${tar_filename} -o ${tar_filename}

  # echo  https://boostorg.jfrog.io/artifactory/main/release/${version}/source/${tar_filename}
  # curl -# -fsSL https://boostorg.jfrog.io/artifactory/main/release/${version}/source/${tar_filename} -o ${tar_filename}
fi

tar xzf ${tar_filename}
cd boost_${version_with_underscores}

# cp /mnt/clp/tools/scripts/cross-complie/android_armv8/template/boost_1_76_0/bootstrap.sh .
cp /mnt/clp/tools/scripts/cross-complie/android_armv8/template/boost/bootstrap.sh .
cp /mnt/clp/tools/scripts/cross-complie/android_armv8/template/boost/tools/build/src/tools/gcc.jam ./tools/build/src/tools
# cp -rf /mnt/clp/tools/scripts/cross-complie/template/boost .
chmod +x bootstrap.sh
echo "finish copy bootstrap.sh"

# Build
#  --without-libraries=atomic,chrono,container,context,contract,coroutine,date_time,exception,fiber,python,timer,graph,graph_parallel --prefix=/usr/local/.../embedded/
./bootstrap.sh --with-libraries=iostreams,program_options,filesystem,system
echo "================================================ WWG ========================================================="
./b2 -j${num_cpus}  link=static  variant=release cxxflags=-fPIC linkflags="-stdlib=libc++"

# Install
# if [ ${EUID:-$(id -u)} -ne 0 ] ; then
#   ./b2 install
# else
#   ./b2 install
# fi
  ./b2 install --prefix=${temp_dir}/../android_armv8

# Clean up
# rm -rf $temp_dir