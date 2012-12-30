//
//  RWLoginViewController.h
//  Rockwell
//
//  Created by Tyler Hall on 12/27/12.
//  Copyright (c) 2012 Click On Tyler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWLoginViewController : UITableViewController {
    IBOutlet UITextField *_txtUsername;
    IBOutlet UITextField *_txtPassword;
    IBOutlet UITextField *_txtURL;
    
    BOOL _firstAppearance;
}

- (void)login;

@end
