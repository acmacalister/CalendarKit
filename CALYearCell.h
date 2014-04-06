////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALYearCell.h
//  iOS Tester
//
//  Created by Austin Cherry on 3/20/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>


@class CALMonth;

@protocol CALYearCellDelegate <NSObject>

-(void)didSelectMonth:(CALMonth*)month;

@end

@interface CALYearCell : UICollectionViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

- (void)setObject:(id)object;

@property(nonatomic, strong)UILabel *yearLabel;
@property(nonatomic, strong)UICollectionView *monthView;
@property(nonatomic, weak)id<CALYearCellDelegate> delegate;

@end
