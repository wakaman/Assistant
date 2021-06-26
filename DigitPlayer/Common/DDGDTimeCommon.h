//
//  DDGDTimeCommon.h
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 3/18/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDGDTimeCommon : NSObject

// + (NSString*)date
+ (double)intervalBetween:(NSDate*)beginDate toDate:(NSDate*)endDate;
+ (NSString*)compareDate:(NSDate*)beginDate withDate:(NSDate*)endDate;
+ (NSString*)durationFromDate:(NSDate*)beginDate toDate:(NSDate*)endDate;

@end
