//
//  RWMapLocationViewController.m
//  Rockwell
//
//  Created by Tyler Hall on 4/13/14.
//  Copyright (c) 2014 Click On Tyler. All rights reserved.
//

#import "RWMapLocationViewController.h"
#import "GTMHTTPFetcher.h"
#import "JSON.h"

@interface RWMapLocationViewController ()

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSArray *checkins;

@end

@implementation RWMapLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCheckins];
}

- (void)loadCheckins
{
    // Eventually this will load all checkins for the visible portion of the map.
    // The below code is just stubbed out for now.
    NSString *url_string = [NSString stringWithFormat:@"%@/api.php?action=checkins&token=%@",
                            [[NSUserDefaults standardUserDefaults] valueForKey:@"url"],
                            [[NSUserDefaults standardUserDefaults] valueForKey:@"token"]];
    NSURL *url = [NSURL URLWithString:url_string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if(!error) {
            NSString *json_string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            self.checkins = [json_string JSONValue];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Fetch Check-Ins" message:@"An error occurred. Please double-check your username, password, and URL." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

@end
