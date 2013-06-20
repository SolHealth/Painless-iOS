//
//  SOLDailyData.m
//  Painless
//
//  Created by Janardan Yri on 6/20/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLDailyData.h"

@implementation SOLDailyData

- (instancetype)initWithDay:(NSInteger)day
{
    if ((self = [super init])) {
        _day = day;

        // Initialize everything to "not here"
        _sleepMinutes = NSNotFound;
        _musclePainHundredths = NSNotFound;
        _jointPainHundredths = NSNotFound;
        _headPainHundredths = NSNotFound;
        _tactilePainHundredths = NSNotFound;
        _brainFogHundredths = NSNotFound;
    }
    return self;
}

// Average the severity of any issues we have (or return 0 if none are filled out)
- (CGFloat)overallPainSeverity
{
    NSInteger accumulator = 0;
    NSInteger count = 0;

    NSInteger painHundredths[5] = {self.musclePainHundredths, self.jointPainHundredths, self.headPainHundredths, self.tactilePainHundredths, self.brainFogHundredths};

    for (int i = 0; i < 5; i++) {
        NSInteger painHundredth = painHundredths[i];

        if (painHundredth != NSNotFound) {
            accumulator += abs(painHundredth);
            count += 1;
        }
    }

    if (count == 0) {
        return 0;
    } else {
        return (accumulator / 100.f) / count;
    }
}

@end
