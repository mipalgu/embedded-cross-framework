# Find all directories grouped by their parent directory
macro(find_grouped_directories group_basedir dir_basename_list)
    file(GLOB top_level RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir} ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir}/*)
    foreach(top_level_category ${top_level})
        file(GLOB sub_dirs RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir}/${top_level_category} ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir}/${top_level_category}/*)
        foreach(sub_dir ${sub_dirs})
            if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir}/${top_level_category}/${sub_dir})
                set(${group_basedir}_${sub_dir}_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir}/${top_level_category}/${sub_dir})
                set(${group_basedir}_${sub_dir}_CATEGORY ${top_level_category})
                list(APPEND ${dir_basename_list} ${sub_dir})
            endif()
        endforeach()
    endforeach()
    list(REMOVE_DUPLICATES ${dir_basename_list})
endmacro()

# Find all projects
macro(find_projects project_list)
    find_grouped_directories(projects ${project_list})
endmacro()

# Find all boards
macro(find_boards board_list)
    find_grouped_directories(boards ${board_list})
endmacro()

# Find firmware
macro(find_firmware firmware_list)
    find_grouped_directories(firmware ${firmware_list})
endmacro()

# Check or set the BOARD variable against/to supported boards
macro(check_boards valid_boards)
    if(NOT BOARDS OR BOARDS STREQUAL "ALL_BOARDS")
        set(BOARDS ${${valid_boards}})
    else()
        foreach(board ${BOARDS}) 
            if(NOT ${board} IN_LIST ${valid_boards})
                message(FATAL_ERROR "Board ${board} not supported by ${PROJECT}")
            endif()
        endforeach()
    endif()
endmacro()

# Build the given projects for the given boards.
macro(build_projects_for_boards projects boards valid_projects)
    foreach(project ${projects})
        cmake_path(GET project FILENAME project_name)
        if(IS_ABSOLUTE ${project})
            set(${project_name}_DIR ${project})
            include(${project}/project.cmake)
        else()
            string(REGEX MATCH "(^|;)${project_name}(;|$)" _match "${valid_projects}")
            if(NOT _match STREQUAL "")
                set(${project_name}_DIR ${projects_${project_name}_DIR})
                set(${project_name}_CATEGORY ${projects_${project_name}_CATEGORY})
                include(${${project_name}_DIR}/project.cmake)
            else()
                message(FATAL_ERROR "Project ${project} not in supported projects: ${valid_projects}")
            endif()
        endif()
        set(${project_name}_VERSION
            ${${project_name}_VERSION_MAJOR}.${${project_name}_VERSION_MINOR}.${${project_name}_VERSION_PATCH})
        set(${project_name}_VERSION_STRING
            "${${project_name}_VERSION_MAJOR}.${${project_name}_VERSION_MINOR}.${${project_name}_VERSION_PATCH}")
        foreach(board ${boards})
            cmake_path(GET board FILENAME board_name)
            message(STATUS "Building project ${project_name} for board ${board_name}")
            if(IS_ABSOLUTE ${board})
                set(${board_name}_DIR ${board})
                include(${board}/board.cmake)
            # else check if board.cmake file exists in the board directory
            elseif(EXISTS ${boards_${board}_DIR}/board.cmake)
                set(${board_name}_DIR ${boards_${board}_DIR})
                include(${boards_${board}_DIR}/board.cmake)
            else()
                message(FATAL_ERROR "Board ${board} not found.")
            endif()
            if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/boards/${board}/include)
                list(APPEND ${board}_INCDIR ${CMAKE_CURRENT_SOURCE_DIR}/boards/${board}/include)
            endif()
            if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/boards/${board}/libs)
                list(APPEND ${board}_LIBS ${CMAKE_CURRENT_SOURCE_DIR}/boards/${board}/libs)
            endif()
        endforeach()
        build_project_for_boards(${project_name} ${boards})
    endforeach()
endmacro()

# Build the project for the given boards
macro(build_project_for_boards project boards)
    foreach(board ${boards})
        cmake_path(GET board FILENAME board_name)
        set(subproject ${project}_${board_name})
        if(DEFINED ${TARGET_TRIPLET}_USE_FPGA)
            set(executable ${subproject}.bit)
            message(STATUS "project: ${project}\nboard: ${board}\nsubproject: ${subproject}\nexecutable: ${executable}")
            if (${project}_ARRANGEMENT)
                process_arrangement( ${project} ${board} ${subproject} ${executable})
            endif()
            if (${board} IN_LIST ${project}_BOARDS OR NOT ${project}_BOARDS)
                create_build_scripts_for_board(${project} ${board} ${subproject} ${executable})
            else()
                message(STATUS "Project ${project} does not support board ${board} (supported boards: ${${project}_BOARDS})")
            endif()
        else()
            set(executable ${subproject}.elf)
            if (${board} IN_LIST ${project}_BOARDS OR NOT ${project}_BOARDS)
                build_subproject_for_board(${project} ${board} ${subproject} ${executable})
            else()
                message(STATUS "Project ${project} does not support board ${board} (supported boards: ${${project}_BOARDS})")
            endif()
        endif()
    endforeach()
endmacro()

macro(process_arrangement project board subproject executable)
    set(LLFSMHDL_BIN_PATH
        /bin
        /usr/bin
        /usr/local/bin
    )
    find_program(LLFSMGENERATE NAMES llfsmgenerate PATH ${LLFSMHDL_BIN_PATH})
    if(LLFSMGENERATE)
        message(STATUS "Found llfsmgenerate: ${LLFSMGENERATE}")
        set(${subproject}_BASE ${subproject})
        if (DEFINED ${CMAKE_PROJECT_NAME}_PROJECT_DIRECTORY)
            set(${subproject}_PROJECT_BASE ${${subproject}_BASE}/${subproject}_PROJECT_DIRECTORY)
        else()
            set(${subproject}_PROJECT_BASE ${${subproject}_BASE})
        endif()
        if (NOT DEFINED ${project}_PROJECT_DIRECTORY_NAME)
            set(${project}_PROJECT_DIRECTORY_NAME "vivado_project")
        endif()
        set(${project}_PROJECT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/projects/fpga/${project}/${${project}_PROJECT_DIRECTORY_NAME}")
        get_filename_component(${project}_ARRANGEMENT_PARENT "${CMAKE_CURRENT_SOURCE_DIR}/projects/fpga/${project}/${${project}_ARRANGEMENT}" PATH)
        get_filename_component(${project}_ARRANGEMENT_NAME "${CMAKE_CURRENT_SOURCE_DIR}/projects/fpga/${project}/${${project}_ARRANGEMENT}" NAME)
        message(STATUS "executing llfsmgenerate model for ${${project}_ARRANGEMENT_NAME} in ${${project}_ARRANGEMENT_PARENT}")
        execute_process(
            COMMAND ${LLFSMGENERATE} model ${${project}_ARRANGEMENT_NAME}
            WORKING_DIRECTORY ${${project}_ARRANGEMENT_PARENT}
        )
        message(STATUS "executing llfsmgenerate vhdl for ${${project}_ARRANGEMENT_NAME} in ${${project}_ARRANGEMENT_PARENT}")
        execute_process(
            COMMAND ${LLFSMGENERATE} vhdl ${${project}_ARRANGEMENT_NAME}
            WORKING_DIRECTORY ${${project}_ARRANGEMENT_PARENT}
        )
        message(STATUS "executing llfsmgenerate install for ${${project}_ARRANGEMENT_NAME} in ${${project}_ARRANGEMENT_PARENT}")
        execute_process(
            COMMAND ${LLFSMGENERATE} install ${${project}_ARRANGEMENT_NAME} --vivado ${${project}_PROJECT_DIRECTORY}
            WORKING_DIRECTORY ${${project}_ARRANGEMENT_PARENT}
        )
    else()
        message(FATAL_ERROR "Cannot find llfsmgenerate. Please add llfsmgenerate to your PATH to compile LLFSMs.")
    endif()
endmacro()

# Create the build scripts for FPGA subprojects.
macro(create_build_scripts_for_board project board subproject executable)
    message(STATUS "Building FPGA project ${subproject} for board ${board} in project ${project} creating executable ${executable}.")
    set(${subproject}_BASE ${subproject})
    if (DEFINED ${CMAKE_PROJECT_NAME}_PROJECT_DIRECTORY)
        set(${subproject}_PROJECT_BASE ${${subproject}_BASE}/${subproject}_PROJECT_DIRECTORY)
    else()
        set(${subproject}_PROJECT_BASE ${${subproject}_BASE})
    endif()
    if (NOT DEFINED ${project}_PROJECT_DIRECTORY_NAME)
        set(${project}_PROJECT_DIRECTORY_NAME "vivado_project")
    endif()
    set(${project}_PROJECT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/projects/fpga/${project}/${${project}_PROJECT_DIRECTORY_NAME}")
    message(STATUS "Project directory: ${${project}_PROJECT_DIRECTORY}")
    file(COPY ${${project}_PROJECT_DIRECTORY} DESTINATION ${${subproject}_PROJECT_BASE})
    set(${subproject}_SOURCES_PARENT_DIR ${${project}_PROJECT_DIRECTORY_NAME}/${project}.srcs)
    set(${subproject}_PROJECT_FILE ${CMAKE_CURRENT_BINARY_DIR}/${${subproject}_PROJECT_BASE}/${${project}_PROJECT_DIRECTORY_NAME}/${project}.xpr)
    set(${subproject}_HDL_SOURCES_DIR ${CMAKE_CURRENT_BINARY_DIR}/${${subproject}_PROJECT_BASE}/${${subproject}_SOURCES_PARENT_DIR}/sources_1/new)
    set(${subproject}_CONSTRAINTS_DIR ${CMAKE_CURRENT_BINARY_DIR}/${${subproject}_PROJECT_BASE}/${${subproject}_SOURCES_PARENT_DIR}/constrs_1/new)
    set(${subproject}_BITSTREAM ${CMAKE_CURRENT_BINARY_DIR}/${${subproject}_PROJECT_BASE}/${${project}_PROJECT_DIRECTORY_NAME}/${project}.runs/impl_1/${executable})
    set(
        ${subproject}_CONFIGURE_SCRIPT
        "open_project ${${subproject}_PROJECT_FILE}"
        "set_property PART ${${board}_FPGA_PART} [current_project]"
        "close_project"
        "quit"
    )
    string(REPLACE ";" "\n" ${subproject}_CONFIGURE_SCRIPT "${${subproject}_CONFIGURE_SCRIPT}")
    file(GLOB ${subproject}_SRCS CONFIGURE_DEPENDS "${${subproject}_HDL_SOURCES_DIR}/*.vhd" "${${subproject}_HDL_SOURCES_DIR}/*.v")
    file(GLOB ${subproject}_CONSTRAINTS CONFIGURE_DEPENDS "${${subproject}_CONSTRAINTS_DIR}/*.xdc")
    set(${subproject}_BUILD_COMMANDS
        "open_project ${${subproject}_PROJECT_FILE}"
        "add_files ${${subproject}_SRCS}"
        "add_files ${${subproject}_CONSTRAINTS}"
        "launch_runs synth_1 -jobs 8"
        "wait_on_run synth_1"
        "launch_runs impl_1 -jobs 8"
        "wait_on_run impl_1"
        "open_run impl_1"
        "write_bitstream -force ${${subproject}_BITSTREAM}"
        "close_project"
    )
    string(REPLACE ";" "\n" ${subproject}_BUILD_SCRIPT "${${subproject}_BUILD_COMMANDS}")
    set(${subproject}_CLEAN_COMMANDS
        "open_project ${${subproject}_PROJECT_FILE}"
        "reset_run synth_1"
        "close_project"
    )
    string(REPLACE ";" "\n" ${subproject}_CLEAN_SCRIPT "${${subproject}_CLEAN_COMMANDS}")
    set(${subproject}_UPLOAD_COMMANDS
        "open_project ${${subproject}_PROJECT_FILE}"
        "open_hw_manager"
        "connect_hw_server"
        "open_hw_target"
        "create_hw_bitstream -hw_device [current_hw_device] ${${subproject}_BITSTREAM}"
        "program_hw_device"
        "close_hw_target"
        "disconnect_hw_server"
        "close_project"
        "quit"
    )
    string(REPLACE ";" "\n" ${subproject}_UPLOAD_SCRIPT "${${subproject}_UPLOAD_COMMANDS}")
    set(${subproject}_CONFIGURE_SCRIPT_LOC ${CMAKE_CURRENT_BINARY_DIR}/${${subproject}_BASE}/configure.tcl)
    set(${subproject}_BUILD_SCRIPT_LOC ${CMAKE_CURRENT_BINARY_DIR}/${${subproject}_BASE}/build.tcl)
    set(${subproject}_CLEAN_SCRIPT_LOC ${CMAKE_CURRENT_BINARY_DIR}/${${subproject}_BASE}/clean.tcl)
    set(${subproject}_UPLOAD_SCRIPT_LOC ${CMAKE_CURRENT_BINARY_DIR}/${${subproject}_BASE}/upload.tcl)
    file(WRITE ${${subproject}_CONFIGURE_SCRIPT_LOC} ${${subproject}_CONFIGURE_SCRIPT})
    file(WRITE ${${subproject}_CLEAN_SCRIPT_LOC} ${${subproject}_CLEAN_SCRIPT})
    file(WRITE ${${subproject}_UPLOAD_SCRIPT_LOC} ${${subproject}_UPLOAD_SCRIPT})
    file(WRITE ${${subproject}_BUILD_SCRIPT_LOC} ${${subproject}_BUILD_SCRIPT})
    execute_process(
        COMMAND ${TOOLCHAIN_COMPILER} ${CMAKE_FPGA_FLAGS} configure.tcl
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${${subproject}_BASE}
    )
    add_custom_target(
        xilinx-build ALL
        ${TOOLCHAIN_COMPILER} ${CMAKE_FPGA_FLAGS} ${${subproject}_BUILD_SCRIPT_LOC} VERBATIM
        BYPRODUCTS ${${subproject}_BITSTREAM}
        DEPENDS ${${subproject}_BUILD_SCRIPT_LOC}
    )

    add_custom_target(
        xilinx-clean
        ${TOOLCHAIN_COMPILER} ${CMAKE_FPGA_FLAGS} ${${subproject}_CLEAN_SCRIPT_LOC} VERBATIM
        DEPENDS ${${subproject}_CLEAN_SCRIPT_LOC}
    )
    # add_custom_target(xilinx-install ${VIVADO_BIN} -mode tcl -source ${CMAKE_CURRENT_BINARY_DIR}/upload.tcl VERBATIM DEPENDS ${VIVADO_BITSTREAM})
    install(
        CODE "execute_process(COMMAND ${TOOLCHAIN_COMPILER} ${CMAKE_FPGA_FLAGS} ${${subproject}_UPLOAD_SCRIPT_LOC})"
        DEPENDS ${${subproject}_BITSTREAM} ${${subproject}_UPLOAD_SCRIPT_LOC}
    )
endmacro()

# Build the subproject for the given board
macro(build_subproject_for_board project board subproject executable)
    if(NOT ${subproject}_STARTUP_SRC)
        if(NOT ${project}_STARTUP_SRC)
            set(${subproject}_STARTUP_SRC ${${board}_STARTUP_SRC})
        else()
            set(${subproject}_STARTUP_SRC ${${project}_STARTUP_SRC})
        endif()
    endif()
    foreach(toolchain_lib ${TOOLCHAIN_LINK_LIBS})
        message(STATUS "Adding ${subproject} toolchain library ${toolchain_lib}")
        add_library(${subproject}_LIB_${toolchain_lib} STATIC ${TOOLCHAIN_LINK_LIB_${toolchain_lib}_SOURCES})
        target_compile_options(${subproject}_LIB_${toolchain_lib} PRIVATE ${${board}_CFLAGS})
        target_compile_definitions(${subproject}_LIB_${toolchain_lib} PRIVATE ${${board}_DEFINES})
        target_include_directories(${subproject}_LIB_${toolchain_lib}
            PRIVATE
            ${${toolchain_lib}_INCDIR}
            ${${project}_INCDIR}
            ${${subproject}_INCDIR}
            ${${project}_${${board}_CLASS}_INCDIR}
            ${${project}_${${board}_CLASS}${${board}_SUBCLASS}_INCDIR}
            ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}_INCDIR}
            ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}${${board}_MODEL}_INCDIR}
        )
        list(APPEND ${subproject}_TOOLCHAIN_LIBS ${subproject}_LIB_${toolchain_lib})
    endforeach()
    if(${${project}_USE_FREERTOS})
        message(STATUS "Using FreeRTOS")
        set(${subproject}_FREERTOS_LIBS ${subproject}_FREERTOS)
        add_library(${subproject}_FREERTOS STATIC ${${board}_FREERTOS_SRCS})
        target_compile_options(${subproject}_FREERTOS PRIVATE ${${board}_CFLAGS})
        target_compile_definitions(${subproject}_FREERTOS PRIVATE ${${board}_DEFINES})
        target_include_directories(${subproject}_FREERTOS
            PRIVATE
            ${${project}_INCDIR}
            ${${subproject}_INCDIR}
            ${${project}_${${board}_CLASS}_INCDIR}
            ${${project}_${${board}_CLASS}${${board}_SUBCLASS}_INCDIR}
            ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}_INCDIR}
            ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}${${board}_MODEL}_INCDIR}
            PUBLIC
            ${${board}_FREERTOS_INCDIRS}
        )
    endif()
    # Add the middleware/uswift library if support for Swift is enabled.
    get_property(ENABLED_LANGS GLOBAL PROPERTY ENABLED_LANGUAGES)
    if("Swift" IN_LIST ENABLED_LANGS)
        message(STATUS "Using Swift")
        # set(${subproject}_USWIFT_LIBS ${subproject}_USWIFT)
        # add_library(${subproject}_USWIFT STATIC ${${board}_USWIFT_SRCS})
        # target_compile_options(${subproject}_USWIFT PRIVATE ${${board}_CFLAGS})
        # target_compile_definitions(${subproject}_USWIFT PRIVATE ${${board}_DEFINES})
        # target_include_directories(${subproject}_USWIFT
        #     PRIVATE
        #     ${${project}_INCDIR}
        #     ${${subproject}_INCDIR}
        #     ${${project}_${${board}_CLASS}_INCDIR}
        #     ${${project}_${${board}_CLASS}${${board}_SUBCLASS}_INCDIR}
        #     ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}_INCDIR}
        #     ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}${${board}_MODEL}_INCDIR}
        #     PUBLIC
        #     ${${board}_USWIFT_INCDIRS}
        # )
    endif()
    # Add any toolchain specific libraries
    add_executable(${executable}
        ${${subproject}_STARTUP_SRC}
        ${${project}_SOURCES}
        ${${subproject}_SOURCES}
        ${${project}_${${board}_CLASS}_SOURCES}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}_SOURCES}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}_SOURCES}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}${${board}_MODEL}_SOURCES}
    )
    target_compile_options(${executable} PRIVATE
      $<$<COMPILE_LANGUAGE:C,CXX>:
        ${${board}_CFLAGS}
        ${${project}_CFLAGS}
        ${${subproject}_CFLAGS}
      >
      $<$<COMPILE_LANGUAGE:Swift>:
        ${${board}_SwiftFLAGS}
        ${${project}_SwiftFLAGS}
        ${${subproject}_SwiftFLAGS}
      >
    )
    target_compile_definitions(${executable} PRIVATE
        ${${board}_DEFINES}
        ${${project}_DEFINES}
        ${${subproject}_DEFINES}
    )
    target_include_directories(${executable} PRIVATE
        ${TOOLCHAIN_INCLUDE_DIRS}
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${OS_INCDIR}
        ${DRIVER_INCDIR}
        ${${project}_INCDIR}
        ${${subproject}_INCDIR}
        ${${project}_${${board}_CLASS}_INCDIR}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}_INCDIR}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}_INCDIR}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}${${board}_MODEL}_INCDIR}
        ${${board}_INCDIR}
        ${${board}_HAL_INCDIR}
        ${${board}_HAL_INCDIR_LEGACY}
        ${${board}_CMSIS_DEVICE_INCDIR}
        ${${board}_CMSIS_INCDIR}
        ${${board}_FREERTOS_INCDIRS}
    )

    if(NOT ${subproject}_LINKER_SCRIPT)
        if(NOT ${project}_LINKER_SCRIPT)
            set(${subproject}_LINKER_SCRIPT ${${board}_LINKER_SCRIPT})
        else()
            set(${subproject}_LINKER_SCRIPT ${${project}_LINKER_SCRIPT})
        endif()
    endif()
    if(${subproject}_LINKER_SCRIPT)
       set(${subproject}_LINKER_ARGS ${TOOLCHAIN_LINKER_SCRIPT_FLAGS}${${subproject}_LINKER_SCRIPT})
       MESSAGE(STATUS "${subproject}_LINKER_ARGS: ${${subproject}_LINKER_ARGS} ${TOOLCHAIN_XLINKER_PREFIX} ${TOOLCHAIN_LINKER_SCRIPT_PREFIX}${${subproject}_LINKER_SCRIPT}")
    endif()
    target_link_directories(${executable} PRIVATE
        ${${subproject}_LIBDIR}
        ${OS_LIBDIR}
        ${DRIVER_LIBDIR}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}${${board}_MODEL}_LIBDIR}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}_LIBDIR}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}_LIBDIR}
        ${${project}_${${board}_CLASS}_LIBDIR}
        ${${project}_LIBDIR}
        ${${board}_LIBDIR}
        ${TOOLCHAIN_LIBDIR}
        ${TOOLCHAIN_LIBGCC_DIR}
    )
    target_link_options(${executable} PRIVATE
        ${TOOLCHAIN_LINK_FLAGS}
        ${${board}_LDFLAGS}
        ${${project}_LDFLAGS}
        ${${subproject}_LDFLAGS}
        ${${subproject}_LINKER_ARGS}
    )
    target_link_libraries(${executable} PRIVATE
        ${TOOLCHAIN_LIBS}
        ${OS_LIBS}
        ${DRIVER_LIBS}
        ${${board}_LIBS}
        ${${project}_LIBS}
        ${${subproject}_LIBS}
        ${${subproject}_FREERTOS_LIBS}
        ${${subproject}_TOOLCHAIN_LIBS}
    )

    # Create hex, bin, and s-records
    add_custom_command(TARGET ${executable} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${executable}> ${subproject}.hex
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${executable}> ${subproject}.bin
        COMMAND ${CMAKE_OBJCOPY} -Osrec --srec-len=64 $<TARGET_FILE:${executable}> ${subproject}.s19 || cp $<TARGET_FILE:${executable}> ${subproject}.out
    )

    # Print the binary size
    add_custom_command(TARGET ${executable} POST_BUILD
        COMMAND ${CMAKE_SIZE} ${executable}
    )

    # Install the binary on the board
    if(INSTALL_SCRIPT)
        if(INSTALL_SCRIPT_ARGS)
            install(CODE "execute_process(COMMAND ${INSTALL_SCRIPT} ${INSTALL_SCRIPT_ARGS} ${CMAKE_CURRENT_BINARY_DIR}/${executable}.bin)")
        else()
            install(CODE "execute_process(COMMAND ${INSTALL_SCRIPT} ${CMAKE_CURRENT_BINARY_DIR}/${executable}.bin)")
        endif()
    elseif(${${subproject}_INSTALL_SCRIPT})
        if(${${subproject}_INSTALL_SCRIPT_ARGS})
            install(CODE "execute_process(COMMAND ${${subproject}_INSTALL_SCRIPT} ${${subproject}_INSTALL_SCRIPT_ARGS} ${CMAKE_CURRENT_BINARY_DIR}/${executable}.bin)")
        else()
            install(CODE "execute_process(COMMAND ${${subproject}_INSTALL_SCRIPT} ${CMAKE_CURRENT_BINARY_DIR}/${executable}.bin)")
        endif()
    elseif(${${project}_INSTALL_SCRIPT})
        if(${${project}_INSTALL_SCRIPT_ARGS})
            install(CODE "execute_process(COMMAND ${${project}_INSTALL_SCRIPT} ${${project}_INSTALL_SCRIPT_ARGS} ${CMAKE_CURRENT_BINARY_DIR}/${executable}.bin)")
        else()
            install(CODE "execute_process(COMMAND ${${project}_INSTALL_SCRIPT} ${CMAKE_CURRENT_BINARY_DIR}/${executable}.bin)")
        endif()
    endif(INSTALL_SCRIPT)
endmacro(build_subproject_for_board)

