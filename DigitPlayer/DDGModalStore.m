//
//  TaskStore.m
//  DigitPlayer
//
//  Created by Jack on 1/23/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGTaskStore.h"
#import "../DDGTask+CoreDataClass.h"

@implementation DDGTaskStore


+ (DDGTaskStore *)sharedStore
{
    //static TaskStore* instance = [[TaskStore alloc] init];
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
        
        managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *persStoreCood = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
        
        NSString *storePath = [self taskArchivePath];
        NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
        
        NSError *error = nil;
        if (![persStoreCood addPersistentStoreWithType:NSSQLiteStoreType
                                         configuration:nil
                                                   URL:storeUrl
                                               options:nil
                                                 error:&error]) {
            [NSException raise:@"Open failed"
                        format:@"Reason: %@", [error localizedDescription]];
            
        }
        
        // Create the managed object context
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:persStoreCood];
            
        // The managed object context can manage undo, but we don't need it
        [managedObjectContext setUndoManager:nil];
        [self loadTaskItems];
    }
    
    return self;
}

- (void)removeTask:(DDGTask *)taskItem
{
    [allTaskItems removeObject:taskItem];
}

- (DDGTask *)createTask
{
    double order = 0.0f;
    if ([allTaskItems count] == 0) {
        order = 1.0;
    } else {
        //order = [[allTaskItems lastObject] orderingValue]
    }
    
    NSLog(@"Adding after %lui items, order = %.2f", [allTaskItems count], order);
    
    DDGTask *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:managedObjectContext];
    [allTaskItems addObject:newTask];
    
    return newTask;
}

- (NSArray *)allTasks
{
    return allTaskItems;
}

- (void)loadTaskItems
{
    if (!allTaskItems) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [[managedObjectModel entitiesByName] objectForKey:@"Task"];
        [fetchRequest setEntity:entity];
        
        //NSSortDescriptor *sortDescrp = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        //[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescrp]];
        
        NSError *error;
        NSArray *result = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allTaskItems = [[NSMutableArray alloc] initWithArray:result];
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
    NSError *err = nil;
    BOOL successful = [managedObjectContext save:&err];
    
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    
    return successful;
}

@end
