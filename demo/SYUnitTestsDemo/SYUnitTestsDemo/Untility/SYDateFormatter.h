//
//  SYDateFormatter.h
//  SYUnitTestsDemo
//
//  Created by DR_Kun on 2019/5/21.
//  Copyright © 2019 CMSS_Outsource. All rights reserved.
//

#import <Foundation/Foundation.h>

static const double sec = 1.0;
static const double min = sec * 60;
static const double hour = min * 60;
static const double day = hour * 24;

NS_ASSUME_NONNULL_BEGIN

@interface SYDateFormatter : NSObject

+ (NSString *)stringFormatWithDate:(NSDate *)date;

+ (NSDate *)dateFormatWithString:(NSString *)dateString;

+ (BOOL)isTodayWithDateString:(NSString *)dateString;

+ (NSString *)getHowLongAgoWithTimeStamp:(NSTimeInterval)timeStamp;

+ (NSString *)getHowLongAgoWithTimeInterval:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
