# Include common Board definitions
include(${CMAKE_CURRENT_LIST_DIR}/../board_common.cmake)
# Include active pico platform definitions
include(${PICO_CMAKE_PATH}/pico_pre_load_platform.cmake)
# Get the pico board subdirectories
if (EXISTS ${PICO_SRC_PATH}/${PICO_CHIP}.cmake)
    include(${PICO_SRC_PATH}/${PICO_CHIP}.cmake)
else()
    include(${PICO_SRC_PATH}/cmake/rp2_common.cmake)
endif()

foreach(define ${PICO_PRE_DEFINES})
    list(APPEND ${board_name}_DEFINES -D${define})
endforeach()

set(${board_name}_CFLAGS
    ${PICO_COMMON_LANG_FLAGS}
    ${${board_name}_COMMON_FLAGS}
)

set(${board_name}_LDFLAGS
    ${PICO_COMMON_LANG_FLAGS}
    ${TOOLCHAIN_LINKER_FLAG}
    ${TOOLCHAIN_LINKER_PREFIX}--gc-sections
    ${TOOLCHAIN_LINKER_EXTRA_LDFLAGS}
)

set(${board_name}_LINKER_SCRIPT ${PICO_SRC_PATH}/${PICO_CHIP}/memmap_default.ld)

set(${board_name}_SDK_BOARD_INCDIR ${PICO_SRC_PATH}/boards/include/boards/${PICO_BOARD}.h})
set(PICO_BOARD_INCLUDE ${${board_name}_SDK_BOARD_INCDIR}/${PICO_BOARD}.h})
if (EXISTS ${PICO_BOARD_INCLUDE})
    set(${board_name}_BOARD_INCLUDE ${PICO_BOARD_INCLUDE})
endif()

message("PICO_SUBDIRS is ${PICO_SUBDIRS}")
foreach(subdir ${PICO_SUBDIRS})
    set(abs_dir ${PICO_SRC_PATH}/${subdir})
    set(include_dir ${abs_dir}/include)
    if (EXISTS ${include_dir})
        list(APPEND ${board_name}_SDK_COMMON_INCDIRS ${include_dir})
    endif()
    file(GLOB_RECURSE srcs ${abs_dir}/*.c)
    list(APPEND ${board_name}_SDK_COMMON_SRCS ${srcs})
endforeach()

set(${board_name}_HAL_INCDIRS ${${board_name}_SDK_COMMON_INCDIRS})
set(${board_name}_HAL_SRCS ${${board_name}_SDK_COMMON_SRCS})

add_library(${board_name}_HAL STATIC ${${board_name}_HAL_SRCS})
target_compile_options(${board_name}_HAL PRIVATE ${${board_name}_CFLAGS})
target_compile_definitions(${board_name}_HAL PRIVATE ${${board_name}_DEFINES})
target_include_directories(${board_name}_HAL
    PRIVATE ${${board_name}_INCDIR_HAL_LIB}
    PUBLIC ${${board_name}_INCDIR}
    ${${board_name}_INCDIR}
    ${${board_name}_SDK_BOARD_INCDIR}
    ${${board_name}_HAL_INCDIRS}
)

set(${board_name}_LIBS
    ${board_name}_HAL
    #${board_name}_CMSIS
    #${board_name}_CMSIS_DEVICE
)
