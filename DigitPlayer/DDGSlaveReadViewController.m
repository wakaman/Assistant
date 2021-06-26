//
//  DDGSlaveReadViewController.m
//  DigitPlayer
//
//  Created by Mavericks-Hackintosh on 1/17/17.
//  Copyright (c) 2017 Mavericks-Hackintosh. All rights reserved.
//


#import "DDGDetailBookInfoViewController.h"
#import "DDGQRCoderScanViewController.h"
#import "DDGSlaveReadViewController.h"
#import "DDGCusTaskTableViewCell.h"

#import "DDGBookStore.h"
#import "DDGShopTask.h"
#import "DDGBook.h"

//#import "DDGReadBook.h"


// <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@interface DDGSlaveReadViewController ()
{
}

@property (strong, nonatomic) UITableView *bookView;

@end

@implementation DDGSlaveReadViewController

@synthesize bookView;

- (id)init
{
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        [self.navigationItem setTitle:@"BRScan"];
        UIBarButtonItem* rightBarBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                         target:self
                                                                                         action:@selector(scanBook:)];
        [[self navigationItem] setRightBarButtonItem:rightBarBtnItem];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        //
        // Table -- table
        //
        bookView = [[UITableView alloc] initWithFrame:self.view.frame
                                                style:UITableViewStylePlain];
        bookView.dataSource = self;
        bookView.delegate = self;
        
        // Very very very important!!!
        [self.view addSubview:bookView];
        
        // Cell --
        UINib *cusCellLib = [UINib nibWithNibName:@"DDGCusTaskTableViewCell" bundle:nil];
        [[self bookView] registerNib:cusCellLib forCellReuseIdentifier:@"DDGCusBookTableViewCell"];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    [bookView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[DDGBookStore sharedStore] allBooks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDGCusTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDGCusBookTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[DDGCusTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DDGCusBookTableViewCell"];
    }
    
    [[cell masterLabel] setFont:[UIFont systemFontOfSize:15]];
    [[cell slaveLabel] setFont:[UIFont systemFontOfSize:13]];
    [[cell thridLabel] setFont:[UIFont systemFontOfSize:12]];
    [[cell forthLabel] setFont:[UIFont systemFontOfSize:12]];
    
    DDGBook *book = [[[DDGBookStore sharedStore] allBooks] objectAtIndex:indexPath.row];
    
    // Title, author, date, price, --
    NSArray *authorArray = [NSKeyedUnarchiver unarchiveObjectWithData:[book author]];
    [cell.slaveLabel setText:[authorArray objectAtIndex:0]];
    [cell.masterLabel setText:book.title];
    
    // Publish date  -- @"yyyy-MM-dd HH:mm:ss"     //format.dateFormat = @"yyyy-MM";
    NSDateFormatter *format = [NSDateFormatter new];
    [cell.thridLabel setText:[format stringFromDate:book.publishDate]];
    
    // Pages
    [cell.forthLabel setText:[NSString stringWithFormat:@"%dp", [book.pages intValue]]];
    
    // Image
    [cell.thumbnailView setImage:book.largeImage];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDGBook *book = [[[DDGBookStore sharedStore] allBooks] objectAtIndex:[indexPath row]];
    
    // DDGDetailBookInfoViewController *detailBookInfoVC = [[DDGDetailBookInfoViewController alloc] init];
    DDGDetailBookInfoViewController *detailBookInfoVC = [DDGDetailBookInfoViewController new];
    [detailBookInfoVC setCurrentBook:book];
    
    UIBarButtonItem *backBarBtnItem = [UIBarButtonItem new];
    [[self navigationItem] setBackBarButtonItem:backBarBtnItem];
    [backBarBtnItem setTitle:@"Back"];
    
    [self.navigationController pushViewController:detailBookInfoVC animated:YES];
    NSLog(@"here we are in BRScan selected row indexpath!");
}

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
        [[DDGBookStore sharedStore] removeBook:[[[DDGBookStore sharedStore] allBooks] objectAtIndex:[indexPath row]]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } //else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
}

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

#pragma mark - Custom function (public message function)
- (IBAction)scanBook:(id)sender
{
    // Open camera and we will take the code (qr)
    DDGQRCoderScanViewController* bookScanVC = [DDGQRCoderScanViewController new];
    [bookScanVC setDismissBlock:^{  [bookView reloadData];    }];
    
    // In order to solve back's background color
    // bookScanVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    bookScanVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    bookScanVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;    
    
    [[self navigationController] pushViewController:bookScanVC animated:YES];
}
@end




























































































































