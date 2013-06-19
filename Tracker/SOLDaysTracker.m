//
//  SOLDaysTracker.m
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLDaysTracker.h"

@interface SOLDaysTracker ()

@property (nonatomic, copy, readonly) NSCalendar *calendar;
@property (nonatomic, readonly) NSInteger startingDay;

@end

@implementation SOLDaysTracker

- (instancetype)initWithCalendar:(NSCalendar *)calendar
                    startingDate:(NSDate *)startingDate
{
    if ((self = [super init])) {
        _calendar = [calendar copy];
        _startingDay = [self.class dayForDate:startingDate
                                   inCalendar:_calendar];
    }
    return self;
}

- (NSInteger)numberOfDaysSinceStartingDateInclusive
{
    NSInteger today = [self.class dayForDate:[NSDate date] inCalendar:self.calendar];
    NSInteger numberOfDays = today - self.startingDay + 1;
    return numberOfDays;
}

- (NSString *)weekdayTextForDayIndex:(NSInteger)dayIndex
{
    NSInteger day = [self.class dayForDayIndex:dayIndex
                                   startingDay:self.startingDay];

    static NSDateFormatter *WeekdayTextFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *weekdayTextFormat = [NSDateFormatter dateFormatFromTemplate:@"EEE"
                                                                      options:0
                                                                       locale:self.calendar.locale];
        WeekdayTextFormatter = [[NSDateFormatter alloc] init];
        WeekdayTextFormatter.dateFormat = weekdayTextFormat;
    });

    NSDate *date = [self.class dateForDay:day
                               inCalendar:self.calendar];

    NSString *formattedText = [WeekdayTextFormatter stringFromDate:date];

    return formattedText;
}

- (NSString *)dayTextForDayIndex:(NSInteger)dayIndex
{
    NSInteger day = [self.class dayForDayIndex:dayIndex
                                   startingDay:self.startingDay];

    static NSDateFormatter *DayTextFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dayTextFormat = [NSDateFormatter dateFormatFromTemplate:@"dd"
                                                                      options:0
                                                                       locale:self.calendar.locale];
        DayTextFormatter = [[NSDateFormatter alloc] init];
        DayTextFormatter.dateFormat = dayTextFormat;
    });

    NSDate *date = [self.class dateForDay:day
                               inCalendar:self.calendar];

    NSString *formattedText = [DayTextFormatter stringFromDate:date];

    return formattedText;
}

#pragma mark - Private class-level 'pure' functions

+ (NSInteger)dayForDayIndex:(NSInteger)dayIndex startingDay:(NSInteger)startingDay
{
    return dayIndex + startingDay;
}

// Note here that all references to 'days' are ordinal within an era. We're going to assume nobody's jogging between eras.
+ (NSInteger)dayForDate:(NSDate *)date inCalendar:(NSCalendar *)calendar
{
    return [calendar ordinalityOfUnit:NSDayCalendarUnit
                               inUnit:NSEraCalendarUnit
                              forDate:date];
}

+ (NSDate *)dateForDay:(NSInteger)day inCalendar:(NSCalendar *)calendar
{
    // Get the current era (again, we're assuming today and the desired date are in the same era) - set the desired day, return the date
    NSDateComponents *dateComponents = [calendar components:NSEraCalendarUnit fromDate:[NSDate date]];
    dateComponents.day = day;
    return [calendar dateFromComponents:dateComponents];
}

@end
