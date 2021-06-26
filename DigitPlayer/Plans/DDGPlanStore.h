//
//  DDGPlanStore.h
//  DigitPlayer
//
//  Created by Jack on 3/23/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDGPlanStore : NSObject

{
    NSMutableArray* allPlans;
}

+ (DDGPlanStore*)sharedStore;


- (void)addPlan:(id)planItem;
- (NSArray*)allPlanItems;

- (NSString*)itemArchivePath;
- (BOOL)savePlans;

@end
