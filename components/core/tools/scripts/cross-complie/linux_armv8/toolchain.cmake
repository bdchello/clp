# the name of the target operating system
set(CMAKE_SYSTEM_NAME Linux)

# which compilers to use
set(CMAKE_CXX_COMPILER i686-w64-mingw32-g++)

# the root path for find
set(CMAKE_FIND_ROOT_PATH /path/to/target/environment)
# adjust the default behaviour of the find commands:
# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)

# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)