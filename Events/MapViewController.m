//
//  MapViewController.m
//  Events
//
//  Created by Steven Van der merwe on 2013/05/01.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import "MapViewController.h"
#import "EventAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    // 1
    CLLocationCoordinate2D zoomLocation;
//    zoomLocation.latitude = -29.6167;//39.281516;
//    zoomLocation.longitude= 30.3833;//-76.580806;
    NSLog(@"latitude: %@",self.latitude);
    NSLog(@"longitude: %@",self.longitude);
    zoomLocation.latitude = [self.latitude floatValue];
    zoomLocation.longitude = [self.longitude floatValue];
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
//    MKCoordinateRegion viewRegion = MKCoordinateForMapPoint([MKMapPointMake(zoomLocation.latitude, zoomLocation.longitude)]);
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(zoomLocation, MKCoordinateSpanMake(zoomLocation.latitude, zoomLocation.longitude));
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude.doubleValue;
    coordinate.longitude = self.longitude.doubleValue;
//    MyLocation *annotation = [[MyLocation alloc] initWithName:crimeDescription address:address coordinate:coordinate] ;
    
    EventAnnotation *annotation = [[EventAnnotation alloc] initWithCoordinate:coordinate];
    annotation.title = self.eventTitle;
    [_mapView addAnnotation:annotation];
//}

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

@end
