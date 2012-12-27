//
//  LocationManager.m
//  Exterra
//
//  Created by Tyler Hall on 12/3/12.
//  Copyright (c) 2012 Tyler Hall. All rights reserved.
//

#import "LocationManager.h"

static LocationManager *_me;

@implementation LocationManager

- (id)init {
	self = [super init];
	self.manager = [[CLLocationManager alloc] init];
	self.manager.delegate = self;
	[self.manager startUpdatingLocation];
	return self;
}

+ (LocationManager *)sharedManager {
	if(_me == nil) {
		_me = [[LocationManager alloc] init];
	}
	return _me;
}

- (void)locationManager:(CLLocationManager *)theManager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	if(!self.hasFoundInitialLocation) {
        self.hasFoundInitialLocation = YES;
		[[NSNotificationCenter defaultCenter] postNotificationName:@"FIRST_LOCATION" object:nil];
        // NSLog(@"FIRST_LOCATION");
	}
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LOCATION_DID_UPDATE" object:nil];
    // NSLog(@"LOCATION_DID_UPDATE");
}

@end
