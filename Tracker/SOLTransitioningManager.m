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
#import "SOLPartialModalPresentation.h"
#import "SOLPartialModalTransitionAnimator.h"
#import "SOLPartialModalDismissalAnimator.h"

@interface SOLTransitioningManager ()

@property (nonatomic, strong, readonly) SOLDailyToCalendarTransitionAnimator *dailyToCalendarTransitionAnimator;
@property (nonatomic, strong, readonly) SOLCalendarToDailyTransitionAnimator *calendarToDailyTransitionAnimator;

@property (nonatomic, strong, readonly) SOLPartialModalTransitionAnimator *partialModalTransitionAnimator;
@property (nonatomic, strong, readonly) SOLPartialModalDismissalAnimator *partialModalDismissalAnimator;

@end

@implementation SOLTransitioningManager

@synthesize dailyToCalendarTransitionAnimator = _dailyToCalendarTransitionAnimator;
@synthesize calendarToDailyTransitionAnimator = _calendarToDailyTransitionAnimator;
@synthesize partialModalTransitionAnimator = _partialModalTransitionAnimator;
@synthesize partialModalDismissalAnimator = _partialModalDismissalAnimator;

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if ([presented conformsToProtocol:@protocol(SOLPartialModalPresentation)]) {
        return [self partialModalTransitionAnimator];
    } else {
        NSAssert([presenting isKindOfClass:[SOLCalendarViewController class]] &&
                 [presented  isKindOfClass:[SOLDailyViewController class]],
                 @"Unrecognized view controllers.");
        return [self calendarToDailyTransitionAnimator];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if ([dismissed conformsToProtocol:@protocol(SOLPartialModalPresentation)]) {
        return [self partialModalDismissalAnimator];
    } else {
        NSAssert([dismissed isKindOfClass:[SOLDailyViewController class]], @"Unrecognized view controller.");
        return [self dailyToCalendarTransitionAnimator];
    }
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

- (SOLPartialModalTransitionAnimator *)partialModalTransitionAnimator
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _partialModalTransitionAnimator = [[SOLPartialModalTransitionAnimator alloc] init];
    });
    return _partialModalTransitionAnimator;
}

- (SOLPartialModalDismissalAnimator *)partialModalDismissalAnimator
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _partialModalDismissalAnimator = [[SOLPartialModalDismissalAnimator alloc] init];
    });
    return _partialModalDismissalAnimator;
}

@end
