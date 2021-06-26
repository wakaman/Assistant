//
//  DDGTaskDateTimeViewController.h
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 3/7/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDGTaskDateTimeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UITableView *dateView;
    
    NSArray *titleArray;
}

//@property (nonatomic, strong)NSMutableArray *valueArray;
@property (nonatomic, copy) void (^dismissBlockArgs)(NSString* dateStart, NSString* dateEnd);

- (void)dateChange:(id)sender;

@end
