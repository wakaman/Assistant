//
//  DDGTask.h
//  DigitPlayer
//
//  Created by HS_macOSSierra on 12/11/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, DDGTaskType)
{
    kDDGAppointTaskType,
    kDDGEventTaskType,
    kDDGShoppingTaskType,
    kDDGReadingTaskType,
    kDDGPlanTaskType,
    kDDGTravelTaskType,
    kDDGProjectTaskType,
    kDDGUnknowTaskType
};

@interface DDGTask : NSObject

#if 0
@property (nullable, nonatomic, strong) NSDate *taskCreatedDate;
@property (nullable, nonatomic, strong) NSDate *taskBeginDate;
@property (nullable, nonatomic, strong) NSNumber *taskPriority;
@property (nullable, nonatomic, strong) NSNumber *taskType;
@property (nullable, nonatomic, copy) NSString *taskTitle;
#endif


@property (nonatomic, strong) NSDate *taskCreatedDate;
@property (nonatomic, strong) NSDate *taskBeginDate;
@property (nonatomic, strong) NSNumber *taskPriority;
@property (nonatomic, strong) NSNumber *taskType;
@property (nonatomic, copy) NSString *taskTitle;



@end
