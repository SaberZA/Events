//
//  EventCell.h
//  Events
//
//  Created by Steven Van der merwe on 2013/04/25.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageViewCustom;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *subTitle;


@end
