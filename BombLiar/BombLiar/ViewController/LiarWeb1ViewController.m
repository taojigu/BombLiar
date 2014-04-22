//
//  LiarWeb1ViewController.m
//  BombLiar
//
//  Created by VooleDev6 on 14-4-15.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "LiarWeb1ViewController.h"
#import "Target.h"
#import "AsiHttpRequest.h"

@interface LiarWeb1ViewController ()<ASIHTTPRequestDelegate>{
    
    @private
    IBOutlet UIWebView*webView;
    
}

@end

@implementation LiarWeb1ViewController

@synthesize target;


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
    // Do any additional setup after loading the view from its nib.
    self.title=self.target.name;
 
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:self.target.urlString]];
    request.delegate=self;
    [request startAsynchronous];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- delegate messages

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    [webView loadHTMLString:[request responseString] baseURL:nil];
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"%@ failed",request.url);
}

@end
