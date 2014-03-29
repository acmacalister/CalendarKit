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

@protocol CALYearTransitionControllerDelegate <NSObject>
- (void)interactionBeganAtPoint:(CGPoint)p;
@end

@interface CALYearTransitionController : NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic) id <CALYearTransitionControllerDelegate> delegate;
@property (nonatomic) BOOL hasActiveInteraction;
@property (nonatomic) UINavigationControllerOperation navigationOperation;
@property (nonatomic) UICollectionView *collectionView;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;


@end
