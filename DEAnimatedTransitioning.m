//
//  DEAnimatedTransitioning.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/28/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//

#import "DEAnimatedTransitioning.h"

static NSTimeInterval const DEAnimatedTransitionDuration = 0.5f;
static NSTimeInterval const DEAnimatedTransitionMarcoDuration = 0.15f;

@implementation DEAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    if (self.reverse) {
        [container insertSubview:toViewController.view belowSubview:fromViewController.view];
    }
    else {
        toViewController.view.transform = CGAffineTransformMakeScale(0, 0);
        [container addSubview:toViewController.view];
    }
    
    [UIView animateKeyframesWithDuration:DEAnimatedTransitionDuration delay:0 options:0 animations:^{
        if (self.reverse) {
            fromViewController.view.transform = CGAffineTransformMakeScale(0, 0);
        }
        else {
            toViewController.view.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return DEAnimatedTransitionDuration;
}

@end

@implementation DETransitioningDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    DEAnimatedTransitioning *transitioning = [DEAnimatedTransitioning new];
    return transitioning;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    DEAnimatedTransitioning *transitioning = [DEAnimatedTransitioning new];
    transitioning.reverse = YES;
    return transitioning;
}
////////////////////////////////////////////////////////////////////////////////////////////////////

@end