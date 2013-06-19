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

@property (nonatomic, strong, readonly) SOLDailyToCalendarTransitionAnimator *summaryToCalendarTransitionAnimator;
@property (nonatomic, strong, readonly) SOLCalendarToDailyTransitionAnimator *calendarToDailyTransitionAnimator;

@end

@implementation SOLTransitioningManager

@synthesize summaryToCalendarTransitionAnimator = _summaryToCalendarTransitionAnimator;
@synthesize calendarToDailyTransitionAnimator = _calendarToDailyTransitionAnimator;

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
//    if ([presenting isKindOfClass:[SOLCalendarViewController class]] && [source isKindOfClass:[SOLDailyViewController class]]) {
//    }
    return [self summaryToCalendarTransitionAnimator];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
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

- (SOLDailyToCalendarTransitionAnimator *)summaryToCalendarTransitionAnimator
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _summaryToCalendarTransitionAnimator = [[SOLDailyToCalendarTransitionAnimator alloc] init];
    });
    return _summaryToCalendarTransitionAnimator;
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
