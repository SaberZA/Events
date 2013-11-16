//
//  DetaliViewController.h
//  Events
//
//  Created by Steven Van der merwe on 2013/04/26.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface DetaliViewController : UIViewController
@property (nonatomic,strong) Event *event;

@property (strong, nonatomic) NSString *eventTitle;

@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *VenueLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ImageEvent;
@property (strong, nonatomic) IBOutlet UILabel *CityLabel;
@property (strong, nonatomic) IBOutlet UILabel *RegionLabel;
@property (strong, nonatomic) IBOutlet UITextView *DescriptionTextView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)showMapClicked:(UIButton *)sender forEvent:(UIEvent *)event;

-(void)configureView;
-(void)setEventTitle: (NSString *)title;

@end
