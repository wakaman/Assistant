//
//  DDGForthPlanTableViewController.m
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 3/15/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGForthPlanTableViewController.h"
#import "DDGGenericLableController.h"
#import "DDGPlanStore.h"

@interface DDGForthPlanTableViewController ()

@end

@implementation DDGForthPlanTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        UINavigationItem* navItem = [self navigationItem];
        [navItem setTitle:@"PlanList"];
        
        UIBarButtonItem* rightBarBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                         target:self
                                                                                         action:@selector(addNewPlan:)];
        [[self navigationItem] setRightBarButtonItem:rightBarBtnItem];

//        [[self tableView] setDataSource:self];
//        [[self tableView] setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[DDGPlanStore sharedStore] allPlanItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserPlanCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserPlanCell"];
    }
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserPlanCell" forIndexPath:indexPath];
    // Configure the cell...
    // if (cell == nil) {
    //  ]
    //}    

    [[cell textLabel] setText:[[[DDGPlanStore sharedStore] allPlanItems] objectAtIndex:[indexPath row]]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Cutom function
- (IBAction)addNewPlan:(id)sender
{
    
    DDGGenericLableController* labelVC = [DDGGenericLableController new];//[[DDGGenericLableViewController alloc] init];
    [labelVC setTitleLabel:@"Add bility"];
    
    [labelVC setDismissBlockAction:^(NSString* strTitle) {
        
        if (strTitle == nil || [strTitle length] == 0) {
            return;
        }
        
        [[DDGPlanStore sharedStore] addPlan:strTitle];
    }];
    
    UINavigationController* navViewCtrl = [[UINavigationController alloc] initWithRootViewController:labelVC];
    [navViewCtrl setModalPresentationStyle:UIModalPresentationCurrentContext];
    [navViewCtrl setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    //[self presentViewController:navViewCtrl animated:YES completion:nil];
    [[self navigationController] pushViewController:labelVC animated:YES];
}

@end



























































































































