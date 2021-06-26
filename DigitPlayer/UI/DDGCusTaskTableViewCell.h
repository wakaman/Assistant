//
//  DDGCusTaskTableViewCell.h
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 3/18/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDGCusTaskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UIImageView *slaveImgView;

@property (weak, nonatomic) IBOutlet UILabel *masterLabel;
@property (weak, nonatomic) IBOutlet UILabel *slaveLabel;
@property (weak, nonatomic) IBOutlet UILabel *thridLabel;
@property (weak, nonatomic) IBOutlet UILabel *forthLabel;

- (IBAction)btnClick:(id)sender;

@end
