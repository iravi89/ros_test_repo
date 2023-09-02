FROM ros:noetic as base
RUN apt update && apt install libgtest-dev software-properties-common lsb-release build-essential g++ cmake -y
RUN mkdir /tmp/gtest_build && cd /tmp/gtest_build && \
    cmake /usr/src/gtest && \
    make && \
    cp /tmp/gtest_build/lib/*.a /usr/lib 

FROM base as prep
RUN mkdir -p test_ws/src
WORKDIR test_ws/
COPY . /test_ws/src/

FROM prep as build
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash && catkin_make'
CMD /bin/bash -c '. /opt/ros/noetic/setup.bash && roscore & sleep 1 && devel/lib/gtest_ros_example/rostalker & sleep 1 && devel/lib/gtest_ros_example/roslistener'

FROM prep as test
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash && catkin_make tests'
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash && roscore & sleep 1 && . /opt/ros/noetic/setup.bash && devel/lib/gtest_ros_example/talker-test'
