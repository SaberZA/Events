//
//  EventCell.m
//  Events
//
//  Created by Steven Van der merwe on 2013/04/25.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell
@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize imageViewCustom = _imageViewCustom;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
