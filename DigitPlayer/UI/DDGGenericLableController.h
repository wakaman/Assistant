//
//  DDGSndGenericLabelViewController.h
//  DigitPlayer
//
//  Created by Jack on 2/9/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDGGenericLableController : UIViewController <UINavigationControllerDelegate, UITextFieldDelegate>
{
    __weak IBOutlet UITextField *textField;
    //__weak IBOutlet UITextField *textField;
}

// @property (nonatomic, copy) NSString* labelText;
// @property (nonatomic, weak) NSString* labelText;

@property (nonatomic, copy) NSString* titleLabel;
@property (nonatomic, copy) NSString* textLabel;

@property (nonatomic, copy) void (^dismissBlockArgs)(NSString* str, int parameter);
@property (nonatomic, copy) void (^dismissBlockAction)(NSString*);
@property (nonatomic, copy) void (^dismissBlock)(void);

@property (nonatomic, copy) NSString* (^dismissBlockArg)(NSString*);
@property (nonatomic, copy) NSString* (^blockRetLabelText)(void);
@end
