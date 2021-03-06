//
//  ResponseTestViewController.m
//  BombLiar
//
//  Created by VooleDev6 on 14-4-1.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "ResponseTestViewController.h"
#import "ConstConfig.h"
#import "AsiHttpRequest.h"



@interface ResponseTestViewController (){
    @private
    IBOutlet UILabel*labelTargetUrl;
    IBOutlet UILabel*labelResult;
    IBOutlet UIView*chartView;
    
    NSMutableArray*resultBuffer;
    NSTimer* testTimer;
    
}


-(IBAction)testButtonClicked:(id)sender;
-(IBAction)autoTestButtonClicked:(id)sender;

@end

@implementation ResponseTestViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        resultBuffer=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    labelTargetUrl.text=RealTargetURLString;
    
    [self initCustomViews];
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

-(void)asiSyncTest{
    dispatch_queue_t mainQueue=dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        
        NSTimeInterval time=[NSDate timeIntervalSinceReferenceDate];
        NSURL *testUrl=[NSURL URLWithString:labelTargetUrl.text];
        ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:testUrl];
        [request startSynchronous];
        NSString*resultString=request.responseString;
        if (0!=[resultString length]) {
            NSTimeInterval endTime=[NSDate timeIntervalSinceReferenceDate];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                labelResult.text=[NSString stringWithFormat:@"%f-%@",endTime-time,resultString];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                labelResult.text=@"Failed";
            });
        }
    });

    
}


#pragma mark action messages
-(IBAction)testButtonClicked:(id)sender{
    
    
    
    [self asiSyncTest];
    return;
    dispatch_queue_t mainQueue=dispatch_get_main_queue();
    //__weak ResponseTestViewController* weakSelf=self;
    dispatch_async(mainQueue, ^{
        
        NSTimeInterval time=[NSDate timeIntervalSinceReferenceDate];
        
        
        
        NSURL *testUrl=[NSURL URLWithString:labelTargetUrl.text];
        ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:testUrl];
        [request startSynchronous];
        NSData*data=[NSData dataWithContentsOfURL:testUrl];
        if (nil!=data) {
            NSTimeInterval endTime=[NSDate timeIntervalSinceReferenceDate];
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                labelResult.text=[NSString stringWithFormat:@"%f",endTime-time];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                labelResult.text=@"Failed";
            });
        }
    });
}
-(IBAction)autoTestButtonClicked:(id)sender{
    
}


#pragma mark private messages

-(void)startTest{
    
}
-(void)initCustomViews{
    
}

@end
