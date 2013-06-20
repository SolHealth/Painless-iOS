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
    // containerView = transitionContext.containerView;

    // Set up our math...
    UIView *selectedView = calendarViewController.selectedView;
    CGRect selectedRect = [containerView convertRect:selectedView.frame fromView:selectedView.superview];
    CGRect finalRect = containerView.bounds;


    // We're going to take a snapshot of the view we've selected, expand that as though we 'zoom into' it, and gradually fade the actual view controller into its place.
#warning This will break in iOS 7 Seed 2: change the message to [selectedView snapshotView]
    // 'Fade out' zoom view
    UIView *selectedViewSnapshot = [selectedView snapshot];
    [containerView addSubview:selectedViewSnapshot];
    selectedViewSnapshot.frame = selectedRect;

    // 'Fade in' zoom view - contort it to come out of the same point as the snapshot
    summaryViewController.view.transform = SOLCGAffineTransformFromRectToRect(finalRect, selectedRect);
    [containerView addSubview:summaryViewController.view];

    // Now, boom! Restore the new viewer to full, contort up the snapshot, and take it away.
    [UIView animateWithDuration:0.5f animations:^{
        summaryViewController.view.transform = CGAffineTransformIdentity;
        selectedViewSnapshot.transform = SOLCGAffineTransformFromRectToRect(selectedRect, finalRect);
        summaryViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        [selectedViewSnapshot removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
