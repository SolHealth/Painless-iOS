//
//  SOLSleepHoursCell.m
//  Painless
//
//  Created by Janardan Yri on 6/20/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLSleepHoursCell.h"

#define SOL_MAX_SLEEP_RADIUS (44.f)

@implementation SOLSleepHoursCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setHours:(NSInteger)hours
{
    if (hours == _hours) { return; }
    _hours = hours;

    self.hourLabel.text = [NSString stringWithFormat:@"%i", _hours];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGFloat radius = 22 + self.hours / 11.f * 22;
    CGRect ovalRect = (CGRect) {
        .origin.x = CGRectGetMidX(self.bounds) - radius,
        .origin.y = CGRectGetMidY(self.bounds) - radius,
        .size.width = 2 * radius,
        .size.height = 2 * radius,
    };

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    [[UIColor colorWithRed:128 / 255.f green:168 / 255.f blue:255 / 255.f alpha:1] setFill];
    [path fill];
}

@end
