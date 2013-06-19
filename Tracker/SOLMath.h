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

#endif
