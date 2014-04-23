//
//  TargetDetailViewController.m
//  BombLiar
//
//  Created by VooleDev6 on 14-4-9.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "TargetDetailViewController.h"
#import "HMSegmentedControl.h"
#import "Target.h"
#import <QuartzCore/QuartzCore.h>
#import "LiarWebViewController.h"
#import "LiarWeb1ViewController.h"
#import "LineChartView.h"

#define BombIndex 1
#define IntroductionIndex 0


#define BombText @"Bomb"
#define PauseBombText @"Pause"


@interface TargetDetailViewController (){
    @private
    IBOutlet UIView*introductionView;
    IBOutlet UIView*bombView;
    IBOutlet UIView*segmentedBackgroundView;
    IBOutlet UITableViewCell*liarWebCell;
    IBOutlet UIButton*bombButton;
    IBOutlet UILabel*bombStatusLabel;
    IBOutlet LineChartView*lineChartView;
    HMSegmentedControl*segmentControl;

}

@property(nonatomic,strong)NSTimer*bombTimer;
@property(nonatomic,strong)NSMutableArray*timeValueArray;

-(IBAction)liarWebCellTapped:(UITapGestureRecognizer*)recognizer;
-(IBAction)bombButtonClicked:(id)sender;




-(void)refreshLineChartView:(CGFloat)timeValue;

@end

@implementation TargetDetailViewController

@synthesize target;
@synthesize bombTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    self.timeValueArray=[[NSMutableArray alloc]init];
    [self initCustomViews];
    return self;
}

-(void)loadView{
    [super loadView];
    
    liarWebCell.selectionStyle=UITableViewCellSelectionStyleGray;
    liarWebCell.backgroundColor=[UIColor clearColor];
    liarWebCell.layer.cornerRadius=8;
    liarWebCell.layer.borderWidth=2;
    liarWebCell.layer.borderColor=[UIColor blackColor].CGColor;
    UITapGestureRecognizer*tapGesuture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(liarWebCellTapped:)];
    [liarWebCell addGestureRecognizer:tapGesuture];
    
    [bombButton setTitle:BombText forState:UIControlStateNormal];
    [bombButton setTitle:PauseBombText forState:UIControlStateSelected];
    
    [self initChartView];
    
    
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self layoutCustomViews];
    
    self.bombTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFiredAction:) userInfo:nil repeats:YES];
    self.bombTimer.fireDate=[NSDate distantFuture];
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

#pragma mark -- action messages

-(IBAction)liarWebCellTapped:(UITapGestureRecognizer*)recognizer{
    LiarWeb1ViewController*lwvc=[[LiarWeb1ViewController alloc]init];
    lwvc.target=self.target;
    [self.navigationController pushViewController:lwvc animated:YES];
    
}
-(IBAction)bombButtonClicked:(id)sender{
    UIButton*btn=(UIButton*)sender;
    if (btn.selected) {
        btn.selected=NO;
        self.bombTimer.fireDate=[NSDate distantFuture];
    }
    else{
        btn.selected=YES;
        //[self pauseBomb];
        self.bombTimer.fireDate=[NSDate date];
    }
}

-(void)segmentIndexChanged{
    if (BombIndex==segmentControl.selectedIndex) {
        bombView.hidden=NO;
        introductionView.hidden=YES;
        return;
    }
    if (IntroductionIndex==segmentControl.selectedIndex) {
        bombView.hidden=YES;
        introductionView.hidden=NO;
        return;
    }
}

-(void)timerFiredAction:(NSTimer*)timer{
    
    dispatch_queue_t queue=dispatch_queue_create("timeFired", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    dispatch_async(queue, ^{[self startBomb];});
    
}

#pragma mark -- private messages

-(void)initCustomViews{
    segmentControl=[[HMSegmentedControl alloc]initWithSectionTitles:[NSArray arrayWithObjects:@"Introduciton",@"Bomb", nil]];
    segmentControl.backgroundColor=[UIColor yellowColor];
    segmentControl.selectionIndicatorMode=HMSelectionIndicatorFillsSegment;
    
    
    __weak TargetDetailViewController*weakSelf=self;
    segmentControl.indexChangeBlock=^(NSUInteger sectionIndex){
        [weakSelf segmentIndexChanged];
        return ;
    };
    
    
}
-(void)layoutCustomViews{
    
    segmentControl.frame=segmentedBackgroundView.bounds;
    segmentControl.selectedIndex=IntroductionIndex;
    [segmentedBackgroundView addSubview:segmentControl];
    
}

-(void)startBomb{
    [self gcdAsiGroupRequest:[NSURL URLWithString:self.target.urlString] density:1000];
}
-(void)pauseBomb{
    
}

-(void)gcdAsiGroupRequest:(NSURL*)targetUrl  density:(NSInteger)density{
    
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group=dispatch_group_create();
    
    __block CGFloat timeCul=0;
    
    
    for (NSInteger requestIndex=0; requestIndex<density;requestIndex++) {
       
        dispatch_group_async(group, queue, ^{
            @autoreleasepool {
                NSDate* startDate=[NSDate date];
                NSData*data=[NSData dataWithContentsOfURL:targetUrl];
                NSDate*endDate=[NSDate date];
                timeCul+=[endDate timeIntervalSinceDate:startDate];

                
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
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_main_queue(), ^{[self refreshLineChartView:timeCul/density];});
    
    

    
}


-(void)refreshLineChartView:(CGFloat)timeData{
    
    [self.timeValueArray addObject:[NSNumber numberWithFloat:timeData]];
    
    NSAssert(0<[self.timeValueArray count], @"no x text");
    
    if ([self.timeValueArray count]>[lineChartView.xTextArray count]) {
        [self.timeValueArray removeObjectAtIndex:0];
    }
    
    [lineChartView setNeedsDisplay];
    
    
}
-(void)initChartView{
    
    lineChartView.yTextArray=@[@"0",@"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8"];
    NSMutableArray*yValueArray=[[NSMutableArray alloc]init];
    for (NSInteger yIndex=0;yIndex<9;yIndex++) {
        NSNumber*number=[NSNumber numberWithInteger:yIndex/10];
        [yValueArray addObject:number];
    }
    lineChartView.yValueArray=yValueArray;
    lineChartView.xTextArray=@[@"0",@"1",@"2",@"3",@"4",@"5",@"6"];
    lineChartView.xStepLength=40;
    lineChartView.yStepLength=20;
    lineChartView.valueArray=self.timeValueArray;
    lineChartView.maxValue=1;
    lineChartView.minValue=0;
}



@end
