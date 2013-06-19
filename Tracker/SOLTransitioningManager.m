//
//  SOLTransitioningManager.m
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLTransitioningManager.h"

#import "SOLDailyToCalendarTransitionAnimator.h"
#import "SOLCalendarToDailyTransitionAnimator.h"
#import "SOLCalendarViewController.h"
#import "SOLDailyViewController.h"

@interface SOLTransitioningManager ()

@property (nonatomic, strong, readonly) SOLDailyToCalendarTransitionAnimator *dailyToCalendarTransitionAnimator;
@property (nonatomic, strong, readonly) SOLCalendarToDailyTransitionAnimator *calendarToDailyTransitionAnimator;

@end

@implementation SOLTransitioningManager

@synthesize dailyToCalendarTransitionAnimator = _dailyToCalendarTransitionAnimator;
@synthesize calendarToDailyTransitionAnimator = _calendarToDailyTransitionAnimator;

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    NSAssert([presenting isKindOfClass:[SOLDailyViewController class]] && [presented isKindOfClass:[SOLCalendarViewController class]], @"Unrecognized view controllers.");
    return [self dailyToCalendarTransitionAnimator];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    NSAssert([dismissed isKindOfClass:[SOLCalendarViewController class]], @"Unrecognized view controller.");
    return [self calendarToDailyTransitionAnimator];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

#pragma mark - Lazily instantiated properties

- (SOLDailyToCalendarTransitionAnimator *)dailyToCalendarTransitionAnimator
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dailyToCalendarTransitionAnimator = [[SOLDailyToCalendarTransitionAnimator alloc] init];
    });
    return _dailyToCalendarTransitionAnimator;
}

- (SOLCalendarToDailyTransitionAnimator *)calendarToDailyTransitionAnimator
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _calendarToDailyTransitionAnimator = [[SOLCalendarToDailyTransitionAnimator alloc] init];
    });
    return _calendarToDailyTransitionAnimator;
}

@end
