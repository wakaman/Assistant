//
//  DDGMallTaskViewController.h
//  DigitPlayer
//
//  Created by SnowSquirrel on 7/5/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDGTaskViewController.h"


//@class DDGShopTask;
//@class DDGTask;

//@interface DDGMallTaskViewController : UIViewController
@interface DDGMallTaskViewController : DDGTaskViewController
{
    __weak IBOutlet UITableView *dataTableView;
}

//@property (nonatomic, copy) void (^dismissBlock)(void);
//@property (nonatomic, strong) DDGShopTask *shopTask;
//@property (nonatomic, strong) DDGTask *mallTask;


@end
