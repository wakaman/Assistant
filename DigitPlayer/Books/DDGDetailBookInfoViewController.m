//
//  DDGDetailBookInfoViewController.m
//  DigitPlayer
//
//  Created by SnowSquirrel on 6/26/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGDetailBookInfoViewController.h"
#import "DDGGenericLableController.h" 
#import "DDGTaskViewController.h"

#import "DDGTaskStore.h"
#import "DDGReadTask.h"
#import "DDGBook.h"


//#import "DDGReadBook.h"

@interface DDGDetailBookInfoViewController ()

- (void)setRBookViewItems:(DDGBook *)bookItem;

- (void)cancel:(id)sender;
- (void)add:(id)sender;

@end

@implementation DDGDetailBookInfoViewController


//@synthesize currentBook = _currentBook;
@synthesize currentBook;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   
    if (self) {
        
        // Custom initialization
        UINavigationItem* navItem = [self navigationItem];
        [navItem setTitle:NSLocalizedString(@"NewTask", @"Application title")];
        
        UIBarButtonItem* rightBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                     target:self
                                                                                     action:@selector(add:)];

        [[self navigationItem] setRightBarButtonItem:rightBarBtn];
    }
    
    return self;
}

/*
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // dismissBlock();
}
*/

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setRBookViewItems:currentBook];
    [self.navigationItem setTitle:currentBook.title];
    //[[self navigationItem] setTitle:currentBook.title];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark -- private message method
- (void)setRBookViewItems:(DDGBook *)bookItem
{
    if (bookItem == nil) {
        NSLog(@"You need some error messages!");
        return;
    }
    
    // Author -- //
    //[_authorLabel setText:[authorArray objectAtIndex:0]];
    NSArray *authorArray = [NSKeyedUnarchiver unarchiveObjectWithData:[bookItem author]];
    _authorLabel.text = authorArray.firstObject;
    
    // Summary -- //
    [_bookTextView setText:[bookItem summary]];
    
    // Title --  //
    [_titleLabel setText:[bookItem title]];
    
    // Image --  //
    [_bookImageView setImage:bookItem.largeImage];
}

- (void)cancel:(id)sender
{    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)add:(id)sender
{
    DDGTask *task = [[DDGTaskStore sharedStore] createTask:kDDGReadingTaskType];
    DDGReadTask *readTask = nil;

    if ([task isKindOfClass:[DDGReadTask class]]) {
        readTask = (DDGReadTask *)task;
    }
    
    if (readTask == nil) {
        return;
    }

    readTask.bkImage = currentBook.mediumImage;
    readTask.taskTitle = currentBook.title;
    readTask.currentBook = currentBook;
    
    DDGTaskViewController *readBookVC = [DDGTaskViewController createTaskViewController:kDDGTaskViewTypeRead];
    readBookVC.currentTask = readTask;
    
    NSArray *arrayVC = [[self navigationController] viewControllers];
    NSInteger index = [arrayVC count] - 2;
    UIViewController* navVC = [arrayVC objectAtIndex:index];
    
    [readBookVC setDismissBlock:^{  [self.navigationController popToViewController:navVC animated:YES]; }];
    [self.navigationController pushViewController:readBookVC animated:YES];
}
@end
