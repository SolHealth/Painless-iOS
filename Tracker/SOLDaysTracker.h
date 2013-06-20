//
//  SOLDaysTracker.h
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOLDaysTracker : NSObject

- (instancetype)initWithCalendar:(NSCalendar *)calendar
                    startingDate:(NSDate *)startingDate;

// This is today at the time the object is instantiated
- (NSInteger)closingDayIndex;

// Note: A 'day index' is an integer in [0..numberOfDays-1], corresponding to [startingDate..today]

- (NSString *)weekdayTextForDayIndex:(NSInteger)dayIndex;
- (NSString *)dayTextForDayIndex:(NSInteger)dayIndex;
- (NSString *)monthAndYearTextForDayIndex:(NSInteger)dayIndex;

// TODO: Dispatch a notification if the current day changes (ie, at midnight)

@end
