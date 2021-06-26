//
//  DDGBookTaskViewController.h
//  DigitPlayer
//
//  Created by SnowSquirrel on 7/5/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDGTaskViewController.h"


//@class DDGRBTask;
@class DDGTask;


//@interface DDGBookTaskViewController : UIViewController
@interface DDGBookTaskViewController : DDGTaskViewController
{
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UITableView *dataTableView;
}

//@property (nonatomic, copy) void (^dismissBlock)(void);
//@property (nonatomic, strong) DDGRBTask *rbookTask;


// Indeed we should instead it with custom initialize method
- (void)setReadTask:(DDGTask *)rBookTask;


@end
