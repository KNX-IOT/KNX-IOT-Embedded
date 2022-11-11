cmake_minimum_required(VERSION 3.18)
project(knx_iot_embedded)

include(FetchContent)

FetchContent_Declare(
    cascoda-sdk
    GIT_REPOSITORY https://github.com/Cascoda/cascoda-sdk.git
    GIT_TAG master
)

option(CASCODA_BUILD_KNX ON)

if(NOT cascoda-sdk_POPULATED)
    message(STATUS "Downloading Cascoda SDK source code...")
    FetchContent_Populate(cascoda-sdk)
    add_subdirectory(${cascoda-sdk_SOURCE_DIR} ${cascoda-sdk_BINARY_DIR})
endif()

# FetchContent_Declare(
#     knx-iot-stack
#     GIT_REPOSITORY https://github.com/KNX-IOT/KNX-IOT-STACK.git
#     GIT_TAG master
# )

# message(STATUS "Downloading KNX-IOT source code...")
# FetchContent_MakeAvailable(knx-iot-stack)

add_executable(knx-iot-devboard-pb
    ${PROJECT_SOURCE_DIR}/knx_iot_virtual_pb.c
    ${PROJECT_SOURCE_DIR}/knx_iot_chilidev_pb.c
    ${PROJECT_SOURCE_DIR}/knx_iot_wakeful_main.c
)

target_link_libraries(knx-iot-devboard-pb
    kisClientServer
    kis-port
    ca821x-openthread-bm-mtd
    cascoda-bm-devboard
)

target_include_directories(knx-iot-devboard-pb
    PRIVATE
        ${PROJECT_SOURCE_DIR}/
)

target_compile_definitions(knx-iot-devboard-pb PRIVATE NO_MAIN)

cascoda_make_binary(knx-iot-devboard-pb)
cascoda_configure_memory(knx-iot-devboard-pb 0x1500 0xc000)
