////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALYearViewController.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/18/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALYearViewController.h"
#import "CALMonth.h"
#import "CALYearCell.h"
#import "CALYear.h"
#import "CALMonth.h"
#import "CALMonthViewController.h"
#import "CALDateManager.h"
#import "CALTransitionController.h"

@interface CALYearViewController ()<UINavigationControllerDelegate, CALTransitionControllerDelegate>

@property(nonatomic, assign)BOOL isFirst;
@property(nonatomic, strong)CALDateManager *dateManager;
@property (nonatomic) CALTransitionController *transitionController;

@end

#define MAX_COUNT 200
#define CELL_ID @"YEAR_CELL"
#define OFFSET 160

@implementation CALYearViewController

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (UINavigationController *)calNavController
{
    CALYearViewController *yearVC = [CALYearViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:yearVC];
    navigationController.delegate = yearVC;
    return navigationController;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.dateManager = [CALDateManager sharedDateManager];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isFirst = YES;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CALYearCell class] forCellWithReuseIdentifier:CELL_ID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = self.collectionView.showsHorizontalScrollIndicator = NO;
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    flow.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.collectionView.contentOffset = CGPointMake(0, (self.view.frame.size.height * 5) + OFFSET + self.view.frame.size.height/2);
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.isFirst = NO;
}
////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UICollectionView

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALYearCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    CALYear *year = self.dateManager.dates[indexPath.row];
    cell.delegate = (id<CALYearCellDelegate>)self;
    [cell setObject:year];
    return cell;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dateManager.dates.count;
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
    self.transitionController = [[CALTransitionController alloc] initWithCollectionView:monthVC.collectionView];
    self.transitionController.delegate = self;
    
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
        [self.dateManager appendFutureYears];
        [self.collectionView reloadData];
    }
    else if(scrollView.contentOffset.y < self.view.frame.size.height/2 && scrollView.contentOffset.y > 0)
    {
        [self.dateManager appendPastYears];
        [self.collectionView reloadData];
        CGPoint point = scrollView.contentOffset;
        point.y += ((self.view.frame.size.height * 5) + OFFSET + self.view.frame.size.height/2);
        [scrollView setContentOffset:point animated:NO];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UINavigationDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
//More Apple example to fix
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (animationController == self.transitionController)
    {
        return self.transitionController;
    }
    return nil;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (![fromVC isKindOfClass:[UICollectionViewController class]] || ![toVC isKindOfClass:[UICollectionViewController class]])
    {
        return nil;
    }
    if (!self.transitionController.hasActiveInteraction)
    {
        return nil;
    }
    
    self.transitionController.navigationOperation = operation;
    return self.transitionController;
}
////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - CALTransitionControllerDelegate

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)interactionBeganAtPoint:(CGPoint)p
{
    // Very basic communication between the transition controller and the top view controller
    // It would be easy to add more control, support pop, push or no-op
    CALBaseViewController *presentingVC = (CALBaseViewController*)[self.navigationController topViewController];
    CALBaseViewController *presentedVC = (CALBaseViewController *)[presentingVC nextViewControllerAtPoint:p];
    if (presentedVC!=nil)
    {
        [self.navigationController pushViewController:presentedVC animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end