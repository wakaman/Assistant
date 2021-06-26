//
//  DDGAppDelegate.m
//  DigitPlayer
//
//  Created by Mavericks-Hackintosh on 1/14/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGAppDelegate.h"
#import "DDGViewController.h"
#import "DDGTripleProjTableViewController.h"
#import "DDGForthPlanTableViewController.h"
#import "DDGMasterTaskViewController.h"
#import "DDGSlaveReadViewController.h"

//#import "../libcurl-ios-dist/include/curl/curl.h"

#import "DDGBookStore.h"
#import "DDGTaskStore.h"
#import "DDGPlanStore.h"
#import "DDGNetworker.h"


@implementation DDGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //curl_global_init(CURL_GLOBAL_ALL);

    
    DDGMasterTaskViewController* masterViewCtrl = [[DDGMasterTaskViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController* masterNavControl = [[UINavigationController alloc] initWithRootViewController:masterViewCtrl];
    [[masterNavControl tabBarItem] setTitle:@"Task"];
    [masterViewCtrl.navigationItem setTitle:@"TaskList"];
    
    DDGSlaveReadViewController* slaveVC = [[DDGSlaveReadViewController alloc] init];
    UINavigationController* slaveNavigate = [[UINavigationController alloc] initWithRootViewController:slaveVC];
    [[slaveNavigate tabBarItem] setTitle:@"RB"];
    
    DDGTripleProjTableViewController* tripleViewCtrl = [[DDGTripleProjTableViewController alloc] init];
    UINavigationController* tripleNavControl = [[UINavigationController alloc] initWithRootViewController:tripleViewCtrl];
    [[tripleNavControl tabBarItem] setTitle:@"Proj"];
    
    DDGForthPlanTableViewController* forthViewCtrl = [[DDGForthPlanTableViewController alloc] init];
    UINavigationController* forthNavControl = [[UINavigationController alloc] initWithRootViewController:forthViewCtrl];
    [[forthNavControl tabBarItem] setTitle:@"Plan"];
    
    UITabBarController* tabBarCtrl = [[UITabBarController alloc] init];
    [tabBarCtrl setViewControllers:[NSArray arrayWithObjects:masterNavControl, slaveNavigate, tripleNavControl, forthNavControl, nil]];
    
    self.window.rootViewController = tabBarCtrl;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    BOOL bRet = [[DDGBookStore sharedStore] saveBooks];
    if (bRet) {
        NSLog(@"Archived all books!");
    } else {
        NSLog(@"Archiving books failure!");
    }
    
    
    bRet = [[DDGTaskStore sharedStore] saveTasks];
    if (bRet) {
        NSLog(@"Archived all tasks!");
    } else {
        NSLog(@"Archiving all tasks failure!");
    }
    
    // Upload all tasks which doesn't aside on person server
    // we can use it in other gcd thread so there are not blocks happen
    for (id item in [[DDGBookStore sharedStore] allBooks]) {
        [[DDGNetworker sharedInstance] uploadTask:item];
    };
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    BOOL bRet = [[DDGTaskStore sharedStore] saveTasks];
    
    if (bRet) {
        NSLog(@"Archived all tasks!");
    } else {
        NSLog(@"Archiving all tasks failure!");
    }
    
    bRet = [[DDGBookStore sharedStore] saveBooks];
    if (bRet) {
        NSLog(@"Archived all books!");
    } else {
        NSLog(@"Archiving books failure!");
    }
    
    // Upload all tasks which doesn't aside on person server
    // we can use it in other gcd thread so there are not blocks happen
    for (id item in [[DDGTaskStore sharedStore] allTasks]) {
        
        [[DDGNetworker sharedInstance] uploadTask:item];
    };
    
    //curl_global_cleanup();
}

@end
