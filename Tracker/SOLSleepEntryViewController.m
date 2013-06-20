//
//  SOLSleepEntryViewController.m
//  Painless
//
//  Created by Janardan Yri on 6/20/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import "SOLSleepEntryViewController.h"

#import "SOLSleepHoursCell.h"

@interface SOLSleepEntryViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger selected;

@end

@implementation SOLSleepEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SOLSleepHoursCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SleepHoursCell" forIndexPath:indexPath];

    cell.hours = indexPath.item;

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *cells = self.collectionView.visibleCells;

    // TODO: This doesn't work
    for (UICollectionViewCell *cell in cells) {
        CGFloat distance = fabsf(cell.center.y - CGRectGetMidY(self.collectionView.bounds));
        cell.alpha = (1 - distance / 320); // 0.5..1
    }
}

#pragma mark - Actions

- (IBAction)confirmButtonPressed
{
    self.completionBlock(YES, 0);
}

- (IBAction)cancelButtonPressed
{
    self.completionBlock(NO, 0);
}

#pragma mark - SOLPartialModalPresentation

- (CGFloat)preferredModalHeight
{
    return 257;
}

@end
