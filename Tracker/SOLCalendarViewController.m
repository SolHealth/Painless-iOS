//
//  SOLCalendarViewController.m
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLCalendarViewController.h"

#import "SOLDailyViewController.h"
#import "SOLDailySummaryCell.h"
#import "SOLDailySummaryCell+Configuration.h"
#import "SOLDaysTracker.h"
#import "SOLAppDelegate.h"
#import "SOLTransitioningManager.h"
#import "SOLDailyData.h"
#import "SOLMath.h"

@interface SOLCalendarViewController ()

@property (nonatomic, strong, readonly) SOLDaysTracker *daysTracker;

@property (nonatomic, strong) NSIndexPath *visibleReferenceIndexPath;

@property (nonatomic, weak, readwrite) UIView *selectedView;

@property (nonatomic, copy) NSArray *dailyDataByDayIndex;

@end

@implementation SOLCalendarViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _daysTracker = [[SOLDaysTracker alloc] initWithCalendar:[NSCalendar currentCalendar]
                                                   startingDate:[NSDate dateWithTimeIntervalSinceNow:-3251542]];

        _dailyDataByDayIndex = [self.class dummyDataWithDaysTracker:_daysTracker];

        _visibleReferenceIndexPath = nil;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = [(SOLAppDelegate *)[UIApplication sharedApplication].delegate transitioningManager];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Let's show 'today'.
    NSIndexPath *closingDayIndexPath = [NSIndexPath indexPathForItem:self.daysTracker.closingDayIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:closingDayIndexPath
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:NO];
    // And make sure we update with the correct reference path; the above line triggers scrollViewDidScroll with no visible cells yet.
    [self updateWithNewReferenceIndexPath:closingDayIndexPath];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.daysTracker.closingDayIndex + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger dayIndex = [self dayIndexForIndexPath:indexPath];
    id dailyDataOrNull = self.dailyDataByDayIndex[dayIndex];

    static NSString *CellIdentifier = @"DailySummaryCell";
    SOLDailySummaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                          forIndexPath:indexPath];

    if (dailyDataOrNull == [NSNull null]) {
        [cell configureWithDayIndex:dayIndex
                        daysTracker:self.daysTracker
                       sleepMinutes:NSNotFound
                overallPainSeverity:0];
    } else {
        SOLDailyData *dailyData = dailyDataOrNull;
        [cell configureWithDayIndex:dayIndex
                        daysTracker:self.daysTracker
                       sleepMinutes:dailyData.sleepMinutes
                overallPainSeverity:dailyData.overallPainSeverity];
    }

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Expose this to the transition animator so it can animate "into" the data container
    SOLDailySummaryCell *selectedCell = (SOLDailySummaryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.selectedView = selectedCell.dataContainerView;
    
    SOLDailyViewController *dailyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DailyViewController"];

    // Give the dailyViewController its necessary data
    NSInteger dayIndex = [self dayIndexForIndexPath:indexPath];
    id dailyDataOrNull = self.dailyDataByDayIndex[dayIndex];
    if (dailyDataOrNull != [NSNull null]) {
        dailyViewController.dailyData = dailyDataOrNull;
    }
    dailyViewController.daysTracker = self.daysTracker;

    // Present! (The custom animator should take over from here.)
    [self presentViewController:dailyViewController animated:YES completion:nil];
}

#pragma mark - Data Management

// Create fake dailyDataByDayIndex for test purposes
+ (NSArray *)dummyDataWithDaysTracker:(SOLDaysTracker *)daysTracker
{
    NSInteger numberOfDays = daysTracker.closingDayIndex + 1;

    NSMutableArray *dailyDataByDaysIndex = [NSMutableArray arrayWithCapacity:numberOfDays];

    for (NSInteger dayIndex = 0; dayIndex < numberOfDays; dayIndex++) {
        id dailyDataOrNull;
        if (SOLRand(5) == 0 && NO) {
            // Simulate some days without any data
            dailyDataOrNull = [NSNull null];
        } else {
            NSInteger day = [daysTracker dayForDayIndex:dayIndex];
            SOLDailyData *dailyData = [[SOLDailyData alloc] initWithDay:day];

            dailyData.sleepMinutes = (SOLRandBool(0.8f)) ? (SOLRand(12) * 60) : (NSNotFound);
            dailyData.brainFogHundredths    = SOLRandOrNotFound(100, 0.8f);
            dailyData.musclePainHundredths  = SOLRandOrNotFound(100, 0.8f);
            dailyData.jointPainHundredths   = SOLRandOrNotFound(100, 0.8f);
            dailyData.headPainHundredths    = SOLRandOrNotFound(100, 0.8f);
            dailyData.tactilePainHundredths = SOLRandOrNotFound(100, 0.8f);

            dailyDataOrNull = dailyData;
        }

        [dailyDataByDaysIndex addObject:dailyDataOrNull];
    }

    return [NSArray arrayWithArray:dailyDataByDaysIndex];
}

// Returns NSNotFound for indexPaths that don't correspond to dayIndexes
- (NSInteger)dayIndexForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil || indexPath.section != 0) { return NSNotFound; }

    return indexPath.item;
}

#pragma mark - UIScrollViewDelegate (UICollectionViewDelegate)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionView) {
        SOLDailySummaryCell *firstVisibleCell = self.collectionView.visibleCells.firstObject;
        NSIndexPath *firstVisibleIndexPath = [self.collectionView indexPathForCell:firstVisibleCell];
        if (![firstVisibleIndexPath isEqual:self.visibleReferenceIndexPath]) {
            // Our first visible cell has changed - let's update the label at the top of the display.
            [self updateWithNewReferenceIndexPath:firstVisibleIndexPath];
        }
    }
}

- (void)updateWithNewReferenceIndexPath:(NSIndexPath *)newReferenceIndexPath;
{
    self.visibleReferenceIndexPath = newReferenceIndexPath;
    NSInteger dayIndex = [self dayIndexForIndexPath:newReferenceIndexPath];

    if (dayIndex != NSNotFound) {
        self.monthLabel.text = [self.daysTracker monthAndYearTextForDayIndex:dayIndex];
    } else {
        self.monthLabel.text = nil;
    }

}

@end
