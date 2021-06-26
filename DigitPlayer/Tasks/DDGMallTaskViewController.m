//
//  DDGMallTaskViewController.m
//  DigitPlayer
//
//  Created by SnowSquirrel on 7/5/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGMallTaskViewController.h"
#import "DDGGenericTableCellController.h"
#import "DDGTaskDateTimeViewController.h"
#import "DDGGenericLableController.h"

//#import "DDGShopTask+CoreDataClass.h"
//#import "DDGTask+CoreDataClass.h"

#import "DDGShopTask.h"
#import "DDGTaskStore.h"


static NSString* const kShopGoodsCellItem = @"DDGMallTaskTableViewCell";
const NSInteger kShopGoodsSetting = 1;
const NSInteger kMerchantSetting = 0;


typedef NS_ENUM(NSUInteger, MallSectionItem)
{
    MSectionEvent,
    MSectionGoods
};

typedef NS_ENUM(NSUInteger, MerchantInfo)
{
    MerchantShop,
    MerchantDate,
    MerchantDuration
};

@interface DDGMallTaskViewController () <UITableViewDelegate, UITableViewDataSource>


- (void)cancel:(id)sender;
- (void)save:(id)sender;

- (void)addBtnClick:(id)sender;
- (void)delBtnClick:(id)sender;

- (BOOL)checkMallTask:(DDGTask *)taskItem;

@end

@implementation DDGMallTaskViewController
{
    NSMutableArray *goodItems;
    NSArray *mallItems;
    
    DDGShopTask *shopTask;
    
    NSString *merchant;
    NSString *datetime;
    NSString *duration;
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
        
        goodItems = [NSMutableArray new];
        [goodItems addObject:@"NewItem"];
        
        mallItems = [NSArray arrayWithObjects:@"Merchant", @"Date&Time", @"Duration", nil];
    }
    
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- setter
- (void)setTask:(DDGTask *)task
{
    if ([task isKindOfClass:[DDGShopTask class]]) {
        shopTask = (DDGShopTask *)task;
        super.currentTask = task;
    }
    
#if 0
    if (task.type.unsignedIntegerValue == DDGTaskTypeShop) {
        shopTask = (DDGShopTask *)task;
        super.task = task;
    }
#endif
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- table view protocal
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
            
        case MSectionEvent:
            
            return [mallItems count];
            break;
            
        case MSectionGoods:
            
            return [goodItems count];
            break;
            
        default:
            break;
    }
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDGMallTaskTableViewCell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopGoodsCellItem];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kShopGoodsCellItem];
    }
    
    switch ([indexPath section]) {
        case MSectionEvent:
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            cell.textLabel.text = [mallItems objectAtIndex:indexPath.row];

            switch ([indexPath row]) {
                    
                case MerchantDuration:
                    
                    //[cell.detailTextLabel setText:shopTask.duration];
                    break;
                    
                case MerchantShop:

                    [cell.detailTextLabel setText:shopTask.taskTitle];
                    break;
                    
                case MerchantDate:
                {
                    NSDateFormatter *formatter = [NSDateFormatter new];
                    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    cell.detailTextLabel.text = [formatter stringFromDate:shopTask.taskBeginDate];
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        case MSectionGoods:

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = (NSString *)goodItems[(int)indexPath.row];
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch ([indexPath section]) {
            
        case MSectionEvent:
        {
            switch ([indexPath row]) {
                    
                case MerchantShop:
                {
                    DDGGenericTableCellController *genericVC = [DDGGenericTableCellController new];
                    NSMutableArray *sectionArray = [NSMutableArray new];
                    [sectionArray addObject:@[@"华润万家", @"沃尔玛", @"天虹商场", @"家乐福", @"宜家家居"]];
                    genericVC.sectionArray = sectionArray;
                    genericVC.title = @"Merchant";
                    genericVC.sectionNum = 1;
                    
                    UIBarButtonItem *backBarBtn = [UIBarButtonItem new];
                    [[self navigationItem] setBackBarButtonItem:backBarBtn];
                    [backBarBtn setTitle:@"Back"];
                    
                    [genericVC setDismissBlockObjArg:^(NSString *stringValue) {
                        //shopTask.title = stringValue;
                        shopTask.taskTitle = stringValue;
                        merchant = stringValue;
                        [dataTableView reloadData];
                    }];
                    
                    if ([self navigationController] == nil) {
                        
                        UINavigationController *navigation = [UINavigationController new];
                        [navigation pushViewController:genericVC animated:YES];
                        
                    }else {
                        
                        [[self navigationController] pushViewController:genericVC animated:YES];
                    }
                }
                break;
                    
                case MerchantDuration:
                {
                    DDGGenericTableCellController *genericVC = [DDGGenericTableCellController new];
                    NSMutableArray *sectionArray = [NSMutableArray new];
                    [sectionArray addObject:@[@"15m", @"20m", @"25m", @"30m", @"35m", @"40m", @"45m", @"50m", @"55m",
                                              @"1H", @"70m", @"80m", @"1.5H", @"100m", @"110m", @"2H", @"2.5H", @"3H", @"4H"]];
                    genericVC.sectionArray = sectionArray;
                    genericVC.title = @"Duration";
                    genericVC.sectionNum = 1;
                    
                    UIBarButtonItem *backBarBtn = [UIBarButtonItem new];
                    [[self navigationItem] setBackBarButtonItem:backBarBtn];
                    [backBarBtn setTitle:@"Back"];
                    
                    [genericVC setDismissBlockObjArg:^(NSString *stringValue) {
//                        shopTask.duration = stringValue;
                        duration = stringValue;
                        [dataTableView reloadData];
                    }];
                    
                    if ([self navigationController] == nil) {
                        
                        UINavigationController *navigation = [UINavigationController new];
                        [navigation pushViewController:genericVC animated:YES];
                        
                    }else {
                        
                        [[self navigationController] pushViewController:genericVC animated:YES];
                    }
                }
                break;
                    
                case MerchantDate:
                {
                    DDGTaskDateTimeViewController *dateVC = [DDGTaskDateTimeViewController new];
                    UIBarButtonItem *backBarBtn = [UIBarButtonItem new];
                    
                    [[self navigationItem] setBackBarButtonItem:backBarBtn];
                    [backBarBtn setTitle:@"Back"];
                    
                    [dateVC setDismissBlockArgs:^(NSString *beginDateTime, NSString *endDateTime) {
                        
                        NSDateFormatter *formatter = [NSDateFormatter new];
                        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        shopTask.taskBeginDate = [formatter dateFromString:beginDateTime];
                        datetime = beginDateTime;
                        
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
                    
                default:
                    break;
            }
        }
        break;
            
        case MSectionGoods:
        {
            DDGGenericLableController *genericLableVC = [DDGGenericLableController new];
            [genericLableVC setDismissBlockAction:^(NSString *stringValue){
                [goodItems setObject:stringValue atIndexedSubscript:[indexPath row]];
                [dataTableView reloadData];
            }];
            
            if ([self navigationController] == nil) {
                
                UINavigationController *navigation = [UINavigationController new];
                [navigation pushViewController:genericLableVC animated:YES];
            }else {
                
                [[self navigationController] pushViewController:genericLableVC animated:YES];
            }
        }
        break;
            
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        // [[DDGTaskStore sharedStore] removeTask:[[[DDGTaskStore sharedStore] allTasks] objectAtIndex:[indexPath row]]];
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        // [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        // NSLog(@"here we in deleting");
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        // NSLog(@"Here we in inserting");
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // ----- Method -----
    NSLog(@"We can change view controller in this method!");
    
    switch ([indexPath section]) {
            
        case MSectionEvent:
        {
            switch ([indexPath row]) {
                    
                case MerchantShop:
                {
                    DDGGenericTableCellController *genericVC = [DDGGenericTableCellController new];
                    // genericVC.itemDat = [NSArray arrayWithObjects:@"华润万家", @"沃尔玛", @"天虹商场", @"家乐福", @"宜家家居", nil];
                    genericVC.title = @"Merchant";
                    
                    UIBarButtonItem *backBarBtn = [UIBarButtonItem new];
                    [[self navigationItem] setBackBarButtonItem:backBarBtn];
                    [backBarBtn setTitle:@"Back"];
                    
                    [genericVC setDismissBlockObjArg:^(NSString *stringValue) {
                        shopTask.taskTitle = stringValue;
                        merchant = stringValue;
                        [dataTableView reloadData];
                    }];
                    
                    if ([self navigationController] == nil) {
                        
                        UINavigationController *navigation = [UINavigationController new];
                        [navigation pushViewController:genericVC animated:YES];
                        
                    }else {
                        
                        [[self navigationController] pushViewController:genericVC animated:YES];
                    }
                }
                    break;
                    
                case MerchantDuration:
                {
                    DDGGenericTableCellController *genericVC = [DDGGenericTableCellController new];
                    genericVC.title = @"Duration";
                    
                    UIBarButtonItem *backBarBtn = [UIBarButtonItem new];
                    [[self navigationItem] setBackBarButtonItem:backBarBtn];
                    [backBarBtn setTitle:@"Back"];
                    
                    [genericVC setDismissBlockObjArg:^(NSString *stringValue) {
//                        shopTask.duration = stringValue;
                        duration = stringValue;
                        [dataTableView reloadData];
                    }];
                    
                    if ([self navigationController] == nil) {
                        
                        UINavigationController *navigation = [UINavigationController new];
                        [navigation pushViewController:genericVC animated:YES];
                        
                    }else {
                        
                        [[self navigationController] pushViewController:genericVC animated:YES];
                    }
                }
                    break;
                    
                case MerchantDate:
                {
                    DDGTaskDateTimeViewController *dateVC = [DDGTaskDateTimeViewController new];
                    UIBarButtonItem *backBarBtn = [UIBarButtonItem new];
                    
                    [[self navigationItem] setBackBarButtonItem:backBarBtn];
                    [backBarBtn setTitle:@"Back"];
                    
                    [dateVC setDismissBlockArgs:^(NSString *beginDateTime, NSString *endDateTime) {
                        
                        NSDateFormatter *formatter = [NSDateFormatter new];
                        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        shopTask.taskBeginDate = [formatter dateFromString:beginDateTime];
                        datetime = beginDateTime;
                        
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
                    
                default:
                    break;
            }
        }
            break;
            
        case MSectionGoods:
        {
            DDGGenericLableController *genericLableVC = [DDGGenericLableController new];
            [genericLableVC setDismissBlockAction:^(NSString *stringValue){
                [goodItems setObject:stringValue atIndexedSubscript:[indexPath row]];
                [dataTableView reloadData];
            }];
            
            if ([self navigationController] == nil) {
                
                UINavigationController *navigation = [UINavigationController new];
                [navigation pushViewController:genericLableVC animated:YES];
            }else {
                
                [[self navigationController] pushViewController:genericLableVC animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (kShopGoodsSetting == section) {
        return 60.00;
    } else {
        return 2.00;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section != kShopGoodsSetting) {
        return nil;
    }
    
    UIView *footerView = [UIView new];
    footerView.userInteractionEnabled = true;
    footerView.backgroundColor = [UIColor clearColor];
    
    // Add button
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [addBtn.layer setMasksToBounds:YES];
    [addBtn.layer setCornerRadius:5.0];
    [addBtn setBackgroundColor:[UIColor greenColor]];
    [addBtn setTitle:@"Add" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [addBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addBtn];

    // Delete button
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [delBtn.layer setMasksToBounds:YES];
    [delBtn.layer setCornerRadius:5.0];
    [delBtn setBackgroundColor:[UIColor brownColor]];
    [delBtn setTitle:@"Del" forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [delBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [delBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [delBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:delBtn];
    
    
    NSDictionary *constraintView = NSDictionaryOfVariableBindings(addBtn, delBtn);
    // NSDictionary *constraintsView = NSDictionaryOfVariableBindings(loginButton,registerButton);
    
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[addBtn]-10-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:constraintView]];
    
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[addBtn]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:constraintView]];
    
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[delBtn(==addBtn)]-10-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:constraintView]];
    
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[addBtn]-60-[delBtn(==addBtn)]-20-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:constraintView]];
    
#if 0    
    //[footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[loginButton]-15-|"  options:0 metrics:nil views:constraintsView ]];
    //[footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[loginButton]"    options:0 metrics:nil views:constraintsView ]];
    
    //[footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[registerButton(==loginButton)]-15-|"  options:0 metrics:nil views:constraintsView ]];
    //[footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[loginButton]-30-[registerButton(==loginButton)]-20-|"    options:0 metrics:nil views:constraintsView]];
#endif
    
    return footerView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL bEdit = FALSE;
    
    if (indexPath.section != kMerchantSetting) {
        bEdit = TRUE;
    }
    
    return bEdit;
}

#pragma mark -- private message
- (void)addBtnClick:(id)sender
{
    [goodItems addObject:@"NewItem"];
    [dataTableView reloadData];
}

- (void)delBtnClick:(id)sender
{
    if (0 == [goodItems count]) {
        return;
    }
    
    [goodItems removeObjectAtIndex:0];
    [dataTableView reloadData];
}

- (void)cancel:(id)sender
{
    if (shopTask) {
        [[DDGTaskStore sharedStore] removeTask:shopTask];
    }
    
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (void)save:(id)sender
{
    if ([self checkMallTask:shopTask]) {
        
//        shopTask.goodList = [NSKeyedArchiver archivedDataWithRootObject:goodItems];
        
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    }
}

- (BOOL)checkMallTask:(DDGShopTask *)taskItem
{
    
    BOOL bAlert = false;
    NSString *strMsg;
    
    if (taskItem.taskBeginDate == nil /* || nil ==  taskItem.duration */) {
        strMsg = @"Date is nil";
        bAlert = true;
    }
    
    if (taskItem.taskTitle == nil || taskItem.taskTitle.length == 0) {
        strMsg = @"Title is nil";
        bAlert = true;
    }
    
    if ([goodItems count] == 0) {
        strMsg = @"No good item!";
        bAlert = true;
    }
    
    if (bAlert)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Got Error!"
                                                            message:strMsg
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
        return false;
    }
    
    return true;
}
@end
