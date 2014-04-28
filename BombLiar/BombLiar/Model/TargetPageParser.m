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
#import "GDataXMLNode.h"


#define TotalAttriIndex 0
#define PageIndexAttriIndex 1
#define PageSizeAttriIndex 2

#define TargetIDAttriIndex 0
#define TargetNameChildIndex 0
#define URLStringChildIndex 1
#define IntroductionChildIndex 2
#define DetailTextChildIndex 3


@implementation TargetPageParser


-(ElementsContainer*)parse:(NSData*)data{
    
    result=[[ElementsContainer alloc]init];
    GDataXMLDocument*doc=[[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    GDataXMLElement*rootElement=doc.rootElement;
    [self parseElementContainerHeader:rootElement];
    
    GDataXMLElement*targeArrayNode=(GDataXMLElement*)rootElement.children[0];
    [self parseTargetArray:targeArrayNode];
    return result;

}

-(void)parseElementContainerHeader:(GDataXMLElement*)element{
    NSAssert(nil!=element, @"The container header should not be nil");
    NSString*totalString=[[element.attributes objectAtIndex:TotalAttriIndex]stringValue];
    result.count=[totalString intValue];
    NSString*pageIndexString=[[element.attributes objectAtIndex:PageIndexAttriIndex]stringValue];
    result.pageIndex=[pageIndexString intValue];
    NSString*pageSizeString=[[element.attributes objectAtIndex:PageSizeAttriIndex]stringValue];
    result.pageSize=[pageSizeString intValue];
    
}

-(void)parseTargetArray:(GDataXMLElement*)arrayNode{
    NSAssert(nil!=arrayNode, @"array node should not be nil");
    for (GDataXMLElement*childElement in arrayNode.children) {
        Target*target=[self parseTarget:childElement];
        [result.elementArray addObject:target];
    }
    
}

-(Target*)parseTarget:(GDataXMLElement*)targetNode{
    Target*target=[[Target alloc]init];
    NSAssert([targetNode.attributes count]>0&&[targetNode.children count]>0, @"Invaliate target node");
    NSArray*attriArray=targetNode.attributes;
    target.targetId=[attriArray objectAtIndex:TargetIDAttriIndex];
    NSArray*childAraay=targetNode.children;
    target.name=[[childAraay objectAtIndex:TargetNameChildIndex] stringValue];
    target.introduction=[[childAraay objectAtIndex:IntroductionChildIndex]stringValue];
    target.detailText=[[childAraay objectAtIndex:DetailTextChildIndex]stringValue];
    target.urlString=[[childAraay objectAtIndex:URLStringChildIndex]stringValue];
    
    return target;
}
@end
