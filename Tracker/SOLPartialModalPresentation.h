//
//  SOLPartialModalPresentation.h
//  Painless
//
//  Created by Janardan Yri on 6/20/13.
//  Copyright (c) 2013 Sol Health, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SOLPartialModalPresentation <NSObject>

@required
- (CGFloat)preferredModalHeight;
- (UIView *)modalView;

@property (nonatomic, weak) UIView *tintView;
@property (nonatomic, weak) UIView *backdropView;

@end
