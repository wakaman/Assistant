//
//  DDGProjectViewController.h
//  DigitPlayer
//
//  Created by Hackintosh-Developer on 1/8/2017.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDGTaskViewController.h"


@class DDGProjectTask;


@interface DDGProjectViewController : DDGTaskViewController
{
    __weak IBOutlet UITextView *descripText;
    __weak IBOutlet UITextField *titleText;
    __weak IBOutlet UITableView *showItems;
}

//@property (nonatomic, copy) void (^dismissBlock)(void);
//@property (nonatomic, strong) DDGRBTask *rbookTask;
//@property (nonatomic, strong) DDGProjectTask *projectTask;

@end
