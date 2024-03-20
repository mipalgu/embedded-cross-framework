<!--
 README.md
 embedded-cross-framework
 
 Created by Morgan McColl.
 Copyright © 2024 Morgan McColl. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above
    copyright notice, this list of conditions and the following
    disclaimer in the documentation and/or other materials
    provided with the distribution.
 
 3. All advertising materials mentioning features or use of this
    software must display the following acknowledgement:
 
    This product includes software developed by Morgan McColl.
 
 4. Neither the name of the author nor the names of contributors
    may be used to endorse or promote products derived from this
    software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
 OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 -----------------------------------------------------------------------
 This program is free software; you can redistribute it and/or
 modify it under the above terms or under the terms of the GNU
 General Public License as published by the Free Software Foundation;
 either version 2 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, see http://www.gnu.org/licenses/
 or write to the Free Software Foundation, Inc., 51 Franklin Street,
 Fifth Floor, Boston, MA  02110-1301, USA.
-->

# EmptyProject

This project demonstrates the ability to compile vivado projects using the `embedded-cross-framework`.

## Requirements

- Vivado 2022.1 or higher.
- CMake version 3.12 or higher.

## Compiling using the Framework

To include a vivado project within the `embedded-cross-framework`, create a new directory in `embedded-cross-framework/projects/fpga`. This directory will contain the relevant `cmake` files and the vivado project. Next, create a new subdirectory within this directory that will contain the vivado project files and source files. By default, the system will assume you have named this folder `vivado_project`, but you may override this behaviour by setting `${CMAKE_PROJECT_NAME}_PROJECT_DIRECTORY_NAME`. To avoid tracking the large vivado project, we have ignored it for this example, so you will have to create your own vivado project within the `vivado_project` folder for this demonstration. Lastly, create a new `project.cmake` with the language set to `HDL` and the project name set to the name of your directory within `projects/fpga`.

To start compiling this project, you may follow the same syntax as all other projects. For Example, to compile using vivado with a Zybo Z720 board, you may invoke the following commands from your terminal:

```shell
cd embedded-cross-framework
# configure
cmake --preset fpga-xilinx-unknown-vivado -DPROJECTS=EmptyProject -DBOARDS=zybo_z720
# build
cmake --build --preset fpga-xilinx-unknown-vivado
```

The generated bitstream is located at
```
embedded-cross-framework/.build/fpga-xilinx-unknown-vivado/EmptyProject_zybo_z720/vivado_project/EmptyProject.runs/impl_1/EmptyProject_zybo_z720.bit
```

You can upload the bitstream to your device via:
```shell
# install
cmake --build --target install --preset fpga-xilinx-unknown-vivado
```

Alternatively, you may clean the build artefacts via:
```shell
# clean
cmake --build --target xilinx-clean --preset fpga-xilinx-unknown-vivado
```
