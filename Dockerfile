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
WORKDIR /test_ws/test_ws/
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash && catkin_make tests'
RUN ls /test_ws/test_ws/devel/lib/gtest_ros_example
CMD /bin/bash -c '. /opt/ros/noetic/setup.bash && roscore & sleep 5 && . /opt/ros/noetic/setup.bash && devel/lib/gtest_ros_example/talker-test'
