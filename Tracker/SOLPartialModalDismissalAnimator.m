//
//  SOLPartialModalDismissalAnimator.m
//  Painless
//
//  Created by Janardan Yri on 6/20/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLPartialModalDismissalAnimator.h"
#import "SOLPartialModalPresentation.h"

@implementation SOLPartialModalDismissalAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController <SOLPartialModalPresentation> *toViewController = (UIViewController <SOLPartialModalPresentation> *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController <SOLPartialModalPresentation> *modalViewController = (UIViewController <SOLPartialModalPresentation> *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *containerView = modalViewController.view.superview;
    [containerView addSubview:toViewController.view];
    [containerView sendSubviewToBack:toViewController.view];

    // Set up our math...
    CGRect initialRect = (CGRect) {
        .origin.x = 0,
        .origin.y = CGRectGetHeight(containerView.bounds),
        .size.width = CGRectGetWidth(containerView.bounds),
        .size.height = [modalViewController preferredModalHeight],
    };

    CGRect finalRect = (CGRect) {
        .origin.x = 0,
        .origin.y = initialRect.origin.y,
        .size = initialRect.size,
    };

    // Animate away the modal view
    [UIView animateWithDuration:0.3f animations:^{
        modalViewController.modalView.frame = finalRect;
        modalViewController.tintView.alpha = 0;
    } completion:^(BOOL finished) {
        [modalViewController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
