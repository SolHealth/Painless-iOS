//
//  SOLDailySummaryCell+Configuration.m
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLDailySummaryCell+Configuration.h"

@implementation SOLDailySummaryCell (Configuration)

- (void)configureWithWeekdayText:(NSString *)weekdayText dayText:(NSString *)dayText
{
    self.weekdayLabel.text = [weekdayText uppercaseString];
    self.dayLabel.text = dayText;
}

@end
