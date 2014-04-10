////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALMonthCell.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/24/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALMonthCell.h"
#import "CALMonth.h"
#import "CALDayCell.h"
#import "CALMonthViewLayout.h"

@interface CALMonthCell()

@property(nonatomic, strong)CALMonth *month;
@property(nonatomic, strong)NSDateFormatter *dateFormat;

@end

#define CELL_ID @"DAY_CELL"

@implementation CALMonthCell

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CALMonthViewLayout *layout = [[CALMonthViewLayout alloc] init];
        self.monthView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.monthView.delegate = self;
        self.monthView.dataSource = self;
        [self.monthView registerClass:[CALDayCell class] forCellWithReuseIdentifier:CELL_ID];
        self.monthView.backgroundColor = [UIColor clearColor];
        self.monthView.userInteractionEnabled = NO;
        [self.contentView addSubview:self.monthView];
        
        self.monthLabel = [UILabel new];
        self.monthLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.monthLabel];
        
        self.dateFormat = [[NSDateFormatter alloc] init];
        [self.dateFormat setDateFormat:@"MMM"];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object
{
    self.month = (CALMonth*)object;
    
    self.monthLabel.text = [NSString stringWithFormat:@"%@", [self.dateFormat stringFromDate:self.month.date]];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CALMonthViewLayout *layout = (CALMonthViewLayout*)self.monthView.collectionViewLayout;
    CGFloat itemPad = 2;
    NSInteger sizeWidth = 10, sizeHeight = 10;
    float pad = 5;
    float widthPad = 0;
    float height = 21;
    float width = self.contentView.bounds.size.width;
    float monthLabelPad = 0;
    
    if(self.isMonth)
    {
        itemPad = 10;
        sizeWidth = 30;
        sizeHeight = sizeWidth*2;
        widthPad = 20;
        if(self.month.startDay < 6)
            monthLabelPad = (self.month.startDay * (itemPad + sizeWidth)) + widthPad*3;
        else
            monthLabelPad = widthPad;
    }
    layout.itemSize = CGSizeMake(sizeWidth, sizeHeight);
    layout.minimumInteritemSpacing = itemPad;
    layout.minimumLineSpacing = itemPad*2;
    
    self.monthLabel.frame = CGRectMake(monthLabelPad, pad, width, height);
    height += pad;
    self.monthView.frame = CGRectMake(widthPad, height, width-(widthPad*2), self.contentView.bounds.size.height-(height));
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    if(self.isMonth)
        cell.isMonth = YES;
    if(self.month.startDay == 6)
        [cell setObject:@(indexPath.row+1)];
    else if(indexPath.row > self.month.startDay)
        [cell setObject:@(indexPath.row - self.month.startDay)];
    return cell;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.month.startDay == 6)
        return self.month.daysInMonth.length;
    return self.month.daysInMonth.length + self.month.startDay + 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////

@end
