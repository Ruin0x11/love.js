#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

mkdir -p build/debug build/release

source ./emsdk/emsdk_env.sh

## WASM2JS in emsdk does not support pthreads. Use asm.js instead.
#export EMCC_WASM_BACKEND=0

(
  cd build/debug
  emcmake cmake ../../megasource -DLOVE_JIT=0 -DCMAKE_BUILD_TYPE=Debug
  emmake make -j 6
  # cp love/love.js* ../../src/debug
  # cp love/pthread-main.js ../../src/debug
)

(
  cd build/release
  emcmake cmake ../../megasource -DLOVE_JIT=0 -DCMAKE_BUILD_TYPE=Release
  emmake make -j 6
  cp love/love.js* ../../src/release
  cp love/pthread-main.js ../../src/release
)
