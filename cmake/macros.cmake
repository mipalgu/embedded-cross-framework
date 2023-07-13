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
function(check_boards valid_boards)
    if(NOT BOARDS OR BOARDS STREQUAL "ALL_BOARDS")
        set(BOARDS ${valid_boards})
    else()
        foreach(board ${valid_boards})
            if(BOARDS MATCHES ${board})
                return()
            endif()
        endforeach()
        message(FATAL_ERROR "Board(s) ${BOARDS} not supported by ${PROJECT}")
    endif()
endfunction()

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
        set(executable ${subproject}.elf)
        if (${board} IN_LIST ${project}_BOARDS OR NOT ${project}_BOARDS)
            build_subproject_for_board(${project} ${board} ${subproject} ${executable})
        else()
            message(STATUS "Project ${project} does not support board ${board} (supported boards: ${${project}_BOARDS})")
        endif()
    endforeach()
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
    target_link_directories(${executable} PRIVATE
        ${OS_LIBDIR}
        ${DRIVER_LIBDIR}
        ${${board}_LIBDIR}
        ${${project}_LIBDIR}
        ${${subproject}_LIBDIR}
        ${${project}_${${board}_CLASS}_LIBDIR}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}_LIBDIR}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}_LIBDIR}
        ${${project}_${${board}_CLASS}${${board}_SUBCLASS}${${board}_FAMILY}${${board}_MODEL}_LIBDIR}
        ${TOOLCHAIN_LIBDIR}
        ${TOOLCHAIN_LIBGCC_DIR}
    )
    target_link_options(${executable} PRIVATE
        ${TOOLCHAIN_LINK_FLAGS}
        ${${board}_LDFLAGS}
        ${${project}_LDFLAGS}
        ${${subproject}_LDFLAGS}
        -Xlinker -T${${subproject}_LINKER_SCRIPT}
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
        COMMAND ${CMAKE_OBJCOPY} -Osrec --srec-len=64 $<TARGET_FILE:${executable}> ${subproject}.s19
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

