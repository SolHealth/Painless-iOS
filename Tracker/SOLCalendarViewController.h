//
//  SOLCalendarViewController.h
//  Painless
//
//  Created by Janardan Yri on 6/19/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOLCalendarViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

// Used for transitioning to the daily view.
@property (nonatomic, weak, readonly) UIView *selectedView;

@end
