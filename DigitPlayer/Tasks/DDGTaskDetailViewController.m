//
//  DDGTestTaskDetailViewController.m
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 2/24/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGTaskDetailViewController.h"
#import "DDGDTimeCommon.h"

//#import "DDGTask+CoreDataClass.h"
#import "DDGTask.h"


@interface DDGTaskDetailViewController ()
{
    NSString *taskInfo;
    NSString *taskDate;
}
@end

@implementation DDGTaskDetailViewController

@synthesize taskItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = taskItem.taskTitle;
    //[[self navigationItem] setTitle:[taskItem title]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell;
    NSInteger index = [indexPath row];
    
    switch (index) {
        case 0: // Task's title
            cell = [tableView dequeueReusableCellWithIdentifier:@"DDGTaskDetailViewControllerSubtitle"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DDGTaskDetailViewControllerSubtitle"];
            }
            
            [[cell detailTextLabel] setText:location];
            [[cell textLabel] setText:title];
            break;
            
        case 1: // Task's date
            cell = [tableView dequeueReusableCellWithIdentifier:@"DDGTaskDetailViewControllerSubtitle"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DDGTaskDetailViewControllerSubtitle"];
            }
            
            //NSString* strMsg = [DDGDTimeCommon compareDate:[task beginDate] withDate:[NSDate date]];
            //[[cell thridLabel] setText:strMsg];
            
            //[[cell detailTextLabel] setText:[DDGDTimeCommon durationFromDate:taskItem.taskBeginDate toDate:[taskItem endDateTime]]];
            [[cell textLabel] setText:beginDate];
            break;
            
        case 3: // Task's actor
            cell = [tableView dequeueReusableCellWithIdentifier:@"DDGTaskDetailViewControllerSubtitle"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DDGTaskDetailViewControllerSubtitle"];
            }
            
            [[cell detailTextLabel] setText:actor];
            [[cell textLabel] setText:@"Actor"];
            break;
            
#if 0
            cell = [tableView dequeueReusableCellWithIdentifier:@"DDGTaskDetailViewControllerSubtitle"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DDGTaskDetailViewControllerSubtitle"];
            }

            [[cell detailTextLabel] setText:[[taskDescrp objectAtIndex:index] objectAtIndex:1]];
            [[cell textLabel] setText:[[taskDescrp objectAtIndex:index] objectAtIndex:0]];
            break;
#endif
            
        case 4: // Task's priority
            cell = [tableView dequeueReusableCellWithIdentifier:@"DDGTaskDetailViewControllerValue"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DDGTaskDetailViewControllerValue"];
            }
            
            [[cell textLabel] setText:@"Priority"];
            [[cell detailTextLabel] setText:@"Normal"];
            break;
            
        case 5: // Availability
            cell = [tableView dequeueReusableCellWithIdentifier:@"DDGTaskDetailViewControllerValue"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DDGTaskDetailViewControllerValue"];
            }
            
            [[cell textLabel] setText:@"Alert"];
            [[cell detailTextLabel] setText:@"9:00 am"];
            break;
            
        case 2: // weather
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"DDGTaskDetailViewControllerValue"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DDGTaskDetailViewControllerValue"];
            }
            
            [[cell textLabel] setText:@"weather"];
            [[cell detailTextLabel] setText:@"sunny"];
            break;
            
        case 6: // Trans
            cell = [tableView dequeueReusableCellWithIdentifier:@"DDGTaskDetailViewControllerValue"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DDGTaskDetailViewControllerValue"];
            }
            
            [[cell textLabel] setText:@"Trans"];
            [[cell detailTextLabel] setText:@"nothing"];
            break;

            
        case 7: // Note
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"DDGTaskDetailViewControllerValue"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DDGTaskDetailViewControllerValue"];
            }
            
            [[cell textLabel] setText:@"Note"];
            [[cell detailTextLabel] setText:@"nothing"];
            break;
            
        default:
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"DDGTaskDetailViewControllerValue"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DDGTaskDetailViewControllerValue"];
            }
            
            [[cell textLabel] setText:@"test"];
            [[cell detailTextLabel] setText:@"aaaa"];
            break;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#if 0
//section头部间距
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;//section头部高度
}

//section底部间距
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
#endif

#if 0
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [tableCell frame].size.height;
}
#endif

- (void)setTaskItem:(DDGTask *)task
{
    taskItem = task;

    // formatter.dateStyle = kCFDateFormatterFullStyle;
    // formatter.timeStyle = kCFDateFormatterNoStyle;
    //[formatter setDateStyle:kCFDateFormatterFullStyle];
    //[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //beginDate = [formatter stringFromDate:[taskItem beginDateTime]];
    
    //duration = [[NSString alloc] initWithFormat:@"%f", [taskItem duration]];
    dateDescrp = [[NSArray alloc] initWithObjects:beginDate, duration, nil];

    // title
    //location = [taskItem place];
    //title = [taskItem title];
    title = taskItem.taskTitle;
    titleDescrp = [[NSArray alloc] initWithObjects:title, location, nil];

    // actor
    //actor = [taskItem commander];
    actorDescrp = [[NSArray alloc] initWithObjects:@"Actor", actor, nil];
    
    taskDescrp = [[NSArray alloc] initWithObjects:titleDescrp, dateDescrp, @"test", actorDescrp, nil];
}
@end
