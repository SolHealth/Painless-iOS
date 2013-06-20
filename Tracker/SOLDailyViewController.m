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

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.transitioningDelegate = [(SOLAppDelegate *)[UIApplication sharedApplication].delegate transitioningManager];
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

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
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
