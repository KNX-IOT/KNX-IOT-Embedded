# KNX-IOT-Embedded

This repository shows an example of how you can put together a KNX-IOT application which runs on an embedded platform. These examples run on [Cascoda's Thread Development Board](https://www.cascoda.com/products/thread-development-kit/). These applications are identical to the examples in [KNX-IOT-Virtual](https://github.com/KNX-IOT/KNX-IOT-Virtual), except running on a Thread-based embedded device.
 
## Prerequisites

In order to build this repository, you need CMake version 3.18 or greater, as well as a recent ARM GCC compiler. See the [Development Environment Setup guide](https://github.com/Cascoda/cascoda-sdk/blob/master/docs/guides/development-setup.md) for detailed instructions on how to set this up. 

## Build Instructions
### For Linux
```bash
mkdir build
cd build/
cmake .. -DCMAKE_TOOLCHAIN_FILE=../arm_gcc_m2351.cmake || make
```

To save time on subsequent incremental builds, you may simply run `make` inside your build directory.

### For Windows

Run the following within an ADMIN Powershell window in order to set up the Chocolatey package manager:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Then, also in an ADMIN Powershell window, allow the execution of local scripts & install the toolchain using Choco.
```powershell
Set-ExecutionPolicy RemoteSigned
.\install-toolchain.ps1
```

Finally, set up the build directory & compile your binaries. This can be done outside of an ADMIN shell.
```powershell
.\configure-build.ps1
```

On subsequent builds, you only need to run `ninja` inside your build directory.

## Example Binaries

Once the build completes, you will find `knx-iot-devboard-pb.bin` and `knx-iot-devboard-sa.bin` inside your `build/` directory. You must then flash these binaries. This can be done via USB, with a programmer (J-Link / NuLink) or via Over-the-Air Software Update. See the [Flashing Guide](https://github.com/Cascoda/cascoda-sdk/blob/master/docs/guides/flashing.md) for a detailed how-to.
