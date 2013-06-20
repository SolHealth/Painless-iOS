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
#import "SOLSleepEntryViewController.h"

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

    [self.muscleButton setTitle:[NSString stringWithFormat:@"%i", abs(self.dailyData.musclePainHundredths / 10)] forState:UIControlStateNormal];
    [self.jointButton setTitle:[NSString stringWithFormat:@"%i", abs(self.dailyData.jointPainHundredths / 10)] forState:UIControlStateNormal];
    [self.headButton setTitle:[NSString stringWithFormat:@"%i", abs(self.dailyData.headPainHundredths / 10)] forState:UIControlStateNormal];
    [self.tactileButton setTitle:[NSString stringWithFormat:@"%i", abs(self.dailyData.tactilePainHundredths / 10)] forState:UIControlStateNormal];
    [self.brainFogButton setTitle:[NSString stringWithFormat:@"%i", abs(self.dailyData.musclePainHundredths / 10)] forState:UIControlStateNormal];
    [self.sleepButton setTitle:[NSString stringWithFormat:@"%i", abs(self.dailyData.sleepMinutes / 60)] forState:UIControlStateNormal];

    for (UIButton *button in @[self.muscleButton, self.jointButton, self.headButton, self.tactileButton, self.brainFogButton]) {
        button.layer.cornerRadius = 39;
        button.backgroundColor = [UIColor colorWithRed:247 / 255.f green:118 / 255.f blue:123 / 255.f alpha:1];
    }

    self.sleepButton.layer.cornerRadius = 36;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
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

- (IBAction)sleepButtonPressed
{
    SOLSleepEntryViewController *sleepEntrier = [self.storyboard instantiateViewControllerWithIdentifier:@"SleepEntryViewController"];
    sleepEntrier.modalPresentationStyle = UIModalPresentationCustom;
    sleepEntrier.transitioningDelegate = self.transitioningDelegate;
    sleepEntrier.completionBlock = ^(BOOL success, NSInteger selection) {
        if (success) {
            self.dailyData.sleepMinutes = selection * 60;
            [self.view setNeedsDisplay];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:sleepEntrier animated:YES completion:nil];
}

@end
