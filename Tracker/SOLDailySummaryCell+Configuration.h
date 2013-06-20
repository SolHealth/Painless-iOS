//
//  SOLDailySummaryCell+Configuration.h
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLDailySummaryCell.h"

@class SOLDaysTracker;

@interface SOLDailySummaryCell (Configuration)

- (void)configureWithDayIndex:(NSInteger)dayIndex
                  daysTracker:(SOLDaysTracker *)daysTracker
                 sleepMinutes:(NSInteger)sleepMinutes
          overallPainSeverity:(CGFloat)overallPainSeverity;

@end
