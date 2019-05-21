//
//  SYDateFormatterTestsCase.m
//  SYUnitTestsDemoTests
//
//  Created by DR_Kun on 2019/5/21.
//  Copyright © 2019 CMSS_Outsource. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SYDateFormatter.h"

@interface SYDateFormatterTestsCase : XCTestCase

@end

@implementation SYDateFormatterTestsCase

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testDateFormatter {
    NSString *originDateString = @"2018-06-06 20:20:20";
    NSDate *date = [SYDateFormatter dateFormatWithString:originDateString];
    NSString *dateString = [SYDateFormatter stringFormatWithDate:date];
    XCTAssertEqualObjects(dateString, originDateString);
}

- (void)testDateFormatterIsToday {
    NSString *dateString = [SYDateFormatter stringFormatWithDate:[NSDate date]];
    XCTAssertTrue([SYDateFormatter isTodayWithDateString:dateString]);
    XCTAssertFalse([SYDateFormatter isTodayWithDateString:@"2000-01-01"]);
}

- (void)testDateFormatterHowLongAgo {
    NSDate *now = [NSDate date];
    NSString *secAgo = [SYDateFormatter getHowLongAgoWithTimeStamp:now.timeIntervalSince1970 - 10 * sec];
    XCTAssertEqualObjects(secAgo, @"10秒前");
    
    NSString *minAgo = [SYDateFormatter getHowLongAgoWithTimeStamp:now.timeIntervalSince1970 - 15 * min];
    XCTAssertEqualObjects(minAgo, @"15分钟前");
    
    NSString *hourAgo = [SYDateFormatter getHowLongAgoWithTimeStamp:now.timeIntervalSince1970 - 20 * hour];
    XCTAssertEqualObjects(hourAgo, @"20小时前");
    
    NSString *dayAgo = [SYDateFormatter getHowLongAgoWithTimeStamp:now.timeIntervalSince1970 - 25 * hour];
    XCTAssertEqualObjects(dayAgo, @"1天前");
    
    NSString *daysAgo = [SYDateFormatter getHowLongAgoWithTimeStamp:now.timeIntervalSince1970 - 50 * hour];
    XCTAssertEqualObjects(daysAgo, @"2天前");
    
    NSString *longTimeAgo = [SYDateFormatter getHowLongAgoWithTimeStamp:1544002463];
    XCTAssertEqualObjects(longTimeAgo, @"2018-12-05 17:34:23");
    
}


@end
