//
//  SOLDailyData.h
//  Painless
//
//  Created by Janardan Yri on 6/20/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOLDailyData : NSObject

// Designated initializer
- (instancetype)initWithDay:(NSInteger)day;

// Indexed day; should be only one summary per day.
@property (nonatomic, readonly) NSInteger day;

// Minutes 0..11*60; initially NSNotFound
@property (nonatomic) NSInteger sleepMinutes;

// Trouble gauges: 0..100; initially NSNotFound
@property (nonatomic) NSInteger musclePainHundredths;
@property (nonatomic) NSInteger jointPainHundredths;
@property (nonatomic) NSInteger headPainHundredths;
@property (nonatomic) NSInteger tactilePainHundredths;
@property (nonatomic) NSInteger brainFogHundredths;

- (CGFloat)overallPainSeverity;

@end
