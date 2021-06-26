//
//  DDGPlanStore.m
//  DigitPlayer
//
//  Created by Jack on 3/23/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGPlanStore.h"

@implementation DDGPlanStore

+ (DDGPlanStore*)sharedStore
{
    static DDGPlanStore* sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone*)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSString* keyPath = [self itemArchivePath];
        allPlans = [NSKeyedUnarchiver unarchiveObjectWithFile:keyPath];
        
        if (!allPlans) {
            allPlans = [[NSMutableArray alloc] init];
        }        
    }
    
    return self;
}

- (void)addPlan:(id)planItem
{
    if (planItem) {
        [allPlans addObject:planItem];
    }
}

- (NSArray*)allPlanItems
{
    return allPlans;
}

- (NSString*)itemArchivePath
{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"plans.archive"];
}

- (BOOL)savePlans
{
    NSString* keyPath = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:allPlans toFile:keyPath];
}

@end
