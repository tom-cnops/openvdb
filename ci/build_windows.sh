#!/usr/bin/env bash

set -ex

VCPKG_ROOT="$1"

mkdir build
cd build

# See the following regarding boost installation:
#  https://github.com/actions/virtual-environments/issues/687
#  https://github.com/actions/virtual-environments/blob/master/images/win/Windows2019-Readme.md

cmake \
  -G "Visual Studio 16 2019" -A x64 \
  -DCMAKE_TOOLCHAIN_FILE="${VCPKG_ROOT}\scripts\buildsystems\vcpkg.cmake" \
  -DOPENVDB_BUILD_BINARIES=ON \
  -DOPENVDB_BUILD_VDB_PRINT=ON \
  -DOPENVDB_BUILD_VDB_LOD=ON \
  -DOPENVDB_BUILD_VDB_RENDER=ON \
  -DOPENVDB_BUILD_VDB_VIEW=ON \
  -DOPENVDB_BUILD_UNITTESTS=ON \
  -DBOOST_ROOT="${BOOST_ROOT_1_72_0}" \
  -DBOOST_INCLUDEDIR="${BOOST_ROOT_1_72_0}\boost\include" \
  -DBOOST_LIBRARYDIR="${BOOST_ROOT_1_72_0}\lib" \
  ..

cmake --build . --parallel 4 --config Release --target install
