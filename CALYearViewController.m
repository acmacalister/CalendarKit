////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALYearViewController.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/18/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALYearViewController.h"
#import "CALMonth.h"
#import "CALYearCell.h"
#import "CALYear.h"
#import "CALMonth.h"
#import "CALMonthViewController.h"
#import "DateManager.h"

@interface CALYearViewController ()

@property(nonatomic, strong)NSMutableArray *items;

@property(nonatomic, assign)BOOL isFirst;

@end

#define MAX_COUNT 200
#define CELL_ID @"YEAR_CELL"

@implementation CALYearViewController

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (UINavigationController *)CALNavigationController
{
    CALYearViewController *yearVC = [CALYearViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:yearVC];
    return navigationController;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CALYearCell class] forCellWithReuseIdentifier:CELL_ID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = self.collectionView.showsHorizontalScrollIndicator = NO;
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    flow.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    
    DateManager *dateManager = [DateManager sharedDateManager];
    [dateManager buildYears];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.isFirst = NO;
    [self.collectionView reloadData];
}
////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UICollectionView

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALYearCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    CALYear *year = self.items[indexPath.row];
    cell.delegate = (id<CALYearCellDelegate>)self;
    [cell setObject:year];
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

#pragma mark - CALYearCellDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)didSelectMonth:(CALMonth*)month
{
    CALMonthViewController *monthVC = [[CALMonthViewController alloc] initWithMonth:month];
    //monthVC.useLayoutToLayoutNavigationTransitions = YES;
    
    [self.navigationController pushViewController:monthVC animated:YES];
}
////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - ScrollView

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.isFirst)
        return;
    
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height/2)
    {
        for(int i = 0; i < 2; i++)
            [self.items removeObjectAtIndex:0];
        DateManager *dateManager = [DateManager sharedDateManager];
        [dateManager appendFutureYears:[NSDate date] year:2013];
        [self.collectionView reloadData];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end