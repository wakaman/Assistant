//
//  DDGTaskViewController.m
//  DigitPlayer
//
//  Created by Hackintosh-Developer on 1/8/2017.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGTaskViewController.h"

#import "DDGMallTaskViewController.h"
#import "DDGBookTaskViewController.h"
#import "DDGProjectViewController.h"
#import "DDGNewTaskViewController.h"


@interface DDGTaskViewController ()

@end

@implementation DDGTaskViewController

@synthesize dismissBlock = _dismissBlock;
@synthesize currentTask = _currentTask;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//+ (DDGTaskViewController *)createTaskViewController:(NSUInteger)type
+ (DDGTaskViewController *)createTaskViewController:(DDGTaskViewType)type
{
    //
    switch (type) {
            
        case kDDGTaskViewTypeAppoint:
            break;
            
        case kDDGTaskViewtypeEvent:
            //return [DDGNewTaskViewController new];
            break;
            
        case kDDGTaskViewTypeShop:
            return [DDGMallTaskViewController new];
            break;
            
        case kDDGTaskViewTypeRead:
            return [DDGBookTaskViewController new];
            //return [DDGQRCoderScanViewController new];
            break;
            
            
        case kDDGTaskViewTypePlan:
            break;
            
        case kDDGTaskViewtypeTravel:
            break;
            
        case kDDGTaskViewTypeProject:
            return [DDGProjectViewController new];
            break;
            
        case kDDGTaskViewTypeUnknow:
            break;
    }
    
    return nil;
}

@end
