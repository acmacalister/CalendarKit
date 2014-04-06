////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALMonthViewController.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/28/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALMonthViewController.h"
#import "CALMonthCell.h"
#import "CALMonth.h"

@interface CALMonthViewController ()

@property(nonatomic, strong)CALMonth *month;

@end

#define CELL_ID @"MONTH_CELL"

@implementation CALMonthViewController

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithMonth:(CALMonth *)month
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.month = month;
    }
    return self;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[CALMonthCell class] forCellWithReuseIdentifier:CELL_ID];
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = self.collectionView.showsHorizontalScrollIndicator = NO;
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    flow.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    [cell setObject:self.month];
    return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////

@end
