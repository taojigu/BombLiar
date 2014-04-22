//
//  LiarWebViewController.m
//  BombLiar
//
//  Created by VooleDev6 on 14-4-10.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "LiarWebViewController.h"
#import "Target.h"

@interface LiarWebViewController (){
    @private
    IBOutlet UIWebView*webView;
}

@end

@implementation LiarWebViewController

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
    // Do any additional setup after loading the view.
    self.title=self.target.name;
    
    NSURL*url=[NSURL URLWithString:self.target.urlString];

    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
