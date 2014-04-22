//
//  LineChartView.h
//  CharTest
//
//  Created by VooleDev6 on 14-4-16.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChartView : UIView{
    
    
}

@property(nonatomic,strong)NSArray* yTextArray;
@property(nonatomic,strong)NSArray* xTextArray;
@property(nonatomic,strong)NSArray*yValueArray;
@property(nonatomic,strong)NSArray*valueArray;
@property(nonatomic,assign)UIEdgeInsets edgeInsets;

@property(nonatomic,assign)CGFloat yStepLength;
@property(nonatomic,assign)CGFloat xStepLength;
@property(nonatomic,assign)CGFloat maxValue;
@property(nonatomic,assign)CGFloat minValue;

@end
