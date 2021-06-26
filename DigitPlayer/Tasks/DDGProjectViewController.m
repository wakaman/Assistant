//
//  DDGProjectViewController.m
//  DigitPlayer
//
//  Created by Hackintosh-Developer on 1/8/2017.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGGenericLableController.h"
#import "DDGProjectViewController.h"
#import "DDGProjectTask.h"
#import "DDGTaskStore.h"


//static const NSString* const kProjectCellItem = @"DDGProjectTaskViewCell";
//static const NSString *kProjectCellItem = @"DDGProjectTaskViewCell";
//static NSString *kProjectCellItem = @"DDGProjectTaskViewCell";
static NSString* const kProjectCellItem = @"DDGProjectTaskViewCell";


@interface DDGProjectViewController () <UITableViewDelegate, UITableViewDataSource>

- (bool)checkProject:(DDGProjectTask *)project;
- (void)addFunction:(id)sender;
- (void)addBug:(id)sender;

- (void)addProject:(NSNumber *)number;

- (void)cancel:(id)sender;
- (void)save:(id)sender;

@end

@implementation DDGProjectViewController
{
    DDGProjectTask* projectTask;
}


//@synthesize projectTask;

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
        
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    descripText.text = @"";
    
    if (nil != self.currentTask) {
        projectTask = (DDGProjectTask *)self.currentTask;
    }
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


#pragma mark -- table view protocal
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 1;
    NSInteger value = 1;
    switch (section) {
        case 0:
            value = [projectTask.allFuns count];
            break;
            
        case 1:
            value = [projectTask.allBugs count];
            break;
    }
    
    return value;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProjectCellItem];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kProjectCellItem];
    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [projectTask.allFuns objectAtIndex:indexPath.row];
            break;
        case 1:
            cell.textLabel.text = [projectTask.allBugs objectAtIndex:indexPath.row];
            break;
    }
    
    //cell.textLabel.text = @"New function";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.00;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.userInteractionEnabled = true;
    headerView.backgroundColor = [UIColor clearColor];
    
    // Add button
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [addBtn.layer setMasksToBounds:YES];
    [addBtn.layer setCornerRadius:10.0];
    [addBtn setBackgroundColor:[UIColor greenColor]];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [addBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Add label
    UILabel *label = [UILabel new];
    label.layer.masksToBounds = YES;
    label.font = [UIFont systemFontOfSize:18];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    switch (section) {
        case 0:
            [addBtn addTarget:self action:@selector(addFunction:) forControlEvents:UIControlEventTouchUpInside];
            label.text = @"Functions:";
            break;
        case 1:
            [addBtn addTarget:self action:@selector(addBug:) forControlEvents:UIControlEventTouchUpInside];
            label.text = @"Bugs:";
            break;
    }
    
    [headerView addSubview:addBtn];
    [headerView addSubview:label];
    
    //label.layer.cornerRadius
    NSDictionary *constraintView = NSDictionaryOfVariableBindings(addBtn, label);
    // NSDictionary *constraintsView = NSDictionaryOfVariableBindings(loginButton,registerButton);
    
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[label(100.0)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:constraintView]];
    
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[label]-10-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:constraintView]];
    

    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[addBtn]-5-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:constraintView]];
    
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[addBtn]-20-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:constraintView]];
    
    return headerView;
}

#pragma mark -- private message
- (bool)checkProject:(DDGProjectTask *)project
{
    bool bAlert = false;
    NSString *strMsg;
    
    if (projectTask.taskTitle == nil || projectTask.taskTitle.length == 0) {
        strMsg = @"String message error!";
        return bAlert;
    }
    
    if (project.description == nil || project.description.length == 0) {
        strMsg = @"Description can't be empty!";
        return bAlert;
    }
    
    //if (nil == project.taskBeginDate || nil == project.duration) {
    if (nil == project.taskBeginDate) {
        strMsg = @"Date is nil";
        return bAlert;
    }
    
    return !bAlert;
}

- (void)addFunction:(id)sender
{
    [self addProject:[NSNumber numberWithInt:0]];
}

- (void)addBug:(id)sender
{
    [self addProject:[NSNumber numberWithInt:1]];
}

- (void)addProject:(NSNumber *)number
{
    DDGGenericLableController* labelView = [DDGGenericLableController new];
    [labelView setTitleLabel:@"NewItem"];
    
    [labelView setDismissBlockAction:^(NSString *strTitle){
        
        switch (number.intValue) {
            case 0:
                [projectTask addFunction:strTitle];
                break;
            case 1:
                [projectTask addBug:strTitle];
                break;
        }
        
        [showItems reloadData];
    }];
    
    UIBarButtonItem *backBarBtnItem = [[UIBarButtonItem alloc] init];
    [[self navigationItem] setBackBarButtonItem:backBarBtnItem];
    [backBarBtnItem setTitle:@"Back"];
    
    [self.navigationController setToolbarHidden:true];
    [self.navigationController pushViewController:labelView animated:YES];
}

- (NSString *)addBtnClick:(id)sender
{
    //NSLog(@"Here we are!");
    
    DDGGenericLableController* labelView = [DDGGenericLableController new];
    [labelView setTitleLabel:@"NewItem"];
    
    
#if 0
    [labelView setBlockRetLabelText:^{
        NSLog(@"Hello world");
        return @"hello";
    }];
#endif
    
    NSNumber* number = (NSNumber *)sender;
    
    //__block NSString* strValue;
    [labelView setDismissBlockAction:^(NSString *strTitle){
        
        switch (number.intValue) {
            case 0:
                [projectTask addFunction:strTitle];
                break;
                
            case 1:
                [projectTask addBug:strTitle];
                break;
        }
        //strValue = strTitle;
        //[showItems reloadData];
    }];
    
    
    UIBarButtonItem *backBarBtnItem = [[UIBarButtonItem alloc] init];
    [[self navigationItem] setBackBarButtonItem:backBarBtnItem];
    [backBarBtnItem setTitle:@"Back"];
    
    // [[self navigationController] SetToolbarHidden:false];
    // [[self navigationController] setToolbarHidden:true];
    // [[self navigationController] pushViewController:labelView animated:YES];
    
    [self.navigationController setToolbarHidden:true];
    [self.navigationController pushViewController:labelView animated:YES];
    
    //return [strValue copy];
    return @"";
    
#if 0
    [labelView setDismissBlockArg:^(NSString *strTitle){
        //[task setTitle:strTitle];
        //task.taskTitle = strTitle;
        //[tableView reloadData];
        return @"Here we are in the dismiss block!";
    }];
    
    [labelView setDismissBlockArgs:^(NSString *str, int iPara){
        NSLog(@"This is %@, int is %i", str, iPara);
    }];    
#endif
    //return @"Need do something";
}

- (void)cancel:(id)sender
{
    [[DDGTaskStore sharedStore] removeTask:self.currentTask];
    
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    return;
}
- (void)save:(id)sender
{
    //NSString *strMsg = @"Here we are!";
    //NSLog(@"Here you are!");
    //projectTask.descripText =
    
    projectTask.projectDescrp = descripText.text;
    projectTask.taskTitle = titleText.text;
    
    //if (! [self checkProject:(DDGProjectTask *)self.currentTask]) {
    if (! [self checkProject:projectTask]) {

        // Self alert view
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Got Error!"
                                                            message:@"Parameter error!"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
        return;
    }
    
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    
    return;
}
@end
