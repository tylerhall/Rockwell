//
//  NetworkSpinner.m
//  Tennessee Traffic
//
//  Created by Tyler Hall on 8/15/10.
//  Copyright 2010 Click On Tyler, LLC. All rights reserved.
//

#import "NetworkSpinner.h"
#import "GTMHTTPFetcher.h"

static NetworkSpinner *_me = nil;

@implementation NetworkSpinner

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
	self = [super init];
	_count = 0;
	_hasError = NO;

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(realQueue) name:kGTMHTTPFetcherStartedNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(realDequeue) name:kGTMHTTPFetcherStoppedNotification object:nil];
	
	return self;
}

+ (NetworkSpinner *)sharedSpinner {
	if(_me == nil) {
		_me = [[NetworkSpinner alloc] init];
	}
	return _me;
}

- (void)realQueue {
	_count++;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)realDequeue {
	_count--;
	if(_count <= 0) {
		_count = 0;
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}
}

+ (void)queue {
	[[NetworkSpinner sharedSpinner] realQueue];
}

+ (void)dequeue {
	[[NetworkSpinner sharedSpinner] realDequeue];
}

- (void)realHasError {
	if(_hasError) return;
	_hasError = YES;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Network Error", nil) message:NSLocalizedString(@"Could not connect to the network. Please try again.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
	[alert show];
}
	
+ (void)networkError {
	[[NetworkSpinner sharedSpinner] realHasError];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	_hasError = NO;
}

- (void)nop {
	
}

@end
