////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALMonthViewController.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/28/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALMonthViewController.h"
#import "CALMonthCell.h"
#import "CALMonth.h"
#import "CALMonthLineView.h"

@interface CALMonthViewController ()<UIToolbarDelegate>

@property(nonatomic, strong)CALMonth *month;
@property(nonatomic, strong)UIToolbar *dayFooter;

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
    //flow.minimumInteritemSpacing = 10;
    //flow.minimumLineSpacing = 10;
    
    self.dayFooter = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, 10)];
    self.dayFooter.delegate = self;
    self.dayFooter.items = [self footerItems];
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview:self.dayFooter];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.dayFooter removeFromSuperview];
}
////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - CollectionView Methods

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    cell.isMonth = YES;
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

#pragma mark - UIToolBarDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray *)footerItems
{
    NSInteger num = 7;
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:num*2];
    NSArray *days = @[@"S", @"M", @"T", @"W", @"T", @"F", @"S"];
    
    NSDictionary *buttonAttrs = @{
                                  NSFontAttributeName: [UIFont fontWithDescriptor:[UIFontDescriptor fontDescriptorWithFontAttributes:@{}] size:11],
                                  NSForegroundColorAttributeName: [UIColor blackColor]
                                };
    for(int i = 0; i < num; i++) {
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:days[i] style:UIBarButtonItemStyleBordered target:nil action:nil];
        [barButton setTitleTextAttributes:buttonAttrs forState:UIControlStateNormal];
        [items addObject:barButton];
        barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [items addObject:barButton];
    }
    
    return [items copy];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
