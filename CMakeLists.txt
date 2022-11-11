cmake_minimum_required(VERSION 3.18)
project(knx_iot_embedded C CXX ASM)

if(NOT CMAKE_SYSTEM_PROCESSOR STREQUAL M2351)
    message(FATAL_ERROR "This project cannot build without the appropriate toolchain file. Please delete the binary dir and pass the -DCMAKE_TOOLCHAIN_FILE flag according to the documentation in README.md")
endif()

include(FetchContent)

# Download the Cascoda SDK and KNX-IOT stack.
FetchContent_Declare(
    cascoda-sdk
    GIT_REPOSITORY https://github.com/Cascoda/cascoda-sdk.git
    GIT_TAG master
)

set(CASCODA_BUILD_KNX ON CACHE BOOL "Enable the KNX-IoT Port")

message(STATUS "Downloading KNX-IOT & Cascoda SDK source code...")
FetchContent_MakeAvailable(cascoda-sdk)

# Compile the Push Button Example

add_executable(knx-iot-devboard-pb
	# KNX-IoT code, common across all platforms
    ${PROJECT_SOURCE_DIR}/knx_iot_virtual_pb.c
    # Embedded specific code populating the callbacks defined by the KNX-IoT applications
    ${PROJECT_SOURCE_DIR}/knx_iot_pb_dev.c
    # Embedded specific main loop, which initialises the MCU, communications & then runs the KNX application
    ${PROJECT_SOURCE_DIR}/knx_iot_wakeful_main.c
)

target_link_libraries(knx-iot-devboard-pb
    kisClientServer
    kis-port
    # Openthread Minimal Thread Device
    ca821x-openthread-bm-mtd
    # Library for interfacing with the devboard
    cascoda-bm-devboard
)

target_compile_definitions(knx-iot-devboard-pb PRIVATE NO_MAIN)

# Set the size of the stack and the heap, respectively
cascoda_configure_memory(knx-iot-devboard-pb 0x1500 0xc000)
# Generate the .bin file to be flashed onto the Chili
cascoda_make_binary(knx-iot-devboard-pb)

# Compile the switching actuator example
add_executable(knx-iot-devboard-sa
    ${PROJECT_SOURCE_DIR}/knx_iot_virtual_sa.c
    ${PROJECT_SOURCE_DIR}/knx_iot_sa_dev.c
    ${PROJECT_SOURCE_DIR}/knx_iot_wakeful_main.c
)

target_link_libraries(knx-iot-devboard-sa
    kisClientServer
    kis-port
    ca821x-openthread-bm-mtd
    cascoda-bm-devboard
)

target_compile_definitions(knx-iot-devboard-sa PRIVATE NO_MAIN)

cascoda_make_binary(knx-iot-devboard-sa)
cascoda_configure_memory(knx-iot-devboard-sa 0x1500 0xc000)
