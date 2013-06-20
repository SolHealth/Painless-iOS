//
//  SOLDailySummaryCell+Configuration.m
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLDailySummaryCell+Configuration.h"
#import "SOLDaysTracker.h"

#define SOL_BUBBLE_DISTANCE_FROM_CENTER_TO_VERTICAL_WALL (32.5f)
#define SOL_BUBBLE_MAX_RADIUS (22.5f)

#define BYPASS_CONSTRAINTS

@implementation SOLDailySummaryCell (Configuration)

- (void)configureWithDayIndex:(NSInteger)dayIndex
                  daysTracker:(SOLDaysTracker *)daysTracker
                 sleepMinutes:(NSInteger)sleepMinutes
          overallPainSeverity:(CGFloat)overallPainSeverity
{
    sleepMinutes = abs(sleepMinutes);
    
    self.weekdayLabel.text = [[daysTracker weekdayTextForDayIndex:dayIndex] uppercaseString];
    self.dayLabel.text = [daysTracker dayTextForDayIndex:dayIndex];

    self.painBubbleRadius = [self.class painBubbleRadiusForOverallPainSeverity:overallPainSeverity];
    self.sleepBubbleRadius = [self.class sleepBubbleRadiusForSleepMinutes:sleepMinutes];

    UIColor *dateColor;
    if (daysTracker.closingDayIndex == dayIndex) {
        // 'Black color'
        // TODO: put colors in a category
        dateColor = [UIColor colorWithRed:36 / 255.f green:38 / 255.f blue:51 / 255.f alpha:1];
    } else {
        dateColor = [UIColor colorWithRed:136 / 255.f green:139 / 255.f blue:153 / 255.f alpha:1];
    }

    self.weekdayLabel.textColor = dateColor;
    self.dayLabel.textColor = dateColor;

    // Configure the shadow, utilizing the current bounds for performance
    self.dataContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.dataContainerView.layer.shadowOpacity = 0.2f;
    self.dataContainerView.layer.shadowRadius = 1.f;
    self.dataContainerView.layer.shadowOffset = CGSizeZero;
    self.dataContainerView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.dataContainerView.bounds
                                                                         cornerRadius:self.dataContainerView.layer.cornerRadius].CGPath;
    // TODO: Expand the actual cell to encompass the container view's shadow
    self.clipsToBounds = NO;
}

// Grey: dateColor = [UIColor colorWithRed:192 / 255.f green:194 / 255.f blue:204 / 255.f alpha:1];

+ (CGFloat)painBubbleRadiusForOverallPainSeverity:(CGFloat)overallPainSeverity
{
    return overallPainSeverity * SOL_BUBBLE_MAX_RADIUS;
}

+ (CGFloat)sleepBubbleRadiusForSleepMinutes:(NSInteger)sleepMinutes
{
    // Scale our sleepMinutes linearly across our potential radii
    CGFloat scale = MIN(1.f, MAX(0.f, sleepMinutes / (8.f * 60.f)));
    return scale * SOL_BUBBLE_MAX_RADIUS;
}

- (void)setPainBubbleRadius:(CGFloat)painBubbleRadius
{
    self.painBubble.layer.cornerRadius = painBubbleRadius;

#ifdef BYPASS_CONSTRAINTS
    self.painBubble.translatesAutoresizingMaskIntoConstraints = YES;
    [self removeConstraints:@[self.painWidthConstraint, self.painTopGapConstraint, self.painHeightConstraint]];
    self.painBubble.bounds = (CGRect) {
        .origin = CGPointZero,
        .size.width = 2 * painBubbleRadius,
        .size.height = 2 * painBubbleRadius,
    };
#else
    self.painWidthConstraint.constant = 2 * painBubbleRadius;
    self.painHeightConstraint.constant = 2 * painBubbleRadius;
    self.painTopGapConstraint.constant = SOL_BUBBLE_DISTANCE_FROM_CENTER_TO_VERTICAL_WALL - painBubbleRadius;
    [self setNeedsLayout];
#endif
}

- (void)setSleepBubbleRadius:(CGFloat)sleepBubbleRadius
{
    self.sleepBubble.layer.cornerRadius = sleepBubbleRadius;

#ifdef BYPASS_CONSTRAINTS
    self.sleepBubble.translatesAutoresizingMaskIntoConstraints = YES;
    [self removeConstraints:@[self.sleepWidthConstraint, self.sleepBottomGapConstraint, self.sleepHeightConstraint]];
    self.sleepBubble.bounds = (CGRect) {
        .origin = CGPointZero,
        .size.width = 2 * sleepBubbleRadius,
        .size.height = 2 * sleepBubbleRadius,
    };
#else
    self.sleepWidthConstraint.constant = 2 * sleepBubbleRadius;
    self.sleepHeightConstraint.constant = 2 * sleepBubbleRadius;
    self.sleepBottomGapConstraint.constant = SOL_BUBBLE_DISTANCE_FROM_CENTER_TO_VERTICAL_WALL - sleepBubbleRadius;
    [self setNeedsLayout];
#endif
}

@end
