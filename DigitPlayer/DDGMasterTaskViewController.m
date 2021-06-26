//
//  DDGMasterTaskViewController.m
//  DigitPlayer
//
//  Created by Mavericks-Hackintosh on 1/17/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGMasterTaskViewController.h"
#import "DDGCusTaskTableViewCell.h"

#import "DDGQRCoderScanViewController.h"
#import "DDGTaskViewController.h"
#import "DDGViewCtrlStore.h"

#import "DDGDTimeCommon.h"
#import "./Source/KxMenu.h"


#import "DDGProjectViewController.h"
#import "DDGTaskStore.h"

#import "DDGProjectTask.h"
#import "DDGReadTask.h"
#import "DDGTask.h"


@interface DDGMasterTaskViewController ()

//- (DDGCusTaskTableViewCell *)makeTaskCell
- (void)customCell:(DDGCusTaskTableViewCell *)cell withTask:(DDGTask *)task;
- (void)setCell:(DDGCusTaskTableViewCell *)cell withTask:(DDGTask *)task;
- (void)showMenu:(UIBarButtonItem *)sender;

- (void)addShoppingTask:(id)sender;
- (void)addProjectTask:(id)sender;
- (void)addEventTask:(id)sender;
- (void)addReadTask:(id)sender;
- (void)addPlanTask:(id)sender;
@end

@implementation DDGMasterTaskViewController

//@synthesize tableView = _tableView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {

        // Custom initialization
        UIBarButtonItem* rightBarBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                         target:self
                                                                                         action:@selector(showMenu:)];
                                                                                         //action:@selector(addNewTask:)];
        [[self navigationItem] setRightBarButtonItem:rightBarBtnItem];        
        [self.tableView setFrame:self.view.frame];
        
        self.view.contentMode = UIViewContentModeScaleToFill;
        self.tableView.contentMode = UIViewContentModeScaleToFill;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UINib *cusCellLib = [UINib nibWithNibName:@"DDGCusTaskTableViewCell" bundle:nil];
    [[self tableView] registerNib:cusCellLib forCellReuseIdentifier:@"DDGCusTaskTableViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //  #warning Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = [[[DDGTaskStore sharedStore] allTasks] count];
            break;
    }
    
    NSLog(@"The row count is: %ld", count);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DDGTask *task = [[[DDGTaskStore sharedStore] allTasks] objectAtIndex:[indexPath row]];
    //UITableViewCell* cell = nil;
    
    switch (indexPath.section) {
        case 0:
            switch ([task.taskType unsignedIntegerValue])
            {
                case kDDGReadingTaskType:
                {
                    DDGCusTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDGCusTaskTableViewCell" forIndexPath:indexPath];
                    //cell = [tableView dequeueReusableCellWithIdentifier:@"DDGCusTaskTableViewCell" forIndexPath:indexPath];

                    DDGReadTask* readTask = (DDGReadTask *)task;
                
                    // Configure the cell...
                    if (!cell) {
                        cell = [[DDGCusTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DDGCusTaskTableViewCell"];
                    }
                
                    [[cell masterLabel] setFont:[UIFont systemFontOfSize:15]];
                    [[cell slaveLabel] setFont:[UIFont systemFontOfSize:13]];
                    [[cell thridLabel] setFont:[UIFont systemFontOfSize:12]];
                    [[cell forthLabel] setFont:[UIFont systemFontOfSize:12]];
                    
                    [cell.masterLabel setText:task.taskTitle];
                
                    NSDateFormatter *formatter = [NSDateFormatter new];
                    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                    [cell.thridLabel setText:[formatter stringFromDate:task.taskBeginDate]];
                    cell.imageView.image = readTask.bkImage;
                    
                    //[cell.forthLabel setText:[formatter stringFromDate:(DDGReadTask *)task.duration]];
                    return cell;
                }
                break;
                
                case kDDGShoppingTaskType:
                {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDGGenericTaskTableViewCell"];
                
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DDGGenericTaskTableViewCell"];
                    }
                
                    NSDateFormatter *formatter = [NSDateFormatter new];
                    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                    [cell.detailTextLabel setText:[formatter stringFromDate:task.taskBeginDate]];
                    [cell.textLabel setText:task.taskTitle];
                    return cell;
                }
                break;
                
                case kDDGTravelTaskType:
                    break;
                
                case kDDGProjectTaskType:
                {
                    //DDGCusTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDGCusTaskTableViewCell" forIndexPath:indexPath];
                    DDGCusTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDGCusTaskTableViewCell" forIndexPath:indexPath];
                
                    // Configure the cell...
                    if (!cell) {
                        cell = [[DDGCusTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DDGCusTaskTableViewCell"];
                    }
                
                    [self setCell:cell withTask:[[[DDGTaskStore sharedStore] allTasks] objectAtIndex:indexPath.row]];
                    return cell;
                }
                break;
            }
            break;  // inner switch
        } // external switch
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *items = [[DDGTaskStore sharedStore] allTasks];
    DDGTask *task = [items objectAtIndex:[indexPath row]];
    UIViewController *taskVC;
    
    switch ([task.taskType unsignedIntegerValue])
    {
        case kDDGReadingTaskType:
        {
            NSLog(@"Read type task!");
        }
        break;
            
        case kDDGTravelTaskType:
        {
            NSLog(@"Travel type task");
        }
        break;
            
        case kDDGShoppingTaskType:
        {
            
#if 0
            DDGShopTask *mallTask = (DDGShopTask *)task;
            DDGMallTaskDetailViewController *mallTaskVC = [DDGMallTaskDetailViewController new];
            mallTaskVC.dismissBlock = ^(NSArray *newGoodsList) {
                mallTask.goodList = [NSKeyedArchiver archivedDataWithRootObject:newGoodsList];
            };
            
            NSMutableArray *goodsList = [NSKeyedUnarchiver unarchiveObjectWithData:mallTask.goodList];
            if ([goodsList count] == 0) {
                return;
            }
            
            mallTaskVC.goodsArray = goodsList;
            taskVC = mallTaskVC;
#endif
        }
        break;
            
        default:
            break;
    }
    
    [[self navigationController] pushViewController:taskVC animated:YES];
}

#if 0
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Delete
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                               title:@"Delete"
                                                                             handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                                 
                                                                                 // Delete the row from the data source
                                                                                [[DDGTaskStore sharedStore] removeTask:[[[DDGTaskStore sharedStore] allTasks] objectAtIndex:[indexPath row]]];
                                                                                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                                             }];
    //设置收藏按钮
    UITableViewRowAction *favoriteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                                title:@"Done"
                                                                               handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                            
                                                                                   // favoriteRowAction.backgroundColor = [UIColor greenColor];
                                                                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Done"
                                                                                                                                       message:@"收藏成功"
                                                                                                                                      delegate:self
                                                                                                                             cancelButtonTitle:@"确定"
                                                                                                                             otherButtonTitles:nil,nil];
        
                                                                                   [alertView show];
                                                                               }];
    
#if 0
    //设置置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"置顶"
                                                                          handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
                                                                              //
                                                                              // [self.dataSourceexchangeObjectAtIndex:indexPath.rowwithObjectAtIndex:0];
                                                                              // NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                                                                              // [tableView moveRowAtIndexPath:indexPathtoIndexPath:firstIndexPath];
                                                                              NSLog(@"Here we are!");
                                                                          }];
#endif
    
    
    favoriteRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    favoriteRowAction.backgroundColor = [UIColor grayColor];
    
    return  @[deleteRowAction, favoriteRowAction];
}
#endif

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        [[DDGTaskStore sharedStore] removeTask:[[[DDGTaskStore sharedStore] allTasks] objectAtIndex:[indexPath row]]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }// else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    //[[DDGTstTaskStore shareStore] moveTaskAtIndex:[fromIndexPath row] toIndex:[toIndexPath row]];
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Custom function
//- (IBAction)addNewTask:(id)sender
//{
//}

#pragma mark -- private message method p_addNewTask#

#pragma mark -- private message
- (void)customCell:(DDGCusTaskTableViewCell *)cell withTask:(DDGTask *)task
{
    //
    NSLog(@"Here we are!");
}

- (void)setCell:(DDGCusTaskTableViewCell *)cell withTask:(DDGTask *)task
{
    
    switch ([task.taskType unsignedIntegerValue])
    {
        case kDDGReadingTaskType:
        {
            [cell.masterLabel setText:task.taskTitle];
            
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            //[formatter stringFromDate:task.taskBeginDate];
            //strText = [formatter stringFromDate:task.beginDate];
            
            DDGReadTask* readTask = (DDGReadTask *)task;
            [cell.thridLabel setText:[formatter stringFromDate:task.taskBeginDate]];
            [cell.forthLabel setText:[formatter stringFromDate:readTask.duration]];
            
            //cell.imageView.image = readTask.
            //[cell.forthLabel setText:task.duration];
        }
        break;

        case kDDGShoppingTaskType:
        {
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            [cell.thridLabel setText:[formatter stringFromDate:task.taskBeginDate]];
            //[cell.forthLabel setText:task.duration];
            [cell.masterLabel setText:task.taskTitle];
        }
        break;
            
        case kDDGTravelTaskType:
            break;
            
        case kDDGProjectTaskType:
        {
            DDGProjectTask* proTask = (DDGProjectTask *)task;
            cell.masterLabel.text = proTask.taskTitle;
            cell.slaveLabel.text = [[NSString alloc] initWithFormat:@"Bugs %lu", [[proTask allBugs] count]];
            cell.thridLabel.text = [[NSString alloc] initWithFormat:@"Funs %lu", [[proTask allFuns] count]];
        }            
        break;
    }
}

- (void)showMenu:(UIBarButtonItem *)sender
{
    
    NSAssert([sender isKindOfClass:[UIBarButtonItem class]], @"sender is not a uibarbuttonItem");
    
    NSArray *menuItems = @[
      
      [KxMenuItem menuItem:@"Task"
                     image:nil
                    target:self
                    action:@selector(addEventTask:)],
      
      [KxMenuItem menuItem:@"Shop"
                     image:nil
                    target:self
                    action:@selector(addShoppingTask:)],
      
      [KxMenuItem menuItem:@"Book"
                     image:nil
                    target:self
                    action:@selector(addReadTask:)],
      
      [KxMenuItem menuItem:@"Pros"
                     image:nil
                    target:self
                    action:@selector(addProjectTask:)],
      
      [KxMenuItem menuItem:@"Plan"
                     image:nil
                    target:self
                    action:@selector(addPlanTask:)]
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    // NSLog(@"frame = %@", NSStringFromCGRect(sender.accessibilityFrame));
    //CGRect frame = CGRectMake(300, 20, 5, 5);     -- Bad code
    
    CGRect frame = CGRectMake(293, 45, 5, 5);    
    [KxMenu showMenuInView:self.navigationController.view
                  fromRect:frame
                 menuItems:menuItems];
}

#pragma mark -- these 3 functions can use factory method to implementation it
- (void)addEventTask:(id)sender
{
    NSLog(@"Here we add event task!");
    
    //DDGNewTaskViewController* viewController = [DDGNewTaskViewController new];
    [self.navigationController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    //[self.navigationController pushViewController:viewController animated:YES];
}

- (void)addShoppingTask:(id)sender
{
    DDGTaskViewController *shoppingVC = [DDGTaskViewController createTaskViewController:kDDGTaskViewTypeShop];
    
    [shoppingVC setDismissBlock:^{
        
        [self.navigationController popToViewController:self animated:YES];
        [[self tableView] reloadData];
    }];
    
    DDGTask *newTask = [[DDGTaskStore sharedStore] createTask:kDDGShoppingTaskType];
    newTask.taskType = [NSNumber numberWithInteger:kDDGShoppingTaskType];
    newTask.taskBeginDate = [NSDate date];
    
    shoppingVC.currentTask = newTask;
    
    [self.navigationController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];    
    [self.navigationController pushViewController:shoppingVC animated:YES];
}

- (void)addReadTask:(id)sender
{
    
#if 0
    DDGTaskViewController *readBookVC = [DDGTaskViewController createTaskViewController:DDGTaskViewTypeRead];
    
    [readBookVC setDismissBlock:^{
        [self.navigationController popToViewController:self animated:YES];
        [[self tableView] reloadData];
    }];
    
    DDGTask *newTask = [[DDGTaskStore sharedStore] createTask:DDGTaskTypeRead];
    newTask.type = [NSNumber numberWithInteger:DDGTaskTypeRead];
    newTask.beginDateTime = [NSDate date];
    readBookVC.task = newTask;
    
    [self.navigationController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self.navigationController pushViewController:readBookVC animated:YES];
    
#else
    
    DDGQRCoderScanViewController* bookScanVC = [DDGQRCoderScanViewController new];
    bookScanVC.dismissBlock = ^{ [[self tableView] reloadData]; };
    
    // In order to solve back's background color
    //bookScanVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    bookScanVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    bookScanVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [[self navigationController] pushViewController:bookScanVC animated:YES];
    
#endif
}

- (void)addProjectTask:(id)sender
{
    
    DDGTaskViewController *projectVC = [DDGTaskViewController createTaskViewController:kDDGTaskViewTypeProject];
    [projectVC setDismissBlock:^{
        [self.navigationController popToViewController:self animated:YES];
        [[self tableView] reloadData];
    }];
    
    DDGTask *newTask = [[DDGTaskStore sharedStore] createTask:kDDGProjectTaskType];
    //newTask.taskType = [NSNumber numberWithInteger:DDGProjectTaskType];
    newTask.taskBeginDate = [NSDate date];
    
#if 0
    projectVC.projectTask = newTask;
    projectVC.currentTask = newTask;
#endif
    
    DDGProjectViewController* currentProjectViewController = (DDGProjectViewController *)projectVC;
    //currentProjectViewController.projectTask = newTask;
    currentProjectViewController.currentTask = newTask;
    
    [self.navigationController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self.navigationController pushViewController:projectVC animated:YES];
}

- (void)addPlanTask:(id)sender
{
 
#if 0
    DDGTaskViewController *projectVC = [DDGTaskViewController createTaskViewController:DDGTaskViewTypeProject];
    
    [projectVC setDismissBlock:^{
        
        [self.navigationController popToViewController:self animated:YES];
        [[self tableView] reloadData];
    }];
    
    DDGTask *newTask = [[DDGTaskStore sharedStore] createTask:DDGTaskTypePros];
    newTask.type = [NSNumber numberWithInteger:DDGTaskTypePros];
    newTask.beginDateTime = [NSDate date];
    
    projectVC.task = newTask;
    
    [self.navigationController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    
    [self.navigationController pushViewController:projectVC animated:YES];
    
    
    //////////////////////////////////////////
    DDGMallTaskViewController *mallTaskVC = [DDGMallTaskViewController new];
    [mallTaskVC setDismissBlock:^{
        
        [self.navigationController popToViewController:self animated:YES];
        [[self tableView] reloadData];
    }];
    
    DDGTask *newTask = [[DDGTaskStore sharedStore] createTask:DDGTaskShop];
    newTask.beginDateTime = [NSDate date];
    newTask.type = DDGTaskShop;
    [mallTaskVC setShopTask:(DDGShopTask *)newTask];
    
    [self.navigationController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    
    [self.navigationController pushViewController:mallTaskVC animated:YES];
#endif
}
@end






































































































































































