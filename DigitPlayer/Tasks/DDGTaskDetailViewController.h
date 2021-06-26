//
//  DDGTestTaskDetailViewController.h
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 2/24/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDGTask;

@interface DDGTaskDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *taskTableView;
    
    NSArray* actorDescrp;
    NSArray* titleDescrp;
    NSArray* dateDescrp;
    NSArray* taskDescrp;
    
    ///////////////////////////////
    
    NSString* beginDate;
    NSString* duration;
    NSString* alert;

    NSString* location;
    NSString* title;

    NSString* actor;
    NSString* note;
}

// Property
@property (nonatomic, strong) DDGTask *taskItem;

@end
