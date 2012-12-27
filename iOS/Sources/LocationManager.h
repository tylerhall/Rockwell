//
//  LocationManager.h
//  Exterra
//
//  Created by Tyler Hall on 12/3/12.
//  Copyright (c) 2012 Tyler Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *manager;
@property (assign) BOOL hasFoundInitialLocation;

+ (LocationManager *)sharedManager;

@end
