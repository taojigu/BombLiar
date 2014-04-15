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

#define BombIndex 0
#define IntroductionIndex 1


@interface TargetDetailViewController (){
    @private
    IBOutlet UIView*introductionView;
    IBOutlet UIView*bombView;
    IBOutlet UIView*segmentedBackgroundView;
    HMSegmentedControl*segmentControl;
}

-(IBAction)liarWebCellTapped:(UITapGestureRecognizer*)recognizer;

@end

@implementation TargetDetailViewController

@synthesize target;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    [self initCustomViews];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self layoutCustomViews];
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
    [segmentedBackgroundView addSubview:segmentControl];
    
}



@end
