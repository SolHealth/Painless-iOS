//
//  SOLSleepEntryViewController.h
//  Painless
//
//  Created by Janardan Yri on 6/20/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOLPartialModalPresentation.h"

typedef void (^SOLSleepEntryCompletionBlock)(BOOL success, NSInteger selection);

@interface SOLSleepEntryViewController : UIViewController <SOLPartialModalPresentation>

@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) SOLSleepEntryCompletionBlock completionBlock;

@property (nonatomic, weak) UIView *tintView;
@property (nonatomic, weak) UIView *backdropView;

@end
