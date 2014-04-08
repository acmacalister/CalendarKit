////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALDayCell.h
//  iOS Tester
//
//  Created by Austin Cherry on 3/24/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

@interface CALDayCell : UICollectionViewCell

- (void)setObject:(id)object;

@property(nonatomic, strong)UILabel *numberLabel;
@property(nonatomic)BOOL isMonth;

@end
