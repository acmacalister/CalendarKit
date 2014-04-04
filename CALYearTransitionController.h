////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALYearTransitionController.h
//  iOS Tester
//
//  Created by Austin Cherry on 3/28/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@interface CALYearTransitionController : NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@property (nonatomic) UICollectionView *collectionView;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end
