//
//  TaskStore.m
//  DigitPlayer
//
//  Created by Jack on 1/23/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DDGTaskStore.h"

#import "DDGProjectTask.h"
#import "DDGReadTask.h"

//#import "../DDGRBtask+CoreDataClass.h"
//#import "../DDGTask+CoreDataClass.h"
//#import "DDGReadTask.h"
//#import "DDGTask.h"


#import "DDGDBExecutor.h"

@interface DDGTaskStore ()
{
//- (void)buildTask:(DDGTask *)task withData:(NSDictionary *)dict;
}


- (void)buildTask:(DDGTask *)task withDict:(NSDictionary *)dict;
- (void)buildProject:(DDGProjectTask *)project withDict:(NSDictionary *)dict;
- (void)buildRead:(DDGReadTask *)read withDict:(NSDictionary *)dict;

@end


@implementation DDGTaskStore
{
    //- (void)buildTask:(DDGTask *)task withData:(NSDictionary *)dict;
}


+ (DDGTaskStore *)sharedStore
{
    //static dispatch_once_t pred;
    
#if 0
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        static DDGTaskStore *sharedStore = nil;
        if (! sharedStore) {
            sharedStore = [super allocWithZone:nil];
        }
    });
#endif
    
    static DDGTaskStore *sharedStore = nil;

    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        [self loadTaskItems];
        
    }
    
    return self;
}

- (void)removeTask:(DDGTask *)taskItem
{
    [allTaskItems removeObject:taskItem];
}

- (DDGTask *)createTask:(NSUInteger)type
{
    DDGTask* newTask = nil;
    
    switch (type) {
        case kDDGShoppingTaskType:
            //newTask = (DDGTask *)[NSEntityDescription insertNewObjectForEntityForName:@"SPmall" inManagedObjectContext:managedObjectContext];
            newTask.taskType = [NSNumber numberWithInteger:kDDGShoppingTaskType];
            break;
            
        case kDDGReadingTaskType:
            newTask = [DDGReadTask new];
            newTask.taskType = [NSNumber numberWithInteger:kDDGReadingTaskType];
            break;
            
        case kDDGTravelTaskType:
            break;
            
        case kDDGProjectTaskType:
            newTask = [DDGProjectTask new];
            newTask.taskType = [NSNumber numberWithInteger:kDDGProjectTaskType];
            break;
    }
    
    if (newTask) {
        newTask.taskCreatedDate = [NSDate date];
        [allTaskItems addObject:newTask];
    }
    
    return newTask;
}

- (NSArray *)allTasks
{
    return [allTaskItems copy];
}

- (void)loadTaskItems
{
    if (nil == allTaskItems) {
        allTaskItems = [[NSMutableArray alloc] init];
    }
    
    NSDictionary* tasks = [[DDGDBExecutor sharedExecutor] getTasks];
    
    NSArray* projects = tasks[@"projects"];
    for (NSDictionary* iter in projects) {
        [self buildTask:[self createTask:kDDGProjectTaskType] withDict:iter];
    }
    
    NSArray* plans = tasks[@"plans"];
    for (NSDictionary* iter in plans) {
        [self buildTask:[self createTask:kDDGPlanTaskType] withDict:iter];
    }
    
    NSArray* reads = tasks[@"reads"];
    for (NSDictionary* iter in reads) {
        [self buildTask:[self createTask:kDDGReadingTaskType] withDict:iter];
    }
}

- (NSString *)taskArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"Digits.archives"];
}

- (BOOL)saveTasks
{
    for (DDGTask* task in [self allTasks]) {
        [[DDGDBExecutor sharedExecutor] saveTask:task];
    }
    
    return true;
}

- (void)buildTask:(DDGTask *)task withDict:(NSDictionary *)dict
{
    if (nil == dict || nil == task) {
        return;
    }
    
    switch (task.taskType.intValue) {
        case kDDGProjectTaskType:
            [self buildProject:(DDGProjectTask *)task withDict:dict];
            break;
            
        case kDDGReadingTaskType:
            [self buildRead:(DDGReadTask *)task withDict:dict];
            break;
    }
}

- (void)buildProject:(DDGProjectTask *)project withDict:(NSDictionary *)dict
{
    if (nil == project || nil == dict) {
        return;
    }
    
    project.taskTitle = dict[@"taskTitle"];
    project.projectDescrp = dict[@"projectDescrp"];
    project.taskBeginDate = dict[@"beginDate"];
    project.taskCreatedDate = dict[@"createdDate"];
    project.funcsArry = dict[@"funsArry"];
    project.bugsArry = dict[@"bugsArry"];
    
    NSLog(@"We are done it!");
}

- (void)buildRead:(DDGReadTask *)read withDict:(NSDictionary *)dict
{
    if (nil == read || nil == dict) {
        return;
    }
    
    read.taskCreatedDate = dict[@"createDate"];
    read.taskBeginDate = dict[@"beginDate"];
    read.taskPriority = dict[@"priority"];
    read.bkLibrary = dict[@"bkLibrary"];
    read.reBorrow = dict[@"bkReBorrow"];
    read.taskTitle = dict[@"bkTitle"];
    read.duration = dict[@"endDate"];
    read.bkImage = [UIImage imageWithData:dict[@"bkImage"]];
    
    if (nil == dict[@"bkIsbn10"]) {
        read.taskTitle = dict[@"bkIsbn13"];
    }
}

@end
