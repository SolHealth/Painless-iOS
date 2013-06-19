//
//  SOLCalendarToDailyTransitionAnimator.m
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLCalendarToDailyTransitionAnimator.h"
#import "SOLDailyViewController.h"
#import "SOLCalendarViewController.h"
#import "SOLMath.h"

@implementation SOLCalendarToDailyTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    SOLCalendarViewController *calendarViewController = (SOLCalendarViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SOLDailyViewController *summaryViewController = (SOLDailyViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = calendarViewController.view.superview;
    // TODO: Why does the commented out version not work?
    //    containerView = transitionContext.containerView;

    UIView *selectedView = calendarViewController.selectedView;
    CGRect selectedRect = [containerView convertRect:selectedView.frame fromView:selectedView.superview];
    CGRect finalRect = containerView.bounds;

    summaryViewController.view.transform = SOLCGAffineTransformFromRectToRect(finalRect, selectedRect);

    [containerView addSubview:summaryViewController.view];

    [UIView animateWithDuration:0.5f animations:^{
        summaryViewController.view.transform = CGAffineTransformIdentity;
        selectedView.transform = SOLCGAffineTransformFromRectToRect(selectedRect, finalRect);
        summaryViewController.view.alpha = 1;
        calendarViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
