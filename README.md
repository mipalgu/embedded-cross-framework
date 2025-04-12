# Embedded Cross-Compilation Template

This is a generic, cross-platform template to use for embedded systems development.

## CMake Configuration

### Toolchain Files

The toolchain files allow `cmake` to find the cross-compilation toolchains
for specific architectures.  To this end, the relevant toochain is added to
the corresponding `CMAKE_TOOLCHAIN_FILE` section in `CMakePresets.json`, e.g.:

```json
"CMAKE_TOOLCHAIN_FILE": {
    "type": "FILEPATH",
    "value": "toolchain-arm-none-eabi-gcc.cmake"
}
```

The following variables are defined in all toolchain files:


 * 	`TARGET_TRIPLET`: The triplet describing the CPU, Operating System, and ABI
    of the target system.
 *  `TOOLCHAIN_COMPILER`: The full path to the cross-compiler.
 *  `TOOLCHAIN_PREFIX`: The prefixed directory where to find the `bin`, `include`,
    `lib`, and other directories relevant for compiling to the target system.
 * `CMAKE_C_COMPILER`: The C compiler to use for cross compiling to the target.
 * `CMAKE_CXX_COMPILER`: The C++ compiler to use for cross compiling to the target.
 * `CMAKE_ASM_COMPILER`: The assembler to use for the target CPU.
 * `CMAKE_OBJCOPY`: The object copy tool to use for the target.
 * `CMAKE_OBJDUMP`: The object dump tool to use for the target.
 * `CMAKE_RANLIB`: The randomising tool for static libraries.
 * `CMAKE_READELF`: The readelf tool for target object files.
 * `CMAKE_SIZE_UTIL`: The object copy tool to use for the target.
 * `CMAKE_STRIP`: The strip tool to use for target objects.

#### toolchain-arm-none-eabi-gcc.cmake

This file defines the `gcc` cross-compilation toolchain for cross-compiling
to ARM embedded platforms.

In addition to the common toolchain variables, this file defines the following
variables:

 * `ARM_EABI_BINUTILS_PATH`: The path to the binutils for this toolchain.
 * `ARM_EABI_TOOLCHAIN_DIR`: The path to the binaries for this toolchain.

## Firmware

Supported firmware is referenced as a submodule.
To pull in the firmware for all supported hardware you can simply run:

```sh
git submodule update --init --recursive
```

Alternatively, you can pass in the specific subdirectory, e.g. for the Raspberry Pi Pico:

```sh
git submodule update --init --recursive firmware/Raspberry/pico-sdk 
```

## Toolchains

Make sure you have installed the toolchain for the hardware you want to compile for.
Some toolchains are generic (such as the `arm-none-eabi-gcc` toolchain that works
with many MCUs that use the ARM architecture).
In many cases, `clang` might have native cross-compilation support and no generic
toolchain installation might be required.

### ARM Toolchain

To install the generic `arm-none-eabi-gcc` toolchain on Ubuntu, use:

```sh
sudo apt install gcc-arm-none-eabi cmake
```

On macOS you can use [Homebrew](https://brew.sh) to install `gcc-arm-embedded`:

```sh
brew install gcc-arm-embedded
```

#### ARM M0+ Support

The above ARM toolchain does not support the ARM Cortex-M0+ architecture (which uses -march=armv6m).
To compile for hardware that uses the M0+ architecture, such as the Raspberry Pi Pico RP2040,
you'll need a toolchain that supports the ARM Cortex-M0+ architecture (which uses -march=armv6m).

To install that toolchain on macOS, you can use

```sh
brew tap ArmMbed/homebrew-formulae
brew install arm-none-eabi-gcc
export PATH="/opt/homebrew/opt/arm-none-eabi-gcc/bin:/usr/local/opt/arm-none-eabi-gcc/bin:$PATH"
```

On Linux, you can use the [xpack-dev-tools](https://github.com/xpack-dev-tools), e.g.:

```sh
wget https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v14.2.1-1.1/xpack-arm-none-eabi-gcc-14.2.1-1.1-linux-x64.tar.gz
sudo mkdir -p /opt/xpack-arm-none-eabi
sudo tar -xzf xpack-arm-none-eabi-gcc-*.tar.gz -C /opt/xpack-arm-none-eabi --strip-components=1
export PATH=/opt/xpack-arm-none-eabi/bin:$PATH
```

For other architectures, replace `x64` with the architecture, e.g.
https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v14.2.1-1.1/xpack-arm-none-eabi-gcc-14.2.1-1.1-linux-arm64.tar.gz
for a 64-bit ARM Linux host.

### RISC-V Toolchain

On macOS you can use [Homebrew](https://brew.sh) to tap and install `riscv-gnu-toolchain`:

```sh
brew tap riscv-software-src/riscv
brew install jimtcl riscv-gnu-toolchain riscv-isa-sim riscv-tools riscv-openocd
```

## Examples

Here is an example invocation using the `arm-none-eabi-gcc` toolchain:

**Pre-requisites**:
- Ensure that you have the `arm-none-eabi-gcc` toolchain
- Ensure that you have `cmake` installed

These can be installed on Ubuntu with:

**Build**:
```sh
cmake --preset arm-none-eabi-gcc-debug -DPROJECTS=EmptyTemplate -DBOARDS=nucleo_f207zg
cmake --build --preset arm-none-eabi-gcc-debug
```

Replace `EmptyTemplate` with your project (in one of the `projects` subdirectories
such as `bare_metal`, or use an absolute path).  Ensure that your project folder
contains a `project.cmake` file with the source files and include directories defined.
Replace `nucleo_f207zg` with your board (in one of the `boards` subdirectories such
as `STM`).

> NOTE: Ensure that this is invoked from the root directory of this repository, not inside the project directory.

