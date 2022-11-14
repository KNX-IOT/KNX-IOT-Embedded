mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE="../arm_gcc_m2351.cmake" -G "Ninja" ; cmake .
ninja
