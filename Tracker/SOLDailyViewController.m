//
//  SOLViewController.m
//  Painless
//
//  Created by Janardan Yri on 6/18/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLDailyViewController.h"

#import "SOLTransitioningManager.h"
#import "SOLAppDelegate.h"

@interface SOLDailyViewController ()

@end

@implementation SOLDailyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.transitioningDelegate = [(SOLAppDelegate *)[UIApplication sharedApplication].delegate transitioningManager];
    self.modalPresentationStyle = UIModalPresentationCustom;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zoomOut
{
    id nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarViewController"];
    [self presentViewController:nextViewController animated:YES completion:nil];
}

@end
