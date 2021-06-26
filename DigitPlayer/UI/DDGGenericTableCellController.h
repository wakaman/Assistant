//
//  DDGenericTableCellViewController.h
//  DigitPlayer
//
//  Created by Jack on 2/9/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDGGenericTableCellController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UITableView *dataView;
}


@property (nonatomic, copy) void (^dismissBlockObjArg)(NSString *);
@property (nonatomic, copy) void (^dismissBlockObjAry)(NSArray *);

@property (nonatomic, strong) NSArray *sectionArray;
@property (nonatomic, assign) NSInteger sectionNum;

//@property (nonatomic, strong) NSArray *itemDat;
//@property (nonatomic, copy) NSString *naviBar;

@end
