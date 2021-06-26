//
//  DDGMallTaskDetailViewViewController.m
//  DigitPlayer
//
//  Created by Hackintosh-Developer on 20/7/2017.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#import "DDGMallTaskDetailViewController.h"
#import "DDGShopTask.h"
//#import "DDGShopTask+CoreDataClass.h"


@interface DDGMallTaskDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DDGMallTaskDetailViewController

// @synthesize itemArray;

@synthesize dismissBlock;
@synthesize goodsArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (dismissBlock) {
        dismissBlock(goodsArray);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [goodsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UIMallTaskGoodsItemCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UIMallTaskGoodsItemCell"];
    }
    
#if 0
    int index = (int)[indexPath row];
    cell.textLabel.text = goodsArray[index];
#endif
    
    cell.textLabel.text = [goodsArray objectAtIndex:[indexPath row]];    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source must for deleting data
        [goodsArray removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        // NSLog(@"Here we in inserting");
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
