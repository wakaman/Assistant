//
//  TaskStore.h
//  DigitPlayer
//
//  Created by Jack on 1/23/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class DDGTask;

@interface DDGTaskStore : NSObject
{
    NSMutableArray *allTaskItems;
    
    // CoreData
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
}


+ (DDGTaskStore *)sharedStore;

- (void)removeTask:(DDGTask *)taskItem;
- (DDGTask *)createTask;
- (NSArray *)allTasks;

- (NSString *)taskArchivePath;
- (void)loadTaskItems;

- (BOOL)saveTasks;
@end
