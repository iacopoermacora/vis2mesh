#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "Installing.. $SCRIPT_DIR"
git clone https://github.com/cdcseacave/VCG.git "$SCRIPT_DIR/vcglib" -q
cd "$SCRIPT_DIR/vcglib"  && git checkout 88f12f212a1645d1fa6416592a434c29e63b57f0
git clone https://github.com/GDAOSU/openMVS_mvasupport.git "$SCRIPT_DIR/openMVS_src" -q
git config --global --add safe.directory /workspace/tools/openMVS_src
cd "$SCRIPT_DIR/openMVS_src" && git checkout 09fdd45e23c4b4fd3a0a4258f8294aae6e9fe8d9 
sed -i 's|http://zlib.net/zlib-1.2.11.tar.gz|http://zlib.net/fossils/zlib-1.2.12.tar.gz|' /workspace/tools/openMVS_src/build/Modules/import_zlib.cmake
mkdir "$SCRIPT_DIR/openMVS_build"
cd "$SCRIPT_DIR/openMVS_build"
cmake . "$SCRIPT_DIR/openMVS_src" -DCMAKE_BUILD_TYPE=Release -DVCG_ROOT="$SCRIPT_DIR/vcglib" -DCMAKE_INSTALL_PREFIX="$SCRIPT_DIR"
make -j7 && make install
