//
//  DDGQRCoderScanViewController.h
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 4/19/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DDGTaskViewController.h"

@interface DDGQRCoderScanViewController : UIViewController
//@interface DDGQRCoderScanViewController : DDGTaskViewController

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *boxView;


@property (nonatomic, copy) void (^dismissBlock)(void);

// Action --
- (BOOL)startReading;

- (void)startScanning;
- (void)stopScanning;

@end
