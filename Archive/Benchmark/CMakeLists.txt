cmake_minimum_required(VERSION 2.8)
set (CMAKE_CXX_STANDARD 11)
project( DisplayImage )

find_package( OpenCV REQUIRED )
add_executable( DisplayImage ../src/benchmark_planner.cpp )
target_link_libraries( DisplayImage ${OpenCV_LIBS} )
