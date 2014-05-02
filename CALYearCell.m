////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALYearCell.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/20/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALYearCell.h"
#import "CALMonthCell.h"
#import "CALMonth.h"
#import "CALYear.h"

@interface CALYearCell()

@property(nonatomic, strong)NSArray *items;
@property(nonatomic, strong)NSNumber *currentYear;
@property(nonatomic, strong)UIView *lineView;

@end

#define CELL_ID @"MONTH_CELL"

@implementation CALYearCell

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.yearLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.yearLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        [self.contentView addSubview:self.yearLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectZero];
        self.lineView.backgroundColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1];
        [self.contentView addSubview:self.lineView];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(90, 110);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 2;
        self.monthView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.monthView.delegate = self;
        self.monthView.dataSource = self;
        [self.monthView registerClass:[CALMonthCell class] forCellWithReuseIdentifier:CELL_ID];
        self.monthView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.monthView];
        //self.monthView.userInteractionEnabled = NO;
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object
{
    CALYear *year = (CALYear*)object;
    self.items = year.months;
    self.currentYear = year.currentYear;
    
    self.yearLabel.text = [NSString stringWithFormat:@"%@", year.currentYear];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat pad = 10;
    float top = 0;
    float height = 21;
    float width = self.contentView.bounds.size.width;
    
    self.yearLabel.frame = CGRectMake(pad, pad, width-(pad*2), height);
    top += height+pad;
    
    CGFloat lineHeight = 1;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))
        lineHeight = 0.5;
    self.lineView.frame = CGRectMake(pad, top, width, lineHeight);
    
    height += lineHeight+pad;
    
    self.monthView.frame = CGRectMake(pad, top, width-(pad*2), self.contentView.bounds.size.height-(height-lineHeight));
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    CALMonth *month = self.items[indexPath.row];
    [cell setObject:month];
    return cell;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALMonth *month = self.items[indexPath.row];
    if([self.delegate respondsToSelector:@selector(didSelectMonth:)])
        [self.delegate didSelectMonth:month];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
