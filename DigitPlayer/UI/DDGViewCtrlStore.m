//
//  DDGViewCtrlStore.m
//  DigitPlayer
//
//  Created by Hackintosh-Developer on 1/8/2017.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGViewCtrlStore.h"

#import "DDGProjectViewController.h"

@implementation DDGViewCtrlStore
{

}

+ (DDGViewCtrlStore *)sharedStore
{
    static DDGViewCtrlStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

- (UIViewController *)createViewCtrl:(NSUInteger)type
{
    UIViewController *viewctrl = nil;
    
    switch (type) {
        case DDGTaskView:
        {
            
        }
            
        break;
            
        case DDGTaskDetailView:
        {
        
        }
        break;
            
        case DDGBookView:
        {}
        break;
            
        case DDGBookDetailView:
        {}
        break;
            
        case DDGProjectView:
        {
            DDGProjectViewController *projectView = [DDGProjectViewController new];
            viewctrl = projectView;
        }
        break;
            
        case DDGProjectDetailView:
        {}
        break;
            
        case DDGPlanView:
        {}
        break;
            
        case DDGDPlanDetailView:
        {}
        break;
    }
    
    return viewctrl;
}
@end
