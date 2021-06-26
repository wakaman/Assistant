//
//  DDGSQLiteTaskStore.h
//  DigitPlayer
//
//  Created by HS_macOSSierra on 12/1/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>



//typedef NS_ENUM(NSUInteger, DDGTaskType)
//{
    //kDDGSQLiteAppointTask,
    //kDDGSQLiteEventTask,
    //kDDGSQLiteShopTask,
    //kDDGSQLiteReadTask,
    //kDDGSQLitePlanTask,
    //kDDGSQLiteTravelTask,
    //kDDGSQLiteProjectTask,
    //kDDGSQLiteUnknowTask
//};


@class DDGTask;


@interface DDGSQLiteTaskStore : NSObject


+ (DDGSQLiteTaskStore *)sharedStore;


- (void)removeTask:(DDGTask *)taskItem;
- (bool)updateTask:(DDGTask *)taskItem;


//- (DDGTask *)createTask:(NSUInteger)type;
- (NSArray *)allTasks;


//- (NSString *)taskArchivePath;
//- (void)loadTaskItems;

- (bool)saveTask:(DDGTask *)taskItem;
- (BOOL)saveTasks;


@end
