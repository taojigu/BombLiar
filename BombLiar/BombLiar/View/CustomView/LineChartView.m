//
//  LineChartView.m
//  CharTest
//
//  Created by VooleDev6 on 14-4-16.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "LineChartView.h"

#define DefaultYStepLength 30
#define DefaultXStepLength 50
#define DefaultValueLineWidth 1.5
#define DefaultMaxValue 100
#define DefaultMinValue 0

#import "InfoView.h"



@interface LineChartView(){
    @private
    NSInteger lastInfoViewIndex;
    CGPoint lastInfoPoint;

}

@property(nonatomic,strong)InfoView*infoView;
@property(nonatomic,strong)NSMutableArray*valuePointArray;

@end

@implementation LineChartView

@synthesize xTextArray;
@synthesize yTextArray;
@synthesize yValueArray;
@synthesize valueArray;
@synthesize valuePointArray;
@synthesize edgeInsets;

@synthesize maxValue;
@synthesize minValue;

@synthesize infoView;




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self customInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawAxis];
    [self drawValuePoints];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self showTouchIndicator:[touches anyObject]];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self showTouchIndicator:[touches anyObject]];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [self hideTouchIndicator:[touches anyObject]];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self hideTouchIndicator:[touches anyObject]];
}


#pragma mark -- private messages

-(void)drawAxis{
    
    //Draw Y Direction
    
    [self drawYAxis];
    [self drawXAxis];
    
    //Draw X Direction
}

-(void)drawYAxis{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    
    NSInteger yIndex=0;
    static CGFloat dashPatthern[]={4,1};
    //Draw y texts
    for (NSString*ytext in self.yTextArray) {
        
        CGSize sz=[ytext sizeWithAttributes:nil];
        CGFloat left=self.edgeInsets.left-sz.width-5;
        CGFloat top=CGRectGetHeight(self.frame)-self.edgeInsets.bottom-(self.edgeInsets.bottom+self.yStepLength*yIndex-sz.height/2);
        CGRect rect=CGRectMake(left, top, sz.width, sz.height);
        [ytext drawInRect:rect withAttributes:nil];
        
        CGPoint linePoint;
        linePoint.x=self.edgeInsets.left;
        linePoint.y=CGRectGetHeight(self.frame)-self.edgeInsets.bottom-yIndex*self.yStepLength;
        
        [UIColor colorWithWhite:0.9 alpha:1.0];
        CGContextSetLineDash(context, 0, dashPatthern, 2);
        CGContextMoveToPoint(context, linePoint.x, linePoint.y);
        //CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds)-self.edgeInsets.right, CGRectGetMidY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds)-self.edgeInsets.right, linePoint.y);
        
        CGContextStrokePath(context);
        
        yIndex++;
    }
    
    CGContextRestoreGState(context);
}

-(void)drawXAxis{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    
    
    NSInteger xIndex=0;
    for (NSString*xtext in self.xTextArray){
        CGSize sz=[xtext sizeWithAttributes:nil];
        CGFloat left=self.xStepLength*xIndex-sz.width/2+self.edgeInsets.left;
        CGFloat top=CGRectGetHeight(self.bounds)-self.edgeInsets.bottom;
        CGRect rect=CGRectMake(left, top, sz.width, sz.height);
        [xtext drawInRect:rect withAttributes:nil];
        xIndex++;
    }
    
    CGContextRestoreGState(context);
    
}


-(void)drawValuePoints{
    
    NSInteger xIndex=0;
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, DefaultValueLineWidth);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    
    CGPoint lastPoint=CGPointMake(MAXFLOAT,MAXFLOAT);
    for (NSNumber* valueNum in self.valueArray) {
        CGFloat floatValue=[valueNum floatValue];
        CGFloat yPos=[self pointYPosition:floatValue];
        CGFloat xPos=[self pointXPosition:xIndex];
        CGPoint thisPoint=CGPointMake(xPos,yPos);
        NSValue*pointValue=[NSValue valueWithCGPoint:thisPoint];
        [self.valuePointArray addObject:pointValue];
        if (lastPoint.x!=MAXFLOAT) {
            CGContextAddLineToPoint(context, xPos, yPos);
            CGContextStrokePath(context);
            
        }
        CGRect pointRect=CGRectMake(xPos-5, yPos-5, 10, 10);
        CGContextFillEllipseInRect(context, pointRect);
        //CGContextShowTextAtPoint
        lastPoint=thisPoint;
        CGContextMoveToPoint(context, xPos, yPos);

        xIndex++;
    }
    
    CGContextRestoreGState(context);
}

-(CGFloat)pointYPosition:(CGFloat)value{
    NSAssert(self.maxValue>self.minValue, @"Max and Min value are not expected the same value");
    CGFloat ratio=(value-self.minValue)/(self.maxValue-self.minValue);
    CGFloat height=CGRectGetHeight(self.frame)-([yValueArray count]-1)*self.yStepLength*ratio-self.edgeInsets.bottom;
    return  height;
}

-(CGFloat)pointXPosition:(NSInteger)xIndex{
    return xIndex*self.xStepLength+self.edgeInsets.left;
}
-(void)customInit{
    self.edgeInsets=UIEdgeInsetsMake(20, 20, 20, 20);
    
    self.yStepLength=DefaultYStepLength;
    self.xStepLength=DefaultXStepLength;
    self.maxValue=DefaultMaxValue;
    self.minValue=DefaultMinValue;
    
    lastInfoViewIndex=-1;
    lastInfoPoint=CGPointMake(-1, -1);
    
    self.infoView=[[InfoView alloc]initWithFrame:CGRectZero];
    self.infoView.alpha=0;
    [self addSubview:self.infoView];
    
    self.valuePointArray=[[NSMutableArray alloc]init];
}

-(void)showTouchIndicator:(UITouch*)touch{
    

    if ([self.valueArray count]==0) {
        self.infoView.alpha=0;
        return;
    }
    NSInteger closePointIndex=[self closeValuePointIndex:[touch locationInView:self]];

    self.infoView.alpha=1;
    if (lastInfoViewIndex==closePointIndex) {
        return;
    }

    lastInfoViewIndex=closePointIndex;
    NSValue*ptValue=[self.valuePointArray objectAtIndex:lastInfoViewIndex];
    CGPoint tapPoint=[ptValue CGPointValue];
    if (0>tapPoint.x||0>tapPoint.y) {
        self.infoView.alpha=0;
        return;
    }
    
    self.infoView.tapPoint=tapPoint;
    NSNumber*valueNumber=[self.valueArray objectAtIndex:lastInfoViewIndex];
    
    self.infoView.infoLabel.text=[valueNumber stringValue];
    [self.infoView sizeToFit];
    [self.infoView setNeedsLayout];
    [self.infoView setNeedsDisplay];
   
}
-(void)hideTouchIndicator:(UITouch*)touch{
    self.infoView.alpha=0;
}

-(CGPoint)nearestPoint:(CGPoint)point{
    CGPoint result=CGPointMake(MAXFLOAT, MAXFLOAT);
    CGFloat distance=MAXFLOAT;
    for (NSValue *ptValue in self.valuePointArray) {
        CGPoint thisPoint=[ptValue CGPointValue];
        CGFloat thisDistance=fabsf(point.x-thisPoint.x);
        if (thisDistance<distance) {
            distance=thisDistance;
            result=thisPoint;
        }
    }
    return result;
}

-(CGFloat)distanceBetweenPoints:(CGPoint)pt1 point2:(CGPoint)pt2{
    CGFloat distance=sqrtf(powf(pt1.x-pt1.y, 2)+powf(pt1.y-pt2.y, 2));
    return distance;
    
}

-(NSInteger)closeValuePointIndex:(CGPoint)point{
    
    CGFloat dist=MAXFLOAT;
    NSInteger resultIndex=-1;
    NSInteger thisIndex=0;
    for (NSValue*ptValue in self.valuePointArray) {
        CGPoint thisPoint=[ptValue CGPointValue];
        CGFloat thisDist=fabsf(thisPoint.x-point.x);
        if (dist>thisDist) {
            dist=thisDist;
            resultIndex=thisIndex;
        }
        thisIndex++;
    }
    return resultIndex;
}

@end
