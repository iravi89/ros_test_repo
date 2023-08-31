[![Build Status](https://github.com/KR-Ravindra/ros_test_repo/actions/workflows/cicd.yml/badge.svg)](https://github.com/KR-Ravindra/ros_test_repo/actions/workflows/cicd.yml)

# ros_test_repo
## Build gtest

First of all one as to build gtest, because installing `libgtest-dev` under Ubuntu only gives you the sources.

    sudo apt-get install libgtest-dev
    mkdir /tmp/gtest_build && cd /tmp/gtest_build
    cmake /usr/src/gtest
    make
    #copy or symlink libgtest.a and ligtest_main.a to /usr/lib folder
    sudo cp *.a /usr/lib
In this case, you have to specify some environment variables before running `catkin_make`, which is discussed below.

## Build this package

First checkout this repository into some `src` folder of a catkin workspace.
Then just build the common execuatbles (which also include a  application) via:

    create workspace  `mkdir test_ws` 
    cd test_ws
    mkdir src
    cd src
    git clone git@github.com:iravi89/ros_test_repo.git
    cd ../
    catkin_make

Catkin now builds `rostalker`, `roslistener`, and `simple_test`.
`simple_test` is just a gtest example w/o any catkin magic (c.f. CMakeLists.txt).
`rostalker` and `roslistener` don't have any gtest dependencies at all, and should build out of the box.

To build the test for the talker's `add` member function, call catkin like this:

    catkin_make tests

Catkin now builds `talker-test` and `simple_test_catkin`.
`simple_test_catkin` is just a gtest example w/ catkin magic (c.f. CMakeLists.txt).

## Running executables

roscore &

One can run any executable like this 
rosrun gtest_ros_example <the executable name>

If one has to install the gtest libraries in some other folder (e.g. into `~/lib/`), catkin has to be called like this:

    LIBRARY_PATH=~/lib GTEST_ROOT=~/lib catkin_make

`LIBRARY_PATH` tells the linker where to find the libraries, while `GTEST_ROOT` gives cmake the location hints for it's checks.

## To Do

    1.  Create Docker image
    2. Integrate CI/CD pipeline
    3. Build code and run gtest
    4. send report of gtest over mail to user
    5. validation link send to user verify build over email
    6. On validation, deploy the build to remote server
    7. Send success/failure report to user after deployment.


    
    

