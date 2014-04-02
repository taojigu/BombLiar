//
//  ResponseTestViewController.m
//  BombLiar
//
//  Created by VooleDev6 on 14-4-1.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "ResponseTestViewController.h"
#import "ConstConfig.h"

@interface ResponseTestViewController (){
    @private
    IBOutlet UILabel*labelTargetUrl;
    IBOutlet UILabel*labelResult;
}


@end

@implementation ResponseTestViewController



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
    labelTargetUrl.text=RealTargetURLString;
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

#pragma mark action messages
-(IBAction)testButtonClicked:(id)sender{
    dispatch_queue_t testQueue=dispatch_queue_create("testQueue", nil);
    dispatch_queue_t mainQueue=dispatch_get_main_queue();
    //__weak ResponseTestViewController* weakSelf=self;
    dispatch_async(mainQueue, ^{
    
        NSTimeInterval time=[NSDate timeIntervalSinceReferenceDate];

        NSURL *testUrl=[NSURL URLWithString:labelTargetUrl.text];
        NSData*data=[NSData dataWithContentsOfURL:testUrl];
        if (nil!=data) {
            NSTimeInterval endTime=[NSDate timeIntervalSinceReferenceDate];
            NSString*dataString=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                labelResult.text=[NSString stringWithFormat:@"%f-%@",endTime-time,dataString];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                labelResult.text=@"Failed";
            });
        }
    });
}

#pragma mark private messages

-(void)startTest{
    
}

@end
