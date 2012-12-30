//
//  RWMainViewController.m
//  Rockwell
//
//  Created by Tyler Hall on 12/27/12.
//  Copyright (c) 2012 Click On Tyler. All rights reserved.
//

#import "RWMainViewController.h"

@interface RWMainViewController ()

@end

@implementation RWMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _switchUpdateLocation.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"updateLocation"];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (IBAction)logout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"updateLocation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)updateLocationChanged:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:_switchUpdateLocation.on forKey:@"updateLocation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
