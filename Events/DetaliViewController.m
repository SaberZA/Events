//
//  DetaliViewController.m
//  Events
//
//  Created by Steven Van der merwe on 2013/04/26.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import "DetaliViewController.h"
#import "MapViewController.h"

@interface DetaliViewController ()

@end

@implementation DetaliViewController
@synthesize event = _event;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMap"]) {
        MapViewController *mvc = (MapViewController *)[segue destinationViewController];
        if (mvc) {
            mvc.latitude = self.event.latitude;
            mvc.longitude = self.event.longitude;
            mvc.eventTitle = self.event.title;
        }
        
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    _DescriptionTextView.text = self.event.description;
    _RegionLabel.text = self.event.region;
    _CityLabel.text = self.event.city;
    _ImageEvent.image = self.event.image;
    _VenueLabel.text = self.event.venueName;
    _TitleLabel.text = self.event.title;
    
    [_TitleLabel sizeToFit];
    [_RegionLabel sizeToFit];
    [_CityLabel sizeToFit];
    [_VenueLabel sizeToFit];
    
    
//    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.scrollView.frame.size.height);
    
//    
//    CGFloat lastYPositionComponent = _DescriptionTextView.frame.origin.y;
//    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+lastYPositionComponent);
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark set detail items



-(void)setEventTitle: (NSString *)title
{
    _eventTitle = title;
    [self configureView];
}


- (IBAction)showMapClicked:(UIButton *)sender forEvent:(UIEvent *)event {
}

-(void)configureView
{
    if (self.eventTitle) {
        self.TitleLabel.text = self.eventTitle;
    }
    
}

@end
