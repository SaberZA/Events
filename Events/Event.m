//
//  Event.m
//  Events
//
//  Created by Steven Van der merwe on 2013/04/22.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import "Event.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation Event

@synthesize title = _title;
@synthesize startTime = _startTime;
@synthesize venueName = _venueName;
@synthesize venueAddress = _venueAddress;
@synthesize city = _city;
@synthesize region = _region;
@synthesize description = _description;
@synthesize endTime = _endTime;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize eventUrl = _eventUrl;

@synthesize image = _image;
@synthesize imageUrl = _imageUrl;
@synthesize parentTableView = _parentTableView;

-(NSString *) description{
    return [NSString stringWithFormat:@"%@ - %@",_title,_venueName];
}

-(void) setImageUrl:(NSURL *)imageUrl
{
    _imageUrl = imageUrl;
    [self loadImageAsync:self.imageUrl];
}

-(void) loadImageAsync: (NSURL *)imageUrl
{    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:imageUrl
                     options:0
                    progress:^(NSUInteger receivedSize, long long expectedSize)
     {
         // progression tracking code
     }
     
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
     {
         if (image)
         {
             // do something with image
             
             //UIImage *strImage = [image stretchableImageWithLeftCapWidth:15 topCapHeight:13];
             
             
             
             self.image = image;
             [self.parentTableView reloadData];
         }
     }];

}

@end
