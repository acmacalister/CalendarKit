//
//  DEAnimatedTransitioning.h
//  iOS Tester
//
//  Created by Austin Cherry on 3/28/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DETransitioningDelegate : NSObject<UIViewControllerTransitioningDelegate>

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;

@end

@interface DEAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic)BOOL reverse;

@end
