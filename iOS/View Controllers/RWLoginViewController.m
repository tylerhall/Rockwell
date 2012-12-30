//
//  RWLoginViewController.m
//  Rockwell
//
//  Created by Tyler Hall on 12/27/12.
//  Copyright (c) 2012 Click On Tyler. All rights reserved.
//

#import "RWLoginViewController.h"
#import "RWMainViewController.h"
#import "GTMHTTPFetcher.h"
#import "JSON.h"

@interface RWLoginViewController ()

@end

@implementation RWLoginViewController

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
    _txtUsername.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    _txtPassword.text = @"";
    _txtURL.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"url"];
    _firstAppearance = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    if(_firstAppearance) {
        if([[NSUserDefaults standardUserDefaults] valueForKey:@"token"]) {
            RWMainViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNavigationController"];
            vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:vc animated:NO completion:nil];
        }
    }
    _firstAppearance = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self login];
    }
    
    if(indexPath.section == 2) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/tylerhall/Rockwell"]];
    }
}

- (void)login {
    NSString *url_string = [NSString stringWithFormat:@"%@/api.php?action=login&username=%@&password=%@", _txtURL.text, _txtUsername.text, _txtPassword.text];
    NSURL *url = [NSURL URLWithString:url_string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        BOOL failed = YES;
        if(!error) {
            NSString *json_string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dict = [json_string JSONValue];
            if(dict) {
                NSString *token = [dict valueForKey:@"token"];
                if(token) {
                    failed = NO;
                    [[NSUserDefaults standardUserDefaults] setValue:_txtUsername.text forKey:@"username"];
                    [[NSUserDefaults standardUserDefaults] setValue:_txtURL.text forKey:@"url"];
                    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    RWMainViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNavigationController"];
                    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                    [self presentViewController:vc animated:YES completion:nil];
                }
            }
        }
        
        if(failed) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Login" message:@"An error occurred. Please double-check your username, password, and URL." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

@end
