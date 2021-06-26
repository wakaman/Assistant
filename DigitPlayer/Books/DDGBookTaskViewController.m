//
//  DDGBookTaskViewController.m
//  DigitPlayer
//
//  Created by SnowSquirrel on 7/5/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGBookTaskViewController.h"
#import "DDGGenericTableCellController.h"
#import "DDGTaskDateTimeViewController.h"


#import "DDGTaskStore.h"
#import "DDGReadTask.h"
#import "DDGBook.h"


typedef void (^blk_t)(NSString *);


typedef NS_ENUM(NSUInteger, BKTaskItem)
{
    BKTaskItemBook,
    BKTaskItemAuthor,
    BKTaskItemSource,
    BKTaskItemDate,
    BKTaskItemDuration,
    BKTaskItemReborrow
};

@interface DDGBookTaskViewController () <UITableViewDelegate, UITableViewDataSource>


- (void)showGenericCellViewController:(NSArray *)itemArray forItem:(NSString *)strItem withBlock:(blk_t)block;
// - (void)showGenericCellViewController:(NSArray *)itemArray withTitle:(NSString *)strTitle;

- (bool)checkBookTask:(DDGReadTask *)taskItem;
- (void)switchAction:(id)sender;

- (void)cancel:(id)sender;
- (void)save:(id)sender;
@end

@implementation DDGBookTaskViewController
{
    NSMutableArray *itemAry;
    bool bRebo;
    
    DDGReadTask *rbookTask;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                    target:self
                                                                                    action:@selector(cancel:)];
        
        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                     target:self
                                                                                     action:@selector(save:)];
        
        [[self navigationItem] setRightBarButtonItem:rightBarBtn];
        [[self navigationItem] setLeftBarButtonItem:leftBarBtn];
        
        itemAry = [NSMutableArray arrayWithObjects:@"Book", @"Author", @"Source", @"BeginDate", @"Duration", @"Reborrow", nil];
        bRebo = 0;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ////----------------------------------------------
#if 0
    if (strDate == nil) {
    
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        strDate = [formatter stringFromDate:[NSDate date]];
    }
#endif
    
    if (self.currentTask.taskType.intValue == kDDGReadingTaskType) {
        rbookTask = (DDGReadTask *)self.currentTask;
    }
 
    imageView.image = rbookTask.currentBook.mediumImage; 
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    if (rbookTask.taskCreatedDate == nil) {
        rbookTask.taskCreatedDate = [NSDate date];
        rbookTask.taskBeginDate = [NSDate date];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.00;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UIBookTaskViewCell"];
    // = [tableView dequeueReusableCellWithIdentifier:@"UIBookTaskViewCell"];
    
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UIBookTaskViewCell"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UIBookTaskViewCell"];
    }
    
    [cell.textLabel setText:[itemAry objectAtIndex:[indexPath row]]];
    // [cell.textLabel setText:[itemAry objectAtIndex:[indexPath row]]];

    switch ([indexPath row]) {
            
        case BKTaskItemReborrow:
            {
                UISwitch *switchView = [UISwitch new];
                cell.accessoryView = switchView;
                [switchView setOn:NO];
                [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                
                // -- CheckMark, --
                // cell.accessoryType = UITableViewCellAccessoryCheckmark; -- // cell.selected
            }
            
            break;
            
        case BKTaskItemDuration:
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            //cell.detailTextLabel.text = rbookTask.duration;
            break;
            
        case BKTaskItemSource:

            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            //cell.detailTextLabel.text = rbookTask.bookLibrary;
            //rbookTask.bookLibrary
            break;
            
        case BKTaskItemDate:
        {
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            cell.detailTextLabel.text = [formatter stringFromDate:rbookTask.taskBeginDate];
        }
        break;

        case BKTaskItemAuthor:
            
            //cell.textLabel.text = rbookTask.bookAuthor;
            break;
            
        case BKTaskItemBook:
            cell.textLabel.text = rbookTask.taskTitle;
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case BKTaskItemDuration:
        {
            int arry[10] = { 28, 21, 14, 7, 6, 5, 4, 3, 2 ,1 };
            id objects[10] = { nil };
            id keys[10] = { @"4 weeks", @"3 weeks", @"2 weeks", @"1 week", @"6 days",
                            @"5 days", @"4 days", @"3 days", @"2 days", @"1 day"};
            
            //NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            //NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarId];
            
            NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
            NSDate *today = [NSDate date];
            
            for (int i = 0; i < sizeof(arry) / sizeof(int); ++i)
            {
                [offsetComponents setDay:arry[i]];
                //objects[i] = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
            }
            
            NSArray *keyArry = @[@"4 weeks", @"3 weeks", @"2 weeks", @"1 week",
                                 @"6 days", @"5 days", @"4 days", @"3 days", @"2 days", @"1 day"];
            NSArray *sectionArry = [NSArray arrayWithObjects:keyArry, nil];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys count:10];
            
            [self showGenericCellViewController:sectionArry forItem:@"Duration" withBlock:^(NSString *strText){
                rbookTask.duration = dictionary[strText];
                [dataTableView reloadData];
            }];
        }
        break;
        case BKTaskItemDate:
        {

            DDGTaskDateTimeViewController *dateVC = [DDGTaskDateTimeViewController new];
            UIBarButtonItem *backBarBtn = [UIBarButtonItem new];
            
            [[self navigationItem] setBackBarButtonItem:backBarBtn];
            [backBarBtn setTitle:@"Back"];
            
            [dateVC setDismissBlockArgs:^(NSString *begin, NSString *end) {
                
                NSDateFormatter *formatter = [NSDateFormatter new];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                rbookTask.taskBeginDate = [formatter dateFromString:begin];
                [dataTableView reloadData];
            }];
            
            if ([self navigationController] == nil) {
                
                UINavigationController *navigation = [UINavigationController new];
                [navigation pushViewController:dateVC animated:YES];                
            }else {
                
                [[self navigationController] pushViewController:dateVC animated:YES];
            }
        }
        break;
        case BKTaskItemSource:
        {
            NSArray *library = @[@"ShenZhen City Library", @"ShenZhen City Science Library", @"ShenZhen City Nan Shan District Library"];
            NSArray *sectionArray = [NSArray arrayWithObjects:library, nil];
            [self showGenericCellViewController:sectionArray forItem:@"Library" withBlock:^(NSString *strText){
                rbookTask.bkLibrary = strText;
                [dataTableView reloadData];
            }];
        }
        break;
        case BKTaskItemReborrow:
        {
            NSLog(@"Here we are!");
        }
        break;
    }
}

- (void)setReadTask:(DDGTask *)rBookTask
{
    //if (rBookTask.taskType.integerValue == kDDGReadingTaskType
    if ([rBookTask isKindOfClass:[DDGReadTask class]]) {
        rbookTask = (DDGReadTask *)rBookTask;
    }
}

#pragma mark -- setter
- (void)setTask:(DDGTask *)task
{
    if (nil == task || ![task isKindOfClass:[DDGReadTask class]]) {
        return;
    }
    
    rbookTask = (DDGReadTask *)task;
    self.currentTask = task;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showGenericCellViewController:(NSArray *)itemArray forItem:(NSString *)strItem withBlock:(blk_t)block
{
    DDGGenericTableCellController *sourceVC = [DDGGenericTableCellController new];
    UIBarButtonItem *backBarBtn = [UIBarButtonItem new];
    [backBarBtn setTitle:@"Back"];
    
    [[self navigationItem] setBackBarButtonItem:backBarBtn];
    [sourceVC setDismissBlockObjArg:block];
    sourceVC.sectionArray = itemArray;
    sourceVC.title = strItem;
    
    if ([self navigationController] == nil) {
        
        UINavigationController *navigation = [UINavigationController new];
        [navigation pushViewController:sourceVC animated:YES];
        
    }else {
        
        [[self navigationController] pushViewController:sourceVC animated:YES];
    }
}

- (void)switchAction:(id)sender
{
    UISwitch *switchBtn = (UISwitch *)sender;
    if (switchBtn.isOn) {
        bRebo = true;
    } else {
        bRebo = false;
    }
    
    rbookTask.reBorrow = [NSNumber numberWithBool:bRebo];
}

//- (bool)checkTask:(DDGTask *)task
- (bool)checkBookTask:(DDGReadTask *)readTask withMsg:(NSString **)strMsg
{
    bool bAlert = false;
    
    if (readTask.taskBeginDate == nil) {
        *strMsg = @"BeginData is nil!";
        return bAlert;
    }

    if (nil == readTask.duration) {
        *strMsg = @"Duration is nil!";
        return bAlert;
    }
    
    if (readTask.bkLibrary == nil || readTask.bkLibrary.length == 0) {
        *strMsg = @"Library is empty!";
        return bAlert;
    }
    
    if (readTask.taskTitle == nil || readTask.taskTitle.length == 0) {
        *strMsg = @"No book has been selected!";
        return bAlert;
    }
    
    if (readTask.bkImage == nil) {
        *strMsg = @"Book image empty!";
        return bAlert;
    }
    
    return !bAlert;
}

- (void)cancel:(id)sender
{
    if (rbookTask) {
        [[DDGTaskStore sharedStore] removeTask:rbookTask];
    }
    
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (void)save:(id)sender
{
    NSString *strMessage = nil;
    if ([self checkBookTask:rbookTask withMsg:&strMessage] && self.dismissBlock) {
        self.dismissBlock();
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save error!"
                                                            message:strMessage
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}
@end
