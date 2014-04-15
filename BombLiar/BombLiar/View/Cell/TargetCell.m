//
//  TargetCell.m
//  BombLiar
//
//  Created by VooleDev6 on 14-4-10.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "TargetCell.h"

@implementation TargetCell

@synthesize nameLabel;
@synthesize introductionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
