//
//  Target.h
//  BombLiar
//
//  Created by VooleDev6 on 14-4-9.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target : NSObject{
    
}


@property(nonatomic,strong)NSString*targetId;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*urlString;
@property(nonatomic,strong)NSString*introduction;

+(Target*)fakeTarget:(NSInteger)targetIndex;


@end
