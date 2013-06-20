//
//  SOLSleepHoursCell.h
//  Painless
//
//  Created by Janardan Yri on 6/20/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOLSleepHoursCell : UICollectionViewCell

@property (nonatomic) NSInteger hours;

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

@end
