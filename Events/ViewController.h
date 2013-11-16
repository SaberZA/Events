//
//  ViewController.h
//  Events
//
//  Created by Steven Van der merwe on 2013/04/22.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "CoreLocation/CoreLocation.h"


@interface ViewController : UITableViewController <NSXMLParserDelegate, CLLocationManagerDelegate>
@property (nonatomic,strong) NSXMLParser *xmlParser;
@property (nonatomic,strong) Event *currentEvent;
@property (nonatomic,strong) NSMutableString *currentString;
@property (nonatomic,assign) BOOL storeCharacters;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,strong) NSMutableArray *eventsArray;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,assign) BOOL storeImage;
@property (nonatomic,strong) NSMutableDictionary *imageDictionary;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLLocation *currentLocation;


- (void) finishedCurrentEvent:(Event *)e;
-(void) startLocationManager;
-(void) stopLocationManager;
-(void)reverseGeocode:(CLLocation *)location;
- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
@end
