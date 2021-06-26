//
//  DDGNetworker.h
//  DigitPlayer
//
//  Created by Hackintosh-Developer on 10/8/2017.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DDGTask;
@class DDGUser;

@interface DDGNetworker : NSObject

+ (DDGNetworker *)sharedInstance;

- (void)downloadTasks:(DDGUser *)userInfo;
- (BOOL)uploadTask:(DDGTask *)taskItem;

//- (BOOL)uploadT

@end
