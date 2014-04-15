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
#import "Target.h"
#import "TargetCell.h"


@interface TargetTableViewController ()<ASIHTTPRequestDelegate>

@end

@implementation TargetTableViewController

@synthesize targetContainer;


-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
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
    return [self.targetContainer.elementArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TargetCell *cell = (TargetCell*)[tableView dequeueReusableCellWithIdentifier:@"TargetCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Target*target=[self.targetContainer.elementArray objectAtIndex:indexPath.row];
    cell.nameLabel.text=target.name;
    cell.introductionLabel.text=target.introduction;

    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    TargetDetailViewController*dvc=(TargetDetailViewController*)[segue destinationViewController];
    NSIndexPath*indexPath=[self.tableView indexPathForSelectedRow];
    Target*target=[self.targetContainer.elementArray objectAtIndex:indexPath.row];
    dvc.target=target;
    

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
    
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    [request startAsynchronous];
                            
                        
}
-(void)reloadTargetPage:(NSInteger)pageIndex{
    [self reloadTargetPage:pageIndex pageSize:12];
}


@end
