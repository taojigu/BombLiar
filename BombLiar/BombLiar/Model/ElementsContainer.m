//
//  ElementsContainer.m
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import "ElementsContainer.h"

@implementation ElementsContainer

@synthesize pageIndex;
@synthesize pageSize;
@synthesize count;
@synthesize elementArray;


-(id)init{
    self=[super init];
    NSMutableArray*tmpArray=[[NSMutableArray alloc]init];
    self.elementArray=tmpArray;

    return self;
}


@end
