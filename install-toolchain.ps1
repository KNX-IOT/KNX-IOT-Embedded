# Must run in ADMIN powershell
choco install ninja gcc-arm-embedded -y
choco install cmake -y --installargs 'ADD_CMAKE_TO_PATH=System'
