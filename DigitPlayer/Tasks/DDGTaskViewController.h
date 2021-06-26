//
//  DDGTaskViewController.h
//  DigitPlayer
//
//  Created by Hackintosh-Developer on 1/8/2017.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

//enum DDGTaskViewType : NSInteger
//typedef enum DDGTaskViewType DDGTaskViewType;

//typedef NS_OPTIONS(NSUInteger, DDGTaskViewType)
typedef NS_ENUM(NSUInteger, DDGTaskViewType)
{
    kDDGTaskViewTypeAppoint,
    kDDGTaskViewtypeEvent,
    kDDGTaskViewTypeShop,
    kDDGTaskViewTypeRead,
    kDDGTaskViewTypePlan,
    kDDGTaskViewtypeTravel,
    kDDGTaskViewTypeProject,
    kDDGTaskViewTypeUnknow
};


#if 0
typedef NS_ENUM(NSUInteger, DDGTaskType)
{
    DDGTaskTypeAppoint,
    DDGTaskTypeEvent,
    DDGTaskTypeShop,
    DDGTaskTypeRead,
    DDGTaskTypePlan,
    DDGTaskTypeTravel,
    DDGTaskTypeProject,
    DDGTaskTypeUnknow
};
#endif


@class DDGTask;


@interface DDGTaskViewController : UIViewController
{
}

@property (nonatomic, copy) void (^dismissBlock)(void);
@property (nonatomic, strong) DDGTask *currentTask;


+ (DDGTaskViewController *)createTaskViewController:(DDGTaskViewType)type;
//+ (DDGTaskViewController *)createTaskViewController:(NSUInteger)type;
@end
