//
//  ElementsContainer.h
//  HeartTrace
//
//  Created by user on 13-12-27.
//  Copyright (c) 2013年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ElementsContainer : NSObject

@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,retain)NSMutableArray*elementArray;


@end
