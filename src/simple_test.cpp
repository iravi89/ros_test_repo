#include <gtest/gtest.h>
#include <climits>
#include <iostream>

// bad function:
// for example: how to deal with overflow?
int add(int a, int b){
    return a + b;
}

TEST(NumberCmpTest, ShouldPass){
    std::cout<<"RUNNING TEST CASES..1."<<std::endl;
    ASSERT_EQ(3, add(1,2));
}

TEST(NumberCmpTest, ShouldFail){
    std::cout<<"RUNNING TEST CASES...2"<<std::endl;
    ASSERT_EQ(INT_MAX, add(INT_MAX, 1));
}

int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    std::cout<<"RUNNING TEST CASES..."<<std::endl;
    return RUN_ALL_TESTS();
}
