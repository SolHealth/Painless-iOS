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

@implementation SOLCalendarToDailyTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    SOLCalendarViewController *calendarViewController = (SOLCalendarViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SOLDailyViewController *summaryViewController = (SOLDailyViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    summaryViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);

    // TODO: Why does the commented out version not work?
    //    [transitionContext.containerView addSubview:summaryViewController.view];
    [calendarViewController.view.superview addSubview:summaryViewController.view];

    [UIView animateWithDuration:0.5f animations:^{
        summaryViewController.view.transform = CGAffineTransformIdentity;
        summaryViewController.view.alpha = 1;
        calendarViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
