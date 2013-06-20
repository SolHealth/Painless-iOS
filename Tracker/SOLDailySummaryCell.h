//
//  SOLDailySummaryCell.h
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOLDailySummaryCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@property (weak, nonatomic) IBOutlet UIView *dataContainerView;

@property (weak, nonatomic) IBOutlet UIView *painBubble;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *painWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *painHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *painTopGapConstraint;

@property (weak, nonatomic) IBOutlet UIView *sleepBubble;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sleepWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sleepHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sleepBottomGapConstraint;

@end
