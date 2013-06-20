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

@property (nonatomic, strong) NSDateFormatter *weekdayFormatter;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSDateFormatter *monthYearFormatter;

@end

@implementation SOLDaysTracker

- (instancetype)initWithCalendar:(NSCalendar *)calendar
                    startingDate:(NSDate *)startingDate
{
    if ((self = [super init])) {
        _calendar = [calendar copy];
        _startingDay = [self.class dayForDate:startingDate
                                   inCalendar:_calendar];

        _weekdayFormatter   = [self.class dateFormatterWithFormatTemplate:@"EEE"    calendar:_calendar];
        _dayFormatter       = [self.class dateFormatterWithFormatTemplate:@"dd"     calendar:_calendar];
        _monthYearFormatter = [self.class dateFormatterWithFormatTemplate:@"MMMM y" calendar:_calendar];
    }
    return self;
}

#pragma mark - Instance-level data manipulation

- (NSInteger)todayIndex
{
    NSInteger today = [self.class dayForDate:[NSDate date] inCalendar:self.calendar];
    NSInteger todayIndex = today - self.startingDay;
    return todayIndex;
}

- (NSString *)weekdayTextForDayIndex:(NSInteger)dayIndex
{
    return [self textForDayIndex:dayIndex withFormatter:self.weekdayFormatter];
}

- (NSString *)dayTextForDayIndex:(NSInteger)dayIndex
{
    return [self textForDayIndex:dayIndex withFormatter:self.dayFormatter];
}

- (NSString *)monthAndYearTextForDayIndex:(NSInteger)dayIndex
{
    return [self textForDayIndex:dayIndex withFormatter:self.monthYearFormatter];
}

- (NSDate *)dateForDayIndex:(NSInteger)dayIndex
{
    NSInteger day = [self.class dayForDayIndex:dayIndex startingDay:self.startingDay];
    NSDate *date = [self.class dateForDay:day inCalendar:self.calendar];
    return date;
}

- (NSString *)textForDayIndex:(NSInteger)dayIndex withFormatter:(NSDateFormatter *)dateFormatter
{
    NSDate *date = [self dateForDayIndex:dayIndex];
    NSString *formattedText = [dateFormatter stringFromDate:date];
    return formattedText;
}

#pragma mark - Private class-level 'pure' functions

+ (NSDateFormatter *)dateFormatterWithFormatTemplate:(NSString *)formatTemplate calendar:(NSCalendar *)calendar
{
    NSString *format = [NSDateFormatter dateFormatFromTemplate:formatTemplate
                                                       options:0
                                                        locale:calendar.locale];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return formatter;
}

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
