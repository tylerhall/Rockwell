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

    bgTask = 0;
    
	self.manager = [[CLLocationManager alloc] init];
	self.manager.delegate = self;
	[self.manager startUpdatingLocation];
    [self.manager startMonitoringSignificantLocationChanges];
    
    
	return self;
}

+ (LocationManager *)sharedManager {
	if(_me == nil) {
		_me = [[LocationManager alloc] init];
	}
	return _me;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    BOOL isInBackground = NO;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        isInBackground = YES;
    }

	if(!self.hasFoundInitialLocation) {
        self.hasFoundInitialLocation = YES;
		[[NSNotificationCenter defaultCenter] postNotificationName:@"LM_FIRST_LOCATION" object:nil];
        NSLog(@"LM_FIRST_LOCATION");
	}
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LM_DID_UPDATE" object:nil];
    NSLog(@"LM_DID_UPDATE");
    
    if(isInBackground) {
        [self.manager startMonitoringSignificantLocationChanges];
        [self sendBackgroundLocationToServer:[locations lastObject]];
    }
}

- (void)sendBackgroundLocationToServer:(CLLocation *)location {
    NSLog(@"LM_BACKGROUND");

    bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:
              ^{
                  [[UIApplication sharedApplication] endBackgroundTask:bgTask];
              }];

    // Send position to server synchronously...
    NSLog(@"Location: %f, %f", location.coordinate.latitude, location.coordinate.longitude);
    
    if(bgTask != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
         bgTask = UIBackgroundTaskInvalid;
    }
}

@end
