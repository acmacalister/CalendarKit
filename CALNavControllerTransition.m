////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALNavControllerTransition.m
//  iOS Tester
//
//  Created by Austin Cherry on 4/4/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALNavControllerTransition.h"

@implementation CALNavControllerTransition

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    NSLog(@"Called transition!s");
    return nil;
}
////////////////////////////////////////////////////////////////////////////////////////////////////

@end
