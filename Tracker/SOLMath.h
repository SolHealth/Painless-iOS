//
//  SOLMath.h
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#ifndef SOLMATH_H_
#define SOLMATH_H_

#include <stdio.h>
#include <CoreGraphics/CoreGraphics.h>

CG_INLINE CGAffineTransform SOLCGAffineTransformFromRectToRect(CGRect fromRect, CGRect toRect)
{
    CGFloat scaleWidth  = CGRectGetWidth(toRect)  / CGRectGetWidth(fromRect);
    CGFloat scaleHeight = CGRectGetHeight(toRect) / CGRectGetHeight(fromRect);
    CGFloat offsetX = CGRectGetMidX(toRect) - CGRectGetMidX(fromRect);
    CGFloat offsetY = CGRectGetMidY(toRect) - CGRectGetMidY(fromRect);
    return CGAffineTransformMake(scaleWidth, 0, 0, scaleHeight, offsetX, offsetY);
}

#define SOL_HIGH_ORDINALITY (1 << 16)

// Returns a random number 0..ordinality-1
CG_INLINE NSInteger SOLRand(NSInteger ordinality)
{
    return (NSInteger)(arc4random() % ordinality);
}

CG_INLINE CGFloat SOLRandFloat(NSInteger ordinality)
{
    return SOLRand(ordinality) / (CGFloat)ordinality;
}

// trueFraction = 0 -> always false
// trueFraction = 1 -> always true
CG_INLINE BOOL SOLRandBool(CGFloat trueFraction)
{
    NSInteger threshold = SOL_HIGH_ORDINALITY * trueFraction;
    return (SOLRandFloat(SOL_HIGH_ORDINALITY) < threshold);
}

CG_INLINE NSInteger SOLRandOrNotFound(NSInteger ordinality, CGFloat foundFraction)
{
    if(SOLRandBool(foundFraction)) {
        return SOLRand(ordinality);
    } else {
        return NSNotFound;
    }
}

#endif
