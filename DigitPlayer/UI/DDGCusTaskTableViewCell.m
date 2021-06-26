//
//  DDGCusTaskTableViewCell.m
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 3/18/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGCusTaskTableViewCell.h"

@implementation DDGCusTaskTableViewCell

@synthesize thumbnailView;
@synthesize slaveImgView;
@synthesize masterLabel;
@synthesize slaveLabel;
@synthesize thridLabel;
@synthesize forthLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code
        
        [[self contentView] setBackgroundColor:[UIColor greenColor]];
        
        // cell.textLabel.font=[UIFont systemFontOfSize:15];
        // UIFont *newFont = [UIFont fontWithName:@"Arial" size:13.0];
        // 创建完字体格式之后就告诉cell
        // cell.textLabel.font = newFont;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnClick:(id)sender {
    NSLog(@"here we are!");
}
@end
