//
//  TaskStore.h
//  DigitPlayer
//
//  Created by Jack on 1/23/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CoreData/CoreData.h>

#if 0
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
#endif  //


@class DDGTask;

@interface DDGTaskStore : NSObject
{
    NSMutableArray *allUpdateTasks;
    NSMutableArray *allTaskItems;
    NSMutableArray *allNewTasks;
    NSMutableArray *allDelTask;
    
    // CoreData
    // ManagedObjectContext *managedObjectContext;
    // NSManagedObjectModel *managedObjectModel;
}


+ (DDGTaskStore *)sharedStore;

- (DDGTask *)createTask:(NSUInteger)type;
- (void)removeTask:(DDGTask *)taskItem;
- (NSString *)taskArchivePath;

- (void)loadTaskItems;
- (NSArray *)allTasks;
- (BOOL)saveTasks;
@end
