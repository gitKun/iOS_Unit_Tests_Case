//
//  SYUnitTestsDemoTests.m
//  SYUnitTestsDemoTests
//
//  Created by DR_Kun on 2019/5/21.
//  Copyright © 2019 CMSS_Outsource. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SYUnitTestsDemoTests : XCTestCase

@end

@implementation SYUnitTestsDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //设置变量和设置预期值
    NSUInteger a = 10;NSUInteger b = 14;
    NSUInteger expected = 24;
    //执行方法得到实际值
    NSUInteger actual = [self add:a b:b];
    //断言判定实际值和预期是否符合
    XCTAssertEqual(expected, actual,@"add方法错误！");
}

-(NSUInteger)add:(NSUInteger)a b:(NSUInteger)b{
    return a + b;
}


- (void)testNoBaseLine {
    [self measureBlock:^{
        // 这里没有设置基准线，运行次方法时回报警告
        sleep(1);
    }];
}

- (void)testSomeBaseLine {
    [self measureBlock:^{
        // 设置了基准线
        sleep(1);
    }];
}

- (void)testOutBaseLine {
    [self measureBlock:^{
        sleep(1);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


- (void)testAsyncExample1 {
    /*
    // 测试类持有的初始化方法
    XCTestExpectation *expect1 = [self expectationWithDescription:@"asyncTest1"];
    // 自己持有的初始化方法
    XCTestExpectation *expect2 = [[XCTestExpectation alloc] initWithDescription:@"asyncTest2"];
    
    // 测试类持有时的等待方法
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
     */
    
    XCTestExpectation *exp = [self expectationWithDescription:@"这里可以是操作出错的原因描述。。。"];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        //模拟这个异步操作需要2秒后才能获取结果，比如一个异步网络请求
        sleep(2);
        //模拟获取的异步操作后，获取结果，判断异步方法的结果是否正确
        XCTAssertEqual(@"a", @"a");
        //如果断言没问题，就调用fulfill宣布测试满足
        [exp fulfill];
    }];
    
    //设置延迟多少秒后，如果没有满足测试条件就报错
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}


@end
