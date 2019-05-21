//
//  SYUnitTestsDemoUITests.m
//  SYUnitTestsDemoUITests
//
//  Created by DR_Kun on 2019/5/21.
//  Copyright © 2019 CMSS_Outsource. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SYUnitTestsDemoUITests : XCTestCase

@end

@implementation SYUnitTestsDemoUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    
    // [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    XCUIApplication *ttApp = [[XCUIApplication alloc] init];
    XCUIApplication *anotherApp = [[XCUIApplication alloc] initWithBundleIdentifier:@"Another.App.BundleId"];
    
    [ttApp launch];
    
    XCUIElement *addButton = ttApp.navigationBars[@"Record List"].buttons[@"Add"];
    [addButton tap];
    [anotherApp activate];
}

@end
