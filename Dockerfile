FROM ros:noetic as base
RUN apt update && apt install libgtest-dev software-properties-common lsb-release build-essential g++ cmake -y

FROM base as build
RUN mkdir /tmp/gtest_build && cd /tmp/gtest_build && \
    cmake /usr/src/gtest && \
    make && \
    cp /tmp/gtest_build/lib/*.a /usr/lib 
RUN mkdir -p test_ws/src
WORKDIR test_ws/
COPY . test_ws/src/
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash && catkin_make'

FROM build as test
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash && catkin_make tests'
RUN ls devel/lib/gtest_ros_example/
RUN . /test_ws/test_ws/devel/lib/gtest_ros_example/talker-test
