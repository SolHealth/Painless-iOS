//
//  SOLDailyToCalendarTransitionAnimator.m
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLDailyToCalendarTransitionAnimator.h"
#import "SOLCalendarViewController.h"
#import "SOLDailyViewController.h"

@implementation SOLDailyToCalendarTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    SOLDailyViewController *summaryViewController = (SOLDailyViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SOLCalendarViewController *calendarViewController = (SOLCalendarViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [transitionContext.containerView addSubview:calendarViewController.view];
    [transitionContext.containerView sendSubviewToBack:calendarViewController.view];

    [UIView animateWithDuration:0.5f animations:^{
        summaryViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
        summaryViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
