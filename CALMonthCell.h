////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALMonthCell.h
//  iOS Tester
//
//  Created by Austin Cherry on 3/24/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

@interface CALMonthCell : UICollectionViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

- (void)setObject:(id)object;

@property(nonatomic, strong)UICollectionView *monthView;
@property(nonatomic, strong)UILabel *monthLabel;
@property(nonatomic)BOOL isMonth;

@end
