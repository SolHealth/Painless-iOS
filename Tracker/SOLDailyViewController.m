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
#import "SOLDaysTracker.h"
#import "SOLDailyData.h"

@interface SOLDailyViewController ()

@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *dayButton;

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

    self.prevButton.imageView.contentMode = UIViewContentModeCenter;
    self.nextButton.imageView.contentMode = UIViewContentModeCenter;
    NSString *dayText = [self.daysTracker descriptionTextForDayIndex:[self.daysTracker dayIndexForDay:self.dailyData.day]];
    [self.dayButton setTitle:dayText forState:UIControlStateNormal];
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
