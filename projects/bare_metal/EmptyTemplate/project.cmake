#
# Project configuration.
#
# Set the project name
project(${project_name} C CXX ASM)

set(${project_name}_VERSION_MAJOR 1)
set(${project_name}_VERSION_MINOR 0)
set(${project_name}_VERSION_PATCH 0)

# Sources for the project.
set(${project_name}_SOURCES 
    ${${project_name}_DIR}/src/main.c
)

# Include directories for the project.
set(${project_name}_INCDIR
    ${${project_name}_DIR}/include
)