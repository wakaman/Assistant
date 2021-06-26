//
//  DDGViewCtrlStore.h
//  DigitPlayer
//
//  Created by Hackintosh-Developer on 1/8/2017.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_OPTIONS(NSUInteger, DDGViewCtrlType)
typedef NS_ENUM(NSUInteger, DDGViewCtrlType)
{
    DDGTaskView,
    DDGTaskDetailView,
    DDGBookView,
    DDGBookDetailView,
    DDGProjectView,
    DDGProjectDetailView,
    DDGPlanView,
    DDGDPlanDetailView
};


@interface DDGViewCtrlStore : NSObject
{
}

+ (DDGViewCtrlStore *)sharedStore;

// interface
- (UIViewController *)createViewCtrl:(NSUInteger)type;
@end
