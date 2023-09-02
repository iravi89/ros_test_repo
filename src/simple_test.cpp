#include <gtest/gtest.h>
#include <climits>

// bad function:
// for example: how to deal with overflow?
int add(int a, int b){
    return a + b + 10;
}

TEST(NumberCmpTest, ShouldPass){
    ASSERT_EQ(13, add(1,2));
}


int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

