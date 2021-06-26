//
//  DDGSndGenericLabelViewController.m
//  DigitPlayer
//
//  Created by Jack on 2/9/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGGenericLableController.h"

@interface DDGGenericLableController ()

@end

@implementation DDGGenericLableController

@synthesize dismissBlockAction;
@synthesize blockRetLabelText;
@synthesize dismissBlockArgs;
@synthesize dismissBlockArg;
@synthesize dismissBlock;
@synthesize titleLabel;
@synthesize textLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        //[[[self navigationItem] leftBarButtonItem] setTitle:@"Left"]; 
        // Custom initialization
        // [[self navigationController] setTitle:navTitle];
        // [[self navigationItem] setTitle:labelTitle];
        // [labelVal setText:labelText];               
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[self navigationItem] setTitle:titleLabel];
    [textField setClearsOnBeginEditing:FALSE];
    
    //[textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textField setClearButtonMode:UITextFieldViewModeAlways];
    
    [textField setText:textLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (dismissBlockAction) {
        dismissBlockAction([textField text]);
    }
    
#if 0
    NSString* log = dismissBlockArg([labelVal text]);
    NSLog(@"Log in Snd %@", log);
#endif
    
    //[[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textFieldVal
{
    [[self view] endEditing:YES];
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textFieldVal
{
    [self setTextLabel:[textFieldVal text]];    
    [textFieldVal resignFirstResponder];
    return true;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textField resignFirstResponder];
}
@end
