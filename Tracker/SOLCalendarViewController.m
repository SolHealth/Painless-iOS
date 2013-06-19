//
//  SOLSummaryViewController.m
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLCalendarViewController.h"

#import "SOLDailySummaryCell.h"
#import "SOLDailySummaryCell+Configuration.h"

#import "SOLDaysTracker.h"

@interface SOLCalendarViewController ()

@property (nonatomic, strong, readonly) SOLDaysTracker *daysTracker;

@property (nonatomic, strong) NSIndexPath *visibleReferenceIndexPath;

// Note that this may desynch from the actual number of days if midnight is crossed - but our data should stay internally consistent.
@property (nonatomic, readonly) NSInteger numberOfDays;

@end

@implementation SOLCalendarViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _daysTracker = [[SOLDaysTracker alloc] initWithCalendar:[NSCalendar currentCalendar]
                                                   startingDate:[NSDate dateWithTimeIntervalSinceNow:-1251542]];
        _numberOfDays = [_daysTracker numberOfDaysSinceStartingDateInclusive];
        _visibleReferenceIndexPath = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Let's show 'today'.
    NSIndexPath *todayIndexPath = [NSIndexPath indexPathForItem:self.numberOfDays - 1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:todayIndexPath
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:NO];
    // And make sure we update with the correct reference path; the above line triggers scrollViewDidScroll with no visible cells yet.
    [self updateWithNewReferenceIndexPath:todayIndexPath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfDays;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DailySummaryCell";
    SOLDailySummaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                          forIndexPath:indexPath];

    NSInteger dayIndex = [self dayIndexForIndexPath:indexPath];

    NSString *weekdayText = [self.daysTracker weekdayTextForDayIndex:dayIndex];
    NSString *dayText     = [self.daysTracker dayTextForDayIndex:dayIndex];

    [cell configureWithWeekdayText:weekdayText
                           dayText:dayText];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Data Management

// Returns NSNotFound for indexPaths that don't correspond to dayIndexes
- (NSInteger)dayIndexForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil || indexPath.section != 0) { return NSNotFound; }

    return indexPath.item;
}

#pragma mark - UIScrollViewDelegate (UICollectionViewDelegate

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
