////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALTransitionController.h
//  iOS Tester
//
//  Created by Austin Cherry on 4/4/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@import UIKit;

@protocol CALTransitionControllerDelegate <NSObject>
-(void)interactionBeganAtPoint:(CGPoint)p;
@end

@interface CALTransitionController : NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic) id <CALTransitionControllerDelegate> delegate;
@property (nonatomic) BOOL hasActiveInteraction;
@property (nonatomic) UINavigationControllerOperation navigationOperation;
@property (nonatomic) UICollectionView* collectionView;

-(instancetype)initWithCollectionView:(UICollectionView*)collectionView;

@end
