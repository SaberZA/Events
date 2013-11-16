//
//  Event.h
//  Events
//
//  Created by Steven Van der merwe on 2013/04/22.
//  Copyright (c) 2013 Steven Van der merwe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Event : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSDate *startTime;
@property (nonatomic, copy) NSString *venueName;
@property (nonatomic, copy) NSString *venueAddress;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSDate *endTime;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *eventUrl;


@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSURL *imageUrl;

@property (assign, nonatomic) UITableView *parentTableView;

-(void) loadImageAsync: (NSURL *)imageUrl;

@end
