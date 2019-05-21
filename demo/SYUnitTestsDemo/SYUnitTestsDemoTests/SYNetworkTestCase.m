//
//  SYNetworkTestCase.m
//  SYUnitTestsDemoTests
//
//  Created by DR_Kun on 2019/5/21.
//  Copyright © 2019 CMSS_Outsource. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SYNetworkManager.h"
#import "SYConstant.h"

@interface SYNetworkTestCase : XCTestCase

@property (nonatomic, assign) NSTimeInterval shortTime;
@property (nonatomic, assign) NSTimeInterval longTime;

@end

@implementation SYNetworkTestCase

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.shortTime = 10;
    self.longTime = 30;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testAsyncRequest1 {
    
    [XCTContext runActivityNamed:@"step1" block:^(id<XCTActivity>  _Nonnull activity) {
        XCTestExpectation *expect1 = [self expectationWithDescription:@"asyncTest1"];
        
        [SYNetworkManagerInstance requestWithService:apiRecordSave completionHandler:^(NSDictionary *response) {
            XCTAssertTrue([response[@"code"] isEqualToString:@"300"]);
            [expect1 fulfill];
        }];
        
    }];
    [XCTContext runActivityNamed:@"step2" block:^(id<XCTActivity>  _Nonnull activity) {
        XCTestExpectation *expect2 = [self expectationWithDescription:@"asyncTest2"];
        
        [SYNetworkManagerInstance requestWithService:apiRecordDelete completionHandler:^(NSDictionary *response) {
            XCTAssertTrue([response[@"code"] isEqualToString:@"300"]);
            [expect2 fulfill];
        }];
        
        [XCTContext runActivityNamed:@"step3" block:^(id<XCTActivity>  _Nonnull activity) {
        }];
        
    }];
    
    [self waitShortTimeForExpectations];
    
}

- (void)testAsyncRequest2 {
    XCTestExpectation *expect3 = [[XCTestExpectation alloc] initWithDescription:@"asyncTest3"];
    
    [SYNetworkManagerInstance requestWithService:apiRecordList completionHandler:^(NSDictionary *response) {
        XCTAssertTrue([response[@"code"] isEqualToString:@"200"]);
        [expect3 fulfill];
    }];
    
    [self waitShortTimeForExpectations:@[expect3]];
    
}

- (void)testAsyncRequest3 {
    XCTWaiter *waiter = [[XCTWaiter alloc] initWithDelegate:self];
    XCTestExpectation *expect4 = [[XCTestExpectation alloc] initWithDescription:@"asyncTest3"];
    
    [SYNetworkManagerInstance requestWithService:@"product.list" completionHandler:^(NSDictionary *response) {
        XCTAssertTrue([response[@"code"] isEqualToString:@"200"]);
        [expect4 fulfill];
    }];
    
    XCTWaiterResult result = [waiter waitForExpectations:@[expect4] timeout:10 enforceOrder:NO];
    XCTAssert(result == XCTWaiterResultCompleted, @"failed: %ld", (long)result);
}


#pragma mark === 封装异步执行

- (void)waitShortTimeForExpectations {
    [self waitForExpectationsWithTimeout:self.shortTime handler:nil];
}

- (void)waitLongTimeForExpectations {
    [self waitForExpectationsWithTimeout:self.longTime handler:nil];
}

- (void)waitShortTimeForExpectations:(NSArray<XCTestExpectation *> *)expectations {
    [self waitForExpectations:expectations timeout:self.shortTime];
}

- (void)waitLongTimeForExpectations:(NSArray<XCTestExpectation *> *)expectations {
    [self waitForExpectations:expectations timeout:self.longTime];
}

- (void)addAttachmentWithScreenshot:(XCUIScreenshot *)screenshot attachmentName:(NSString *)attachmentName {
    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:screenshot];
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    attachment.name = attachmentName;
    [self addAttachment:attachment];
}



@end
