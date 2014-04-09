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

+(Target*)fakeTarget:(NSInteger)targetIndex{
    Target*result=[[Target alloc]init];
    
    return result;
}

@end
