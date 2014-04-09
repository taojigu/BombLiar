//
//  TargetPageParser.m
//  BombLiar
//
//  Created by VooleDev6 on 14-4-9.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "TargetPageParser.h"
#import "ElementsContainer.h"
#import "Target.h"

@implementation TargetPageParser


-(ElementsContainer*)parse:(NSData*)data{
    ElementsContainer*result=[[ElementsContainer alloc]init];
    for (NSInteger ti=0; ti<12; ti++) {
        Target*tgt=[Target fakeTarget:ti];
        [result.elementArray addObject:tgt];
        
    }
    result.pageIndex=0;
    
    
    return result;

}
@end
