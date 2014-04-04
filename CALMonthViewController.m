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

@property(nonatomic, strong)NSArray *items;

@end

#define CELL_ID @"MONTH_CELL"

@implementation CALMonthViewController

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithMonth:(NSArray *)months
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.items = months;
    }
    return self;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"loading month view");
    [self.collectionView registerClass:[CALMonthCell class] forCellWithReuseIdentifier:CELL_ID];
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = self.collectionView.showsHorizontalScrollIndicator = NO;
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    flow.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    [self.collectionView reloadData];
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
    return 12;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////

@end
