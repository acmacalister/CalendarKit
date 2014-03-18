////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALDayLayout.h
//  iOS Tester
//
//  Created by Austin Cherry on 3/18/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

@protocol CALDayLayoutDelegate <UICollectionViewDelegate>

@end

@interface CALDayLayout : UICollectionViewLayout

@property (nonatomic, weak) id<CALDayLayoutDelegate> delegate;

@end