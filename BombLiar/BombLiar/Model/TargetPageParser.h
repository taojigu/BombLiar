//
//  TargetPageParser.h
//  BombLiar
//
//  Created by VooleDev6 on 14-4-9.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ElementsContainer;

@interface TargetPageParser : NSObject{
    @private
    ElementsContainer*result;
}


-(ElementsContainer*)parse:(NSData*)data;
@end
