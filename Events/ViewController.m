//
//  ViewController.m
//  Events
//
//  Created by Steven Van der merwe on 2013/04/22.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import "ViewController.h"
#import "EventCell.h"
#import "DetaliViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController
@synthesize xmlParser = _xmlParser;
@synthesize currentEvent = _currentEvent;
@synthesize currentString = _currentString;
@synthesize storeCharacters = _storeCharacters;
@synthesize dateFormatter = _dateFormatter;
@synthesize eventsArray = _eventsArray;
@synthesize locationManager = _locationManager;
@synthesize currentLocation = _currentLocation;
@synthesize city = _city;
@synthesize storeImage = _storeImage;
@synthesize imageDictionary = _imageDictionary;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self startLocationManager];   
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.locale = [NSLocale currentLocale];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    self.imageDictionary = [[NSMutableDictionary alloc] init];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEvent"]) {
        DetaliViewController *dvc = (DetaliViewController *)[segue destinationViewController];        
        [dvc setEvent:[self.eventsArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]]];
        
        
    }
}

-(void) parseXmlWithLocation:(CLLocation *)location
{
    NSString *stringURL;

    
    if (location)
    {
        stringURL = [NSString stringWithFormat: @"http://api.eventful.com/rest/events/search?app_key=DGnfGmx9Hv86WwZs&where=%1.6f,%1.6f&within=100&category=music&date=future",location.coordinate.latitude,location.coordinate.longitude];
//        NSLog(@"%@",stringURL);        
    }
    else
    {
        stringURL = [NSString stringWithFormat: @"http://api.eventful.com/rest/events/search?location=South+Africa&category=music&date=future&app_key=DGnfGmx9Hv86WwZs"];
        self.navigationItem.title = @"South Africa";
    }
    
    
    self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString: stringURL]];
    
    self.xmlParser.delegate = self;
    self.eventsArray = [NSMutableArray array];
    self.currentString = [NSMutableString string];
    
    if ([self.xmlParser parse])
        NSLog(@"XML Parsed");
    else
        NSLog(@"Failed to Parse");

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Parser Delegate

static NSString *kName_Event = @"event";
static NSString *kName_Title = @"title";
static NSString *kName_StartTime = @"start_time";
static NSString *kName_VenueName = @"venue_name";
static NSString *kName_Image = @"image";
static NSString *kName_Url = @"url";
//static NSString *kName_Thumb = @"thumb";
static NSString *kName_VenueAddress = @"venue_address";
static NSString *kName_City = @"city_name";
static NSString *kName_Region = @"region_name";
static NSString *kName_Description = @"description";
static NSString *kName_EndTime = @"stop_time";
static NSString *kName_Longitude = @"longitude";
static NSString *kName_Latitude = @"latitude";
static NSString *kName_EventUrl = @"url";

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"event"]) {
        self.currentEvent = [[Event alloc] init];
        self.storeCharacters = NO;
    }
    else if ([elementName isEqualToString:kName_Title]
             || [elementName isEqualToString:kName_StartTime]
             || [elementName isEqualToString:kName_VenueName]
             || [elementName isEqualToString:kName_VenueAddress]
             || [elementName isEqualToString:kName_City]
             || [elementName isEqualToString:kName_Region]
             || [elementName isEqualToString:kName_Description]
             || [elementName isEqualToString:kName_EndTime]
             || [elementName isEqualToString:kName_Latitude]
             || [elementName isEqualToString:kName_Longitude])
    {
        [self.currentString setString:@""];
        self.storeCharacters = YES;
    }
    
    ///
    /// find a way to handle nested xml
    ///
    if ([elementName isEqualToString:kName_Image]) {
        self.storeImage = YES;
    }
    
    
    
    
    
//    if ([elementName isEqualToString:kName_Thumb]) {
//        self.storeImage = YES;
//    }
    if([elementName isEqualToString:kName_Url] && self.storeImage)
    {
        [self.currentString setString:@""];
        self.storeCharacters = YES;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.storeCharacters)
    {
        [self.currentString appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:kName_Title]) {
        self.currentEvent.title = _currentString;
    }
    if ([elementName isEqualToString:kName_StartTime]) {
        self.currentEvent.startTime = [self.dateFormatter dateFromString: _currentString];
    }
    if ([elementName isEqualToString:kName_VenueName]) {
        self.currentEvent.venueName = _currentString;
    }
    if ([elementName isEqualToString:kName_VenueAddress]) {
        self.currentEvent.venueAddress = _currentString;
    }
    if ([elementName isEqualToString:kName_City]) {
        self.currentEvent.city = _currentString;
    }
    if ([elementName isEqualToString:kName_Region]) {
        self.currentEvent.region = _currentString;
    }
    if ([elementName isEqualToString:kName_Description]) {
        self.currentEvent.description = _currentString;
    }
    if ([elementName isEqualToString:kName_EndTime]) {
        self.currentEvent.endTime = [self.dateFormatter
                                     dateFromString:_currentString];
    }
    if ([elementName isEqualToString:kName_Latitude]) {
        self.currentEvent.latitude = _currentString;
    }
    if ([elementName isEqualToString:kName_Longitude]) {
        self.currentEvent.longitude = _currentString;
    }
    if ([elementName isEqualToString:kName_EventUrl] && !self.storeImage) {
        self.currentEvent.eventUrl = _currentString;
    }
    if ([elementName isEqualToString:kName_VenueName]) {
        self.currentEvent.venueName = _currentString;
    }
    if ([elementName isEqualToString:kName_Event]) {
        [self finishedCurrentEvent: _currentEvent];
    }
    //handle end of image url
    if ([elementName isEqualToString:kName_Url] && self.storeImage) {
        
        NSString *selectedImageUrl = [_currentString stringByReplacingOccurrencesOfString:@"small" withString:@"thumb"];
        NSLog(@"currentURL: %@",selectedImageUrl);
        NSURL *imageURL = [NSURL URLWithString:selectedImageUrl];
        
        self.currentEvent.imageUrl = imageURL;
                
        
        
    }
    
    
    
    
    self.storeCharacters = NO;
}


-(void) finishedCurrentEvent:(Event *)e
{
    e.parentTableView = self.tableView;
    [self.eventsArray addObject:e];
    self.currentEvent = nil;
}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    //Handle error on reading xml    
}

- (void) parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%d",self.eventsArray.count);
    [self.tableView reloadData];
}

#pragma mark
#pragma mark - Table View Data Source

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventsArray.count;
}

-(EventCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventTableViewCell";
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil) {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Event *event = [self.eventsArray objectAtIndex:indexPath.row];
    
    NSLog(@"%@",event);
    
    cell.title.text = event.title;
    cell.subTitle.text = event.venueName;
    
    if (event.image) {
        //UIImage *i = nil;
        //i = [event.image stretchableImageWithLeftCapWidth:10 topCapHeight:15];
        
        cell.imageViewCustom.layer.cornerRadius = 5.0;
        
        cell.imageViewCustom.layer.masksToBounds = YES;
        
        cell.imageViewCustom.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.imageViewCustom.layer.borderWidth = 1.0;
        cell.imageViewCustom.contentMode = UIViewContentModeCenter;
    }
        
        //event.image.leftCapWidth = 25;
        //cell.imageViewCustom.clipsToBounds = YES;
//        CGSize size = CGSizeMake(cell.imageViewCustom.frame.size.width*2, cell.imageViewCustom.frame.size.height*2);
//        cell.imageViewCustom.image = [self imageWithImage:event.image scaledToSize:size];
        cell.imageViewCustom.image = event.image;
    //}
    
    
    
    
    //cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //cell.imageView.clipsToBounds = YES;
    return cell;
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

-(void)startLocationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        _locationManager.distanceFilter = 1000;
        _locationManager.delegate = self;
        //Deprecated in ios6.0 - purpose is now located in the info.plist under the key NSLocationUsageDescription
        //_locationManager.purpose
    }
    
    [_locationManager startUpdatingLocation];
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        [self parseXmlWithLocation:nil];
    }
}

//ios 6.0 method
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    //CLLocation *oldLocation = [locations objectAtIndex:1];
    NSLog(@"latitude %+.6f, longitude %+.6f, accuracy %1.2f, time %d"
          , newLocation.coordinate.latitude
          , newLocation.coordinate.longitude
          , newLocation.horizontalAccuracy
          , abs([newLocation.timestamp timeIntervalSinceNow]));
    
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 10.0) return;
    
    if (newLocation.horizontalAccuracy < 0) return;
    
    if (self.currentLocation == nil && newLocation.horizontalAccuracy <= _locationManager.desiredAccuracy) {
        self.currentLocation = newLocation;
        [self reverseGeocode:newLocation];
        [self parseXmlWithLocation:newLocation];
        
        [self stopLocationManager];
    }
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    if ([error code] != kCLErrorLocationUnknown) {
        [self parseXmlWithLocation:nil];
        [self stopLocationManager];
    }
}

//0741961763
-(void)stopLocationManager
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark Reverse Geocode

-(void) reverseGeocode:(CLLocation *)location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
      {
          if (error) {
              NSLog(@"%@",error);
              return;
          }
          
          if (placemarks) {
              CLPlacemark *placemark = [placemarks lastObject];
              //NSLog(@"%@",placemark);
              
              self.city = [NSString stringWithFormat:@"%@",placemark.locality];
              self.navigationItem.title = self.city;
              NSLog(@"City: %@",placemark.locality);
          }
          else
          {
              
              self.city = [NSString stringWithFormat:@"%@",@"South Africa"];
              self.navigationItem.title = self.city;
          }
      }];
}

@end
