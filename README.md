# KNX-IOT-Embedded

This repository shows an example of how you can put together a KNX-IOT application which runs on an embedded platform. These examples run on [Cascoda's Thread Development Kit](https://www.cascoda.com/products/thread-development-kit/).

## Prerequisites

In order to build this repository, you need CMake version 3.18 or greater, as well as a recent ARM GCC compiler. See the [Development Environment Setup guide](https://github.com/Cascoda/cascoda-sdk/blob/master/docs/guides/development-setup.md) for detailed instructions on how to set this up. 

## Build Instructions
```bash
mkdir build
cd build/
# You may get an error concernining a missing "/include" path. 
# Please ignore it, the following 'make' command will
# succeed regardless
cmake .. -DCMAKE_TOOLCHAIN_FILE=../arm_gcc_m2351.cmake
make
```
## Example Binaries

Once the build completes, you will find `knx-iot-devboard-pb.bin` and `knx-iot-devboard-sa.bin` inside your `build/` directory. You must then flash these binaries. This can be done via USB or with a programmer - see the [Flashing Guide](https://github.com/Cascoda/cascoda-sdk/blob/master/docs/guides/flashing.md) for a detailed how-to.
