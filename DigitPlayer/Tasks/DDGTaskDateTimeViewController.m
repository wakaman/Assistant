//
//  DDGTaskDateTimeViewController.m
//  DigitPlayer
//
//  Created by Hackintosh-SnowSquirrel on 3/7/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGTaskDateTimeViewController.h"

@interface DDGTaskDateTimeViewController ()
{
    NSMutableArray *valueArray;
    
    UIColor* cellColor;
    NSInteger index;
}
@end

@implementation DDGTaskDateTimeViewController

@synthesize dismissBlockArgs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {        
        // [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        titleArray = [NSMutableArray arrayWithObjects:@"Starts", @"Ends", nil];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        valueArray = [[NSMutableArray alloc] initWithObjects:dateTime, dateTime, nil];        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationItem] setTitle:@"Start&End"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];    
    dismissBlockArgs([valueArray objectAtIndex:0], [valueArray objectAtIndex:1]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // self tableView:table didSelectRowAtIndexPath:
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged]; 
    
    NSIndexPath* first = [NSIndexPath indexPathForRow:0 inSection:0];    
    [dateView selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [valueArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITaskDateTimeViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITaskDateTimeViewCell"];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* beginDate = [formatter dateFromString:[valueArray objectAtIndex:0]];
    NSDate* endDate = [formatter dateFromString:[valueArray objectAtIndex:1]];
    
    if (cellColor == nil) {
        cellColor = [[cell detailTextLabel] textColor];
    }
    
    if ([indexPath row] == 0) {

        if (NSOrderedDescending == [beginDate compare:endDate] && [indexPath row] == 0) {
            [[cell detailTextLabel] setTextColor:[UIColor redColor]];
        }else {
            [[cell detailTextLabel] setTextColor:cellColor];
            //[[cell detailTextLabel] setTextColor:[UIColor whiteColor]];
        }    
    }
    
    [[cell textLabel] setText:[titleArray objectAtIndex:[indexPath row]]];
    [[cell detailTextLabel] setText:[valueArray objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [datePicker setDate:[NSDate date]];
    index = [indexPath row];
}

- (void)dateChange:(id)sender
{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [valueArray replaceObjectAtIndex:index withObject:[formatter stringFromDate:[control date]]];
    // [valueArray setObject:[formatter stringFromDate:[control date]] atIndexedSubscript:index];
    
    [dateView reloadData];
    NSIndexPath* first = [NSIndexPath indexPathForRow:index inSection:0];
    [dateView selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    // NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}
@end











































































