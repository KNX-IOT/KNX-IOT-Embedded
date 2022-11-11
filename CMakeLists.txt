cmake_minimum_required(VERSION 3.18)
project(knx_iot_embedded C CXX ASM)

include(FetchContent)

# Download the Cascoda SDK and enable the KNX port
FetchContent_Declare(
    cascoda-sdk
    GIT_REPOSITORY https://github.com/Cascoda/cascoda-sdk.git
    GIT_TAG master
)

set(CASCODA_BUILD_KNX BOOL CACHE ON "Enable the KNX-IoT Port")

message(STATUS "Downloading Cascoda SDK source code...")
FetchContent_MakeAvailable(cascoda-sdk)

# Download the KNX-IoT source code
FetchContent_Declare(
    knx-iot-stack
    GIT_REPOSITORY https://github.com/KNX-IOT/KNX-IOT-STACK.git
    GIT_TAG master
)

message(STATUS "Downloading KNX-IOT source code...")
FetchContent_MakeAvailable(knx-iot-stack)

# Compile the Push Button Example

add_executable(knx-iot-devboard-pb
	# KNX-IoT code, common across all platforms
    ${PROJECT_SOURCE_DIR}/knx_iot_virtual_pb.c
    # Embedded specific code populating the callbacks defined by the KNX-IoT applications
    ${PROJECT_SOURCE_DIR}/knx_iot_chilidev_pb.c
    # Embedded specific main loop, which initialises the MCU, communications & then runs the KNX application
    ${PROJECT_SOURCE_DIR}/knx_iot_wakeful_main.c
)

target_link_libraries(knx-iot-devboard-pb
    kisClientServer
    kis-port
    ca821x-openthread-bm-mtd
    cascoda-bm-devboard
)

target_compile_definitions(knx-iot-devboard-pb PRIVATE NO_MAIN)

# Set the size of the stack and the heap, respectively
cascoda_configure_memory(knx-iot-devboard-pb 0x1500 0xc000)
# Generate the .bin file to be flashed onto the Chili
cascoda_make_binary(knx-iot-devboard-pb)
