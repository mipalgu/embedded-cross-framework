# Common Raspberry Pi Pico board configuration
string(TOUPPER ${board_name} BOARD_NAME_UPPERCASE)
set(BOARD_VENDOR "Raspberry Pi")

# Default values, can be overwritten by the board configuration
set(BOARD_DESCRIPTION "Raspberry Pi Pico")
set(${board_name}_CLASS "RP")        # Raspberry Pi
set(${board_name}_SUBCLASS "2")      # Dual-core
set(${board_name}_FAMILY "0")        # Cortex-M0+ architecture
set(${board_name}_MODEL "4")         # 264KB SRAM (log2(264/16) ≈ 4)
set(${board_name}_VARIANT "0")       # No integrated flash

set(${board_name}_CPUNAME "ARM Cortex-M0+")
set(${board_name}_CPU "ARM_CPU_CORTEX_M0PLUS")

set(PICO_DEFAULT_GCC_TRIPLE arm-none-eabi)

if(NOT DEFINED PICO_CHIP)
    set(PICO_CHIP "rp2040" CACHE STRING "Chip type")
endif()

string(TOUPPER ${PICO_CHIP} PICO_CHIP_UPPERCASE)

if(NOT DEFINED PICO_DEFAULT_PLATFORM)
    set(PICO_DEFAULT_PLATFORM ${PICO_CHIP} CACHE STRING "Platform type")
endif()

if(NOT DEFINED PICO_DEFAULT_BOARD)
    set(PICO_DEFAULT_BOARD "${board_name}" CACHE STRING "Board type")
endif()

if(NOT DEFINED PICO_PLATFORM)
    set(PICO_PLATFORM ${PICO_DEFAULT_PLATFORM} CACHE STRING "Platform type")
endif()

if(NOT DEFINED PICO_BOARD)
    set(PICO_BOARD ${PICO_DEFAULT_BOARD} CACHE STRING "Board type")
endif()

#
# Raspberry Pi Pico specific settings
#
if(WIN32)
    set(USERHOME $ENV{USERPROFILE})
else()
    set(USERHOME $ENV{HOME})
endif()
set(sdkVersion 2.1.1)
set(toolchainVersion 14_2_Rel1)
set(picotoolVersion 2.1.1)

# Board-specific include directory
set(${board_name}_INCDIR ${${board_name}_DIR}/include)
set(${board_name}_INCDIR_FALLBACK ${${board_name}_DIR}/../include)

# Common compiler flags
set(${board_name}_COMMON_FLAGS -ffunction-sections -fdata-sections -fno-common -fmessage-length=0)

# Pico SDK paths
set(${board_name}_FIRMWARE "pico-sdk")
set(${board_name}_FIRMWARE_DIR ${firmware_${${board_name}_FIRMWARE}_DIR})
set(${board_name}_SDK_DIR ${${board_name}_FIRMWARE_DIR})

if (NOT PICO_SDK_PATH)
    if (DEFINED ENV{PICO_SDK_PATH})
        set(PICO_SDK_PATH $ENV{PICO_SDK_PATH})
        message("Using PICO_SDK_PATH from environment ('${PICO_SDK_PATH}')")
    else()
        set(PICO_SDK_PATH ${${board_name}_SDK_DIR})
        message("Using PICO_SDK_PATH: '${PICO_SDK_PATH}'")
    endif()
endif()

if (NOT PICO_TOOLCHAIN_PATH)
    if (DEFINED ENV{PICO_TOOLCHAIN_PATH})
        set(PICO_TOOLCHAIN_PATH $ENV{PICO_TOOLCHAIN_PATH})
        message("Using PICO_TOOLCHAIN_PATH from environment ('${PICO_TOOLCHAIN_PATH}')")
    else()
        if (ARM_EABI_TOOLCHAIN_DIR)
            set(PICO_TOOLCHAIN_PATH ${ARM_EABI_TOOLCHAIN_DIR})
        elseif(RISCV_TOOLCHAIN_DIR)
            set(PICO_TOOLCHAIN_PATH ${RISCV_TOOLCHAIN_DIR})
        endif()
        message("Using PICO_TOOLCHAIN_PATH: '${PICO_TOOLCHAIN_PATH}'")
    endif()
endif()

# Pull in Raspberry Pi Pico SDK (must be before project)
set(PICO_LIB_PATH ${PICO_SDK_PATH}/lib)
set(PICO_SRC_PATH ${PICO_SDK_PATH}/src)
set(PICO_CMAKE_PATH ${PICO_SDK_PATH}/cmake)
set(PICO_RP2_COMMON_PATH ${PICO_SRC_PATH}/rp2_common)
set(PICO_CMSIS_PATH ${PICO_RP2_COMMON_PATH}/cmsis)
set(PICO_CMSIS_STUB_PATH ${PICO_CMSIS_PATH}/stub/CMSIS)
# Make sure the SDK paths are added to CMAKE_MODULE_PATH
list(APPEND CMAKE_MODULE_PATH ${PICO_SDK_PATH})
list(APPEND CMAKE_MODULE_PATH ${PICO_CMAKE_PATH})
list(APPEND CMAKE_MODULE_PATH ${PICO_SRC_PATH})
list(APPEND CMAKE_MODULE_PATH ${PICO_SRC_PATH}/cmake)

# include(${PICO_SDK_PATH}/pico_sdk_version.cmake)
# include(${PICO_CMAKE_PATH}/pico_utils.cmake)

# set(${board_name}_STARTUP_SRC ${PICO_SRC_PATH}/rp2_common/pico_crt0/crt0.S)

# list(APPEND PICO_PRE_DEFINES "__weak=__attribute__((weak))")
# list(APPEND PICO_COMMON_INCDIRS ${PICO_SRC_PATH}/common/pico_base_headers/include)

# function(pico_add_subdirectory subdir)
#     string(TOUPPER ${subdir} subdir_upper)
#     get_filename_component(subdir_upper ${subdir_upper} NAME)
#     set(skip_flag SKIP_${subdir_upper})
#     if (NOT ${skip_flag})
#         message("Appending ${subdir} SKIP_${subdir_upper}=${SKIP_${subdir_upper}}")
#         set(PICO_SUBDIRS ${PICO_SUBDIRS})
#         if (${ARGC} GREATER 1)
#             list(APPEND PICO_SUBDIRS ${ARGV2}/${subdir})
#         else()
#             list(APPEND PICO_SUBDIRS ${subdir})
#         endif()
#         set(PICO_SUBDIRS ${PICO_SUBDIRS} PARENT_SCOPE)
#     endif()
# endfunction()

# function(pico_add_doxygen SOURCE_DIR)
#     if (NOT IS_ABSOLUTE "${SOURCE_DIR}")
#         get_filename_component(SOURCE_DIR "${SOURCE_DIR}" ABSOLUTE BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
#     endif()
#     set(PICO_DOXYGEN_PATHS ${PICO_DOXYGEN_PATHS})
#     list(APPEND PICO_DOXYGEN_PATHS "${SOURCE_DIR}")
#     set(PICO_DOXYGEN_PATHS ${PICO_DOXYGEN_PATHS} PARENT_SCOPE)
# endfunction()

# function(pico_add_doxygen_pre_define definition)
#     set(PICO_PRE_DEFINES ${PICO_PRE_DEFINES})
#     list(APPEND PICO_PRE_DEFINES ${definition})
#     set(PICO_PRE_DEFINES ${PICO_PRE_DEFINES} PARENT_SCOPE)
# endfunction()

# function(pico_add_doxygen_enabled_section section)
#     set(PICO_DOXYGEN_ENABLED_SECTIONS ${PICO_DOXYGEN_ENABLED_SECTIONS})
#     list(APPEND PICO_DOXYGEN_ENABLED_SECTIONS ${section})
#     set(PICO_DOXYGEN_ENABLED_SECTIONS ${PICO_DOXYGEN_ENABLED_SECTIONS} PARENT_SCOPE)
# endfunction()

# function(pico_add_doxygen_exclude SOURCE_DIR)
#     if (NOT IS_ABSOLUTE "${SOURCE_DIR}")
#         get_filename_component(SOURCE_DIR "${SOURCE_DIR}" ABSOLUTE BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
#     endif()
#     set(PICO_DOXYGEN_EXCLUDE_PATHS ${PICO_DOXYGEN_EXCLUDE_PATHS})
#     list(APPEND PICO_DOXYGEN_EXCLUDE_PATHS "${SOURCE_DIR}")
#     set(PICO_DOXYGEN_EXCLUDE_PATHS ${PICO_DOXYGEN_EXCLUDE_PATHS} PARENT_SCOPE)
# endfunction()

# if(NOT DEFINED USE_RTOS OR NOT USE_RTOS)
#     # Modules known not to compile without RTOS, so skip for now.
#     set(SKIP_PICO_ASYNC_CONTEXT 1)
#     set(SKIP_PICO_BTSTACK 1)
#     set(SKIP_PICO_CYW43_DRIVER 1)
#     set(SKIP_PICO_CYW43_ARCH 1)
#     set(SKIP_PICO_LWIP 1)
#     set(SKIP_PICO_CLIB_INTERFACE 1)
#     set(SKIP_PICO_FIX 1)
#     set(SKIP_PICO_MBEDTLS 1)
#     set(SKIP_PICO_STDIO_USB 1)
#     set(SKIP_PICO_MBEDTLS 1)
#     set(SKIP_PICO_STDIO_USB 1)
# endif()
