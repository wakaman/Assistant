//
//  DPTaskItem.h
//  DigitPlayer
//
//  Created by Mavericks-Hackintosh on 1/17/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPTaskItem : NSObject
{
    /*
    NSString* title;
   
    NSString* actor;
    NSString* assistor;
    
    NSString* emergencyState;
    NSString* remark;
    
    NSString* address;
    
    NSDate* date;
    NSTimeInterval* time;
    */
}

+ (id)randomItem;

- (id)initWithTaskTitle:(NSString *)title
         valueInDollars:(int)value
          serialNumber:(NSString *)sNumber;

// @property (nonatomic, strong) BNRItem *containedItem;
// @property (nonatomic, weak) BNRItem *container;
// @property (nonatomic, copy) NSString *itemName;
// @property (nonatomic, copy) NSString *serialNumber;
// @property (nonatomic) int valueInDollars;
// @property (nonatomic, readonly, strong) NSDate *dateCreated;

@end
