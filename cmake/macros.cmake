# Find all directories grouped by their parent directory
macro(find_grouped_directories group_basedir dir_basename_list)
    file(GLOB top_level RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir} ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir}/*)
    foreach(top_level_entry ${top_level})
        file(GLOB sub_dirs RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir} ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir}/${top_level_entry}/*)
        foreach(sub_dir ${sub_dirs})
            if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${group_basedir}/${top_level_entry}/${sub_dir})
                list(APPEND ${dir_basename_list} ${sub_dir})
            endif()
        endforeach()
    endforeach()
    list(REMOVE_DUPLICATES ${group_basedir})
endmacro()

# Find all projects
macro(find_projects project_list)
    find_grouped_directories(projects ${project_list})
endmacro()

# Find all boards
macro(find_boards board_list)
    find_grouped_directories(boards ${board_list})
endmacro()

# Check or set the BOARD variable against/to supported boards
macro(check_boards valid_boards)
    if(NOT BOARDS)
        set(BOARDS ${valid_boards} CACHE STRING "Boards to build for")
    else()
        if (NOT BOARDS MATCHES ${valid_boards})
            message(FATAL_ERROR "Board(s) ${BOARDS} not supported by ${PROJECT}")
        endif()
    endif()
endmacro()

# Build the given projects for the given boards.
macro(build_projects_for_boards projects boards valid_projects)
    foreach(project ${projects})
        cmake_path(GET ${project} FILENAME project_name)
        if(IS_ABSOLUTE ${project})
            include(${project}/project.cmake)
        elseif(project MATCHES ${valid_projects})
            include(${CMAKE_CURRENT_SOURCE_DIR}/${project}/project.cmake)
        else()
            message(FATAL_ERROR "Project ${project} not in supported projects: ${valid_projects}")
        endif()
        foreach(board ${boards})
            if(IS_ABSOLUTE ${board})
               include(${board}/board.cmake)
            elseif(exists ${CMAKE_CURRENT_SOURCE_DIR}/boards/${board}/board.cmake)
                include(${CMAKE_CURRENT_SOURCE_DIR}/boards/${board}/board.cmake)
            else()
                message(FATAL_ERROR "Board ${board} not found.")
            endif()
            if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/boards/${board}/include)
                list(APPEND ${board}_INCLUDES ${CMAKE_CURRENT_SOURCE_DIR}/boards/${board}/include)
            endif()
            if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/boards/${board}/libs)
                list(APPEND ${board}_LIBS ${CMAKE_CURRENT_SOURCE_DIR}/boards/${board}/libs)
            endif()
        endforeach()
        build_project_for_boards(${project} ${boards} "${${project}_SOURCES}" "${${project}_LIBRARIES}")
    endforeach()
endmacro()

# Build the project for the given boards
macro(build_project_for_boards project boards sources libraries)
    foreach(board ${boards})
        cmake_path(GET ${board} FILENAME board_name)
        set(subproject ${project}_${board_name})
        set(executable ${subproject}.elf)
        if(list(length ${project}_BOARDS) EQUAL 0 OR ${board} IN_LIST ${project}_BOARDS)
            build_subproject_for_board(${project} ${board} ${subproject} ${executable} "${${subproject}_SOURCES} ${sources}" "${${subproject}_LIBRARIES} ${libraries}")
        else()
            message(STATUS "Project ${project} does not support board ${board} (supported boards: ${${project}_BOARDS})")
        endif()
    endforeach()
endmacro()

# Build the subproject for the given board
macro(build_subproject_for_board project board subproject executable sources libraries)
    add_executable(${executable} ${sources} ${${project}_SOURCES} ${${subproject}_SOURCES})
    target_include_directories(${executable} PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${OS_INCLUDES}
        ${DRIVER_INCLUDES}
        ${${board}_INCLUDES}
        ${${project}_INCLUDES}
        ${${subproject}_INCLUDES}
    )

    target_link_libraries(${executable} PRIVATE
        ${TOOLCHAIN_LIBS}
        ${OS_LIBS}
        ${DRIVER_LIBS}
        ${${board}_LIBS}
        ${${project}_LIBS}
        ${${subproject}_LIBS}
    )

    # Create hex, bin, and s-records
    add_custom_command(TARGET ${executable} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${executable}> ${executable}.hex
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${executable}> ${executable}.bin
        COMMAND ${CMAKE_OBJCOPY} -Osrec --srec-len=64 $<TARGET_FILE:${executable}> ${executable}.s19
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

