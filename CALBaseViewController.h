////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALBaseViewController.h
//  iOS Tester
//
//  Created by Austin Cherry on 3/28/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

@interface CALBaseViewController : UICollectionViewController

- (UICollectionViewController *)nextViewControllerAtPoint:(CGPoint)p;

@end
