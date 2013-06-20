//
//  SOLPartialModalTransitionAnimator.m
//  Painless
//
//  Created by Janardan Yri on 6/20/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLPartialModalTransitionAnimator.h"
#import "SOLPartialModalPresentation.h"

@implementation SOLPartialModalTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <SOLPartialModalPresentation> *toViewController = (UIViewController <SOLPartialModalPresentation> *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = transitionContext.containerView;
    UIView *backdropView = [fromViewController.view snapshot];
    UIView *tintView = [[UIView alloc] init];
    tintView.alpha = 0;
    tintView.backgroundColor = [UIColor blackColor];

    // Set up our math...
    CGRect initialRect = (CGRect) {
        .origin.x = 0,
        .origin.y = CGRectGetHeight(containerView.bounds),
        .size.width = CGRectGetWidth(containerView.bounds),
        .size.height = [toViewController preferredModalHeight],
    };

    CGRect finalRect = (CGRect) {
        .origin.x = 0,
        .origin.y = initialRect.origin.y - [toViewController preferredModalHeight],
        .size = initialRect.size,
    };

    // Set up our complex set of "we're going to imitate the old view still being here but faded" logic
    toViewController.modalView.frame = initialRect;
    toViewController.view.frame = containerView.bounds;
    [containerView addSubview:toViewController.view];

    tintView.frame = containerView.bounds;
    backdropView.frame = containerView.bounds;
    [toViewController.view addSubview:tintView];
    [toViewController.view addSubview:backdropView];
    [toViewController.view sendSubviewToBack:tintView];
    [toViewController.view sendSubviewToBack:backdropView];

    toViewController.backdropView = backdropView;
    toViewController.tintView = tintView;

    // Animate the modal view in
    [UIView animateWithDuration:0.3f animations:^{
        toViewController.modalView.frame = finalRect;
        tintView.alpha = 0.6;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
