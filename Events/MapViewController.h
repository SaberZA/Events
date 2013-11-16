//
//  MapViewController.h
//  Events
//
//  Created by Steven Van der merwe on 2013/05/01.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface MapViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *eventTitle;

@end
