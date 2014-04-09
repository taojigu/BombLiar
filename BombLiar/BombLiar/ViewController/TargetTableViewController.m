//
//  TargetTableViewController.m
//  BombLiar
//
//  Created by VooleDev6 on 14-4-9.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "TargetTableViewController.h"
#import "TargetDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "ElementsContainer.h"
#import "TargetPageParser.h"
#import "RequestStringUtlity.h"


@interface TargetTableViewController ()<ASIHTTPRequestDelegate,ASICacheDelegate>

@end

@implementation TargetTableViewController

@synthesize targetContainer;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.targetContainer=[[ElementsContainer alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reloadTargetPage:0];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TargetCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
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


#pragma mark - UITableViewDelegate messages

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    TargetDetailViewController*dvc=(TargetDetailViewController*)[segue destinationViewController];
    dvc.titleName=@"Hello";
}

#pragma mark -- AsiHttpRequestDelegate messages

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSData*data=request.responseData;
    TargetPageParser*parser=[[TargetPageParser alloc]init];
    ElementsContainer*resultPage=[parser parse:data];
    self.targetContainer.pageIndex=resultPage.pageIndex;
    [self.targetContainer.elementArray addObjectsFromArray:resultPage.elementArray];
    [self.tableView reloadData];
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"Failed Request From %@",request.url);
}

#pragma mark -- private messages

-(void)reloadTargetPage:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{

    NSString*urlString=[RequestStringUtlity targetPageReuqustUrlString:pageIndex pageSize:pageSize];
    NSURL*url=[NSURL URLWithString:urlString];
    
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:url usingCache:self andCachePolicy:ASIUseDefaultCachePolicy];
    request.delegate=self;
    [request startAsynchronous];
                            
                        
}
-(void)reloadTargetPage:(NSInteger)pageIndex{
    [self reloadTargetPage:pageIndex pageSize:12];
}


@end
