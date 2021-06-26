//
//  DDGTestViewController.h
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 2/5/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DDGTask;

@interface DDGNewTaskViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableDictionary *priorityDescrp;
    NSMutableArray *titleArry;
    
    NSArray *addrArry;
    NSArray *typeArry;
}

@property (nonatomic, copy) void (^dismissBlock)(void);
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) DDGTask *task;

//- (void)initCell:(UITableViewCell*)cell withArray:(NSArray*)itemArry onRow:(NSInteger)index;
- (void)initCell:(UITableViewCell *)cell withTask:(DDGTask *)taskItem onRow:(NSInteger)index;

@end
