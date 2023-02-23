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
 
## Examples

Here is an example invocation:

```sh
cmake --preset arm-none-eabi-gcc-debug -DPROJECTS=EmtpyTemplate
cmake --build --preset arm-none-eabi-gcc-debug
```

Replace `EmptyTemplate` with your project (in one of the `projects` subdirectories
such as `bare_metal`, or use an absolute path).  Ensure that your project folder
contains a `project.cmake` file with the source files and include directories defined.
