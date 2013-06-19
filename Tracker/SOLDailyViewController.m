//
//  SOLViewController.m
//  Tracker
//
//  Created by Janardan Yri on 6/18/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLDailyViewController.h"

@interface SOLDailyViewController ()

@end

@implementation SOLDailyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zoomOut
{
    [self performSegueWithIdentifier:@"CollectionSegue" sender:nil];
}

@end
