# Projects

This directory contains the embedded system projects that can be compiiled
to run on one or more of the available boards.
At the top level are directories that group the project by their run time
environment, such as `bare_metal`, `rtos`, etc.

## Project Format

Each project is a directory within a project group contains the source files
and `CMakeListst.txt` to build the binaries for that project, as well as a
`project.cmake` that designates the module/driver dependencies for the project.
