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

@property (nonatomic, strong) SOLDaysTracker *daysTracker;

@end

@implementation SOLCalendarViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _daysTracker = [[SOLDaysTracker alloc] initWithCalendar:[NSCalendar currentCalendar]
                                                   startingDate:[NSDate dateWithTimeIntervalSinceNow:-1251542]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    return [self.daysTracker numberOfDaysSinceStartingDateInclusive];
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
    if (indexPath.section != 0) { return NSNotFound; }

    return indexPath.row;
}

@end
