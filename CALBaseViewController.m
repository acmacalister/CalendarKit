////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALBaseViewController.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/28/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALBaseViewController.h"

@interface CALBaseViewController ()

@end

@implementation CALBaseViewController

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewController *)nextViewControllerAtPoint:(CGPoint)p
{
    return nil;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView
                        transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
{
    UICollectionViewTransitionLayout *transitionLayout = [[UICollectionViewTransitionLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    return transitionLayout;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
