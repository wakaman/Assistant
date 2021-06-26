//
//  DDGMallTaskDetailViewViewController.h
//  DigitPlayer
//
//  Created by Hackintosh-Developer on 20/7/2017.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DDGShopTask;


@interface DDGMallTaskDetailViewController : UIViewController
{
    __weak IBOutlet UITableView *mallTableView;
}

//
// @property (nonatomic, strong) NSMutableArray *itemArray;

@property (nonatomic, copy) void (^dismissBlock)(NSArray *goodList);
@property (nonatomic, strong) NSMutableArray *goodsArray;

//@property (nonatomic, strong) DDGShopTask *mallTask;

@end
