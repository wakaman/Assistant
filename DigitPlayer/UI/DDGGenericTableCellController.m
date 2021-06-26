//
//  DDGenericTableCellViewController.m
//  DigitPlayer
//
//  Created by Jack on 2/9/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGGenericTableCellController.h"

@interface DDGGenericTableCellController()
{
}
@end

@implementation DDGGenericTableCellController
{
    // NSInteger index;
    NSIndexPath *secIndex;
}


@synthesize dismissBlockObjArg;
@synthesize dismissBlockObjAry;
@synthesize sectionArray;
@synthesize sectionNum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        //[[self navigationController] setTitle:navTitle];
 
        secIndex = [NSIndexPath new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    // NSIndexPath* first = [NSIndexPath indexPathForRow:0 inSection:0];
    
    secIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    [dataView selectRowAtIndexPath:secIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    NSArray *itemArray = [sectionArray objectAtIndex:[secIndex section]];
    if (dismissBlockObjArg) {
        dismissBlockObjArg([itemArray objectAtIndex:[secIndex row]]);
    }
    
    if (dismissBlockObjAry) {
        dismissBlockObjAry(itemArray);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- table view protocal
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *itemArray = [sectionArray objectAtIndex:section];
    return [itemArray count];
    
    //return [[sectionArray objectAtIndex:section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDGGenericTableCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DDGGenericTableCell"];
    }
    
    NSArray *itemArray = [sectionArray objectAtIndex:[indexPath section]];
    [cell.textLabel setText:[itemArray objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // dismissBlockObjArg([cellData objectAtIndex:[indexPath row]]);
    NSLog(@"section : %ld", (long)[indexPath section]);
    NSLog(@"row : %ld", (long)[indexPath row]);
    
    secIndex = indexPath;
    
    
    
    NSLog(@"%@", secIndex);
}

@end
