//
//  RWCheckInTableViewController.m
//  Rockwell
//
//  Created by Tyler Hall on 4/13/14.
//  Copyright (c) 2014 Click On Tyler. All rights reserved.
//

#import "RWCheckInTableViewController.h"
#import "LocationManager.h"
#import "GTMHTTPFetcher.h"
#import "JSON.h"
#import "RWCheckInTableViewCell.h"

@interface RWCheckInTableViewController ()

@property (nonatomic, strong) NSArray *venues;

@end

@implementation RWCheckInTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Check-In";
    [self loadVenues];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWCheckInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RWCheckInTableViewCell" forIndexPath:indexPath];
    NSDictionary *venue = self.venues[indexPath.row];
    cell.nameLabel.text = venue[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSDictionary *venue = self.venues[indexPath.row];

    NSString *url_string = [NSString stringWithFormat:@"%@/api.php?action=checkin&token=%@&latitude=%f&longitude=%f&id=%@",
                            [[NSUserDefaults standardUserDefaults] valueForKey:@"url"],
                            [[NSUserDefaults standardUserDefaults] valueForKey:@"token"],
                            [LocationManager sharedManager].manager.location.coordinate.latitude,
                            [LocationManager sharedManager].manager.location.coordinate.longitude,
                            venue[@"id"]];
    NSURL *url = [NSURL URLWithString:url_string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if(!error) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Post Check-In" message:@"An error occurred. Please double-check your username, password, and URL." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (void)loadVenues
{
    NSString *url_string = [NSString stringWithFormat:@"%@/api.php?action=venues&token=%@&latitude=%f&longitude=%f",
                            [[NSUserDefaults standardUserDefaults] valueForKey:@"url"],
                            [[NSUserDefaults standardUserDefaults] valueForKey:@"token"],
                            [LocationManager sharedManager].manager.location.coordinate.latitude,
                            [LocationManager sharedManager].manager.location.coordinate.longitude];
    NSURL *url = [NSURL URLWithString:url_string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if(!error) {
            NSString *json_string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            self.venues = [json_string JSONValue];
            NSLog(@"----%@", self.venues);
            [self.tableView reloadData];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Fetch Venues" message:@"An error occurred. Please double-check your username, password, and URL." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

@end
