//
//  DDGDTimeCommon.m
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 3/18/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGDTimeCommon.h"

@implementation DDGDTimeCommon

+ (double)intervalBetween:(NSDate*)beginDate toDate:(NSDate*)endDate
{
    if (beginDate == nil || endDate == nil) {
        return 0.0f;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeZone* beginZone = [NSTimeZone systemTimeZone];
    NSInteger beginInterval = [beginZone secondsFromGMTForDate:beginDate];
    NSDate* beginLocal = [beginDate dateByAddingTimeInterval:beginInterval];
    
    NSTimeZone* endZone = [NSTimeZone systemTimeZone];
    NSInteger endInterval = [endZone secondsFromGMTForDate:endDate];
    NSDate* endLocal = [endDate dateByAddingTimeInterval:endInterval];
    
    return [endLocal timeIntervalSinceReferenceDate] - [beginLocal timeIntervalSinceReferenceDate];
}

+ (NSString*)compareDate:(NSDate*)beginDate withDate:(NSDate*)endDate
{
    if (beginDate == nil || endDate == nil) {
        return @"";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    NSComparisonResult result = [beginDate compare:endDate];
    NSString* strRet;
    
    if (NSOrderedSame == result) {
        [formatter setDateFormat:@"HH:mm:ss"];
        strRet = [formatter stringFromDate:beginDate];
    } else {
        strRet = [formatter stringFromDate:beginDate];
        NSTimeInterval  oneDay = 24 * 60 * 60 * 1;    // One day
        NSDate* date;
        
        if (NSOrderedAscending == result) {
            date = [beginDate initWithTimeIntervalSinceNow:+oneDay];
            if (NSOrderedSame == [date compare:endDate]) {
                strRet = @"Yestoday";
            }
        } else {
            date = [beginDate initWithTimeIntervalSinceNow:-oneDay];
            if (NSOrderedSame == [date compare:endDate]) {
                strRet = @"tomorrow";
            }
        }
    }
    
    return strRet;
}

+ (NSString*)durationFromDate:(NSDate*)beginDate toDate:(NSDate*)endDate
{
    NSTimeInterval duration = [DDGDTimeCommon intervalBetween:beginDate toDate:endDate];
    NSString* strRet = nil;
    
    if ((int)duration / (24 * 60 * 60)) {
        strRet = [NSString stringWithFormat:@"%ld Day", (long)(duration / (24 * 60 * 60))];
        return strRet;
    }
    
    if ((int)duration / (60 * 60)) {
        strRet = [NSString stringWithFormat:@"%ld Hour", (long)(duration / (60 * 60))];
        return strRet;
    }

    if ((int)duration / 60) {
        strRet = [NSString stringWithFormat:@"%ld Mins", (long)(duration / 60)];
        return strRet;
    }
    
    if ((int)duration) {
        strRet = [NSString stringWithFormat:@"%ld Sec", (long)duration];
        return strRet;
    }
    
    return strRet;
}

@end
