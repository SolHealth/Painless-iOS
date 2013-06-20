//
//  SOLViewController.h
//  Painless
//
//  Created by Janardan Yri on 6/18/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SOLDaysTracker, SOLDailyData;

@interface SOLDailyViewController : UIViewController

@property (nonatomic, strong) SOLDaysTracker *daysTracker;
@property (nonatomic, strong) SOLDailyData *dailyData;

@property (weak, nonatomic) IBOutlet UIButton *muscleButton;
@property (weak, nonatomic) IBOutlet UIButton *jointButton;
@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet UIButton *tactileButton;
@property (weak, nonatomic) IBOutlet UIButton *brainFogButton;
@property (weak, nonatomic) IBOutlet UIButton *sleepButton;

@end
