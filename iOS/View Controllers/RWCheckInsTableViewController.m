//
//  RWCheckInsTableViewController.m
//  Rockwell
//
//  Created by Tyler Hall on 4/13/14.
//  Copyright (c) 2014 Click On Tyler. All rights reserved.
//

#import "RWCheckInsTableViewController.h"
#import "LocationManager.h"
#import "GTMHTTPFetcher.h"
#import "JSON.h"
#import "RWCheckInTableViewCell.h"

@interface RWCheckInsTableViewController ()

@property (nonatomic, strong) NSArray *checkins;

@end

@implementation RWCheckInsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Check-Ins";
    [self loadCheckins];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.checkins count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RWCheckInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RWCheckInTableViewCell" forIndexPath:indexPath];
    NSDictionary *checkin = self.checkins[indexPath.row];
    cell.nameLabel.text = checkin[@"name"];
    cell.dateLabel.text = checkin[@"dt"];
    return cell;
}

- (void)loadCheckins
{
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
            [self.tableView reloadData];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Fetch Check-Ins" message:@"An error occurred. Please double-check your username, password, and URL." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

@end
