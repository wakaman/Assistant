//
//  DDGTestViewController.m
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 2/5/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGNewTaskViewController.h"
#import "DDGGenericTableCellController.h"
#import "DDGGenericLableController.h"
#import "DDGTaskDateTimeViewController.h"
#import "DDGDTimeCommon.h"
#import "DDGTaskStore.h"

//#import "DDGTask+CoreDataClass.h"
#import "DDGTask.h"

@interface DDGNewTaskViewController ()
{
    // NSInteger rowIndex;
}

- (void)cancel:(id)sender;
- (void)save:(id)sender;

@end

@implementation DDGNewTaskViewController

@synthesize dismissBlock;
@synthesize title;
@synthesize task;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    // NSBundle* appBundle = [NSBundle mainBundle];
    // self = [super initWithNibName:@"DDGNewTaskViewController" bundle:appBundle];
    
    if (self) {

        // Custom initialization
        UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                    target:self
                                                                                    action:@selector(cancel:)];
        
        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                     target:self
                                                                                     action:@selector(save:)];        
        
        [[self navigationItem] setRightBarButtonItem:rightBarBtn];
        [[self navigationItem] setLeftBarButtonItem:leftBarBtn];        
        [[self navigationItem] setTitle:@"New Task"];        

        typeArry = [NSMutableArray arrayWithObjects:@"Plan", @"Learning", @"Sport", @"Reading", @"Shopping", @"Gaming", @"Entertainment", @"Something", nil];
        addrArry = [NSMutableArray arrayWithObjects:@"Office", @"Home", @"Library", @"GameHouse", @"Hotel", @"Gym", @"anywhere", nil];
        titleArry = [NSMutableArray arrayWithObjects:@"Title", @"Actor", @"Type", @"Place", @"Duration", @"Priority", nil];        
       
        //NSArray* priObj = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", nil];
        //priorityDescrp = [NSMutableDictionary dictionaryWithObjects:priObj forKeys:priorityTitle];
        //colorPriority = [NSMutableArray arrayWithObjects:@"Red", @"Green", @"Yellow", nil];
        
        [[self view] setBackgroundColor:[UIColor whiteColor]];
    }
    
    return self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create an instance of UITableViewCell, with default appearance
    // Check for a reusable cell first, use that if it exists
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITaskViewCell"];
        
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITaskViewCell"];
    }
    
    // Task* taskItem = [[[DDGTaskStore sharedStore] allTasks] objectAtIndex:[indexPath row]];
    if ([indexPath section] == 0) {
        [self initCell:cell withTask:task  onRow:[indexPath row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController* uiviewcontroller;
    long index = [indexPath row];
    
    switch (index) {
            
        case 0:     // task's title
        {
            uiviewcontroller = [DDGGenericLableController new];             //[[DDGGenericLableViewController alloc] init];
            [(DDGGenericLableController *)uiviewcontroller setTitleLabel:titleArry[index]];
            [(DDGGenericLableController *)uiviewcontroller setTextLabel:task.taskTitle];
            [(DDGGenericLableController *)uiviewcontroller setBlockRetLabelText:^{
                NSLog(@"Hello world");
                return @"hello";
            }];
            
            [(DDGGenericLableController *)uiviewcontroller setDismissBlockAction:^(NSString *strTitle){
                //[task setTitle:strTitle];
                task.taskTitle = strTitle;
                [tableView reloadData];
            }];
            
            [(DDGGenericLableController *)uiviewcontroller setDismissBlockArg:^(NSString *strTitle){
                //[task setTitle:strTitle];
                task.taskTitle = strTitle;
                [tableView reloadData];
                return @"Here we are in the dismiss block!";
            }];
            
            [(DDGGenericLableController *)uiviewcontroller setDismissBlockArgs:^(NSString *str, int iPara){
                NSLog(@"This is %@, int is %i", str, iPara);
            }];            
        }
            break;
            
        case 1:     // task's actor
        {
            uiviewcontroller = [[DDGGenericLableController alloc] init];
            [(DDGGenericLableController *)uiviewcontroller setTitleLabel:titleArry[index]];
            [(DDGGenericLableController *)uiviewcontroller setTextLabel:@"Liu"];
            
            [(DDGGenericLableController *)uiviewcontroller setDismissBlockAction:^(NSString *strActor){
                //[task setCommander:strActor];
                [tableView reloadData];
            }];
        }
            break;
            
        case 2:     // task's Type
        {
            uiviewcontroller = [[DDGGenericTableCellController alloc] init];
            [(DDGGenericTableCellController *)uiviewcontroller setDismissBlockObjArg:^(NSString *type){
                //[task setTaskType:type];
                [tableView reloadData];
            }];
        }
            break;
            
        case 3:     // task's Place
        {
            uiviewcontroller = [[DDGGenericTableCellController alloc] init];
            [(DDGGenericTableCellController *)uiviewcontroller setDismissBlockObjArg:^(NSString *strAddr){
                //[task setPlace:strAddr];
                [tableView reloadData];
            }];
        }
            break;
            
        case 4: // task' Date
        {

            uiviewcontroller = [[DDGTaskDateTimeViewController alloc] init];
            [(DDGTaskDateTimeViewController *)uiviewcontroller setDismissBlockArgs:^(NSString *begin, NSString *end) {
                //[task setTaskCreatedDate:[NSDate date]];
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                //[task setTaskBeginDate:[formatter dateFromString:begin]];
                //[task setEndDate:[formatter dateFromString:end]];
                
                NSDate *beginDate = [formatter dateFromString:begin];
                //NSTimeZone* beginZone = [NSTimeZone systemTimeZone];
                //NSInteger beginInterval = [beginZone secondsFromGMTForDate:beginDate];
                //NSDate* beginLocal = [beginDate dateByAddingTimeInterval:beginInterval];
                
                NSDate *endDate = [formatter dateFromString:end];
                //NSTimeZone* endZone = [NSTimeZone systemTimeZone];
                //NSInteger endInterval = [endZone secondsFromGMTForDate:endDate];
                //NSDate* endLocal = [endDate dateByAddingTimeInterval:endInterval];

                //[task setTaskCreatedDate:beginDate];
                //[task setTaskBeginDate:beginDate];
                
                //[task setEndDateTime:endDate];
                //[task setDuration:[endLocal timeIntervalSinceReferenceDate] - [beginLocal timeIntervalSinceReferenceDate]];
                [tableView reloadData];

            }];
        }
            break;
            
        case 5:     // task's Priority
        {
            uiviewcontroller = [[DDGGenericTableCellController alloc] init];
            
            [(DDGGenericTableCellController *)uiviewcontroller setDismissBlockObjArg:^(NSString *priority){
                //[task setPriority:[[priorityDescrp objectForKey:priority] intValue]];
                [tableView reloadData];
            }];
        }
            break;
            
        default:
            return;
    }
    
    UIBarButtonItem *backBarBtnItem = [[UIBarButtonItem alloc] init];
    [[self navigationItem] setBackBarButtonItem:backBarBtnItem];
    [backBarBtnItem setTitle:@"Back"];
    
    // [[self navigationController] SetToolbarHidden:false];
    [[self navigationController] setToolbarHidden:true];
    [[self navigationController] pushViewController:uiviewcontroller animated:YES];
}

// - table

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
#if 0
    [cell setBackgroundColor:[UIColor redColor]];
#endif
}

#if 0
- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#endif

#if 0
- (void)setTaskItem:(DDGTestTask *)taskItem
{
    task = taskItem;
    [[self navigationController] setTitle:[task title]];
}
#endif

- (IBAction)updateSwitchFlag:(id)sender
{
    // UISwitch *switchView = (UISwitch*)sender;
    // NSLog(@"Here we are");
    // UITableViewCell* cell
    // [self tableView] cellfor
}

- (void)cancel:(id)sender;
{
    [[DDGTaskStore sharedStore] removeTask:task];
    dismissBlock();
    
    // [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
    // [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)save:(id)sender
{
    // UIAlertView* alertView;
    NSString *strMsg;
    bool bRet = false;
    
    if (task.taskTitle.length == 0 || task.taskTitle == nil) {
        strMsg = @"Title is nil";
        bRet = true;
    }

    //if (!bRet && ([task place] length] == 0 || [task place] == nil)) {
    //    strMsg = @"Place is nil";
    //    bRet = true;
    //}
    
    if (!bRet && task.taskBeginDate == nil) {
        strMsg = @"Date is nil";
        bRet = true;
    }
    
    if (!bRet && task.taskPriority.integerValue < 0) {
        strMsg = @"Priority is nil";
        bRet = true;
    }
    
    if (bRet)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Got Error!"
                                                            message:strMsg
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK",
                                                                    nil];
        [alertView show];
        return;
    }
    
    dismissBlock();
}

- (NSString *)integerToTypeString:(NSNumber *)value
{
    if (value == nil) {
        return nil;
    }
    
    if (typeArry == nil) {
        typeArry = [NSMutableArray arrayWithObjects:@"Plan", @"Learning", @"Sport", @"Reading", @"Shopping", @"Gaming", @"Entertainment", @"Something", nil];
    }
    
    if ([value intValue] > [typeArry count]) {
        return nil;
    }
    
    return [typeArry objectAtIndex:[value intValue]];
}

- (NSString *)integerToPriString:(NSNumber *)value
{
    if (value == nil) {
        return nil;
    }
    
    NSArray *priorityArry = [NSMutableArray arrayWithObjects:@"非常紧急", @"紧急", @"重要", @"一般", @"非常一般", @"可有可无", nil];
    if ([value intValue] > [priorityArry count]) {
        return nil;
    }
    
    return [priorityArry objectAtIndex:[value intValue]];
}

- (void)initCell:(UITableViewCell *)cell withTask:(DDGTask *)taskItem onRow:(NSInteger)index
{
    if (cell == nil || taskItem == nil) {
        return;
    }
    
    [[cell textLabel] setText:[titleArry objectAtIndex:index]];

    switch (index) {
                    
        case 0: // task's title
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [[cell detailTextLabel] setText:task.taskTitle];
            break;
                    
        case 1: // task's actor
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            //[[cell detailTextLabel] setText:[task commander]];
            break;
                    
        case 2: // task's Type
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [[cell detailTextLabel] setText:[self integerToTypeString:([task taskType])]];
            break;
                    
        case 3: // task's Place
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            //[[cell detailTextLabel] setText:[task place]];
            break;
                    
        case 4: // task's duration
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            //[[cell detailTextLabel] setText:[DDGDTimeCommon durationFromDate:task.taskCreatedDate toDate:[task endDateTime]]];
            //[[cell detailTextLabel] setText:@"10days"];
            break;
                    
        case 5: // task's Priority
                    
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [[cell detailTextLabel] setText:[self integerToPriString:(task.taskType/*[task type]*/)]];
            break;
            
        default:
            break;
    }
}

@end





















































