//
//  DDGSQLiteTaskStore.m
//  DigitPlayer
//
//  Created by HS_macOSSierra on 12/1/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGSQLiteTaskStore.h"
#import "DDGTask.h"

//#import "DDGTask+CoreDataClass.h"


#include "SQLite3Cpp.hpp"

#if 0
@interface <#class name#> : <#superclass#>
@end
#endif

#if 0
@interface <#class name#> (<#category name#>)
@end
#endif

#if 0
@interface <#class name#> ()
@end
#endif

#if 0
@implementation <#class#>
<#methods#>
@end
#endif

#if 0
@implementation <#class#> (<#category name#>)
<#methods#>
@end
#endif

@interface DDGSQLiteTaskStore ()
{
    
    int x;
    int y;
    
    SQLite3::Database sqliteDB;

    //int x;
    //int y;
}
@end


@implementation DDGSQLiteTaskStore


+ (DDGSQLiteTaskStore *)sharedStore
{
    static DDGSQLiteTaskStore *sharedStore = nil;

    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }

    return sharedStore;
}

- (void)removeTask:(DDGTask *)taskItem
{
}

- (bool)updateTask:(DDGTask *)taskItem
{
    return true;
}

- (NSArray *)allTasks
{
    return nil;
}

- (bool)saveTask:(DDGTask *)taskItem
{
    return true;
}

- (BOOL)saveTasks
{
    return true;
}

@end
