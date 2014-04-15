//
//  Target.m
//  BombLiar
//
//  Created by VooleDev6 on 14-4-9.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "Target.h"

@implementation Target

@synthesize targetId;
@synthesize name;
@synthesize urlString;
@synthesize introduction;
@synthesize detailText;

+(Target*)fakeTarget:(NSInteger)targetIndex{
    Target*result=[[Target alloc]init];
    
    result.targetId=[NSString stringWithFormat:@"t%i",targetIndex];
    result.name=SampleTargetName;
    result.urlString=RealTargetURLString;
    result.introduction=SampleTargetIntroduction;
    result.detailText=[NSString stringWithFormat:@"The detail text of %@",result.name];
    
    return result;
}

@end
