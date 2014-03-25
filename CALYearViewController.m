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

@interface CALYearViewController ()

@property(nonatomic, strong)NSMutableArray *items;
@property(nonatomic, strong)NSCalendar *calendar;
@property(nonatomic, strong)NSDateComponents *comps;

@end

#define MAX_COUNT 200
#define CELL_ID @"YEAR_CELL"

@implementation CALYearViewController

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.items = [NSMutableArray array];
        self.calendar = [NSCalendar currentCalendar];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self.collectionView registerClass:[CALYearCell class] forCellWithReuseIdentifier:CELL_ID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    flow.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    [self buildYears];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)buildYears
{
    NSDate *date = [NSDate date];
    self.comps = [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSInteger currentYear = [self.comps year];
    [self appendPastYears:date year:currentYear];
    [self.comps setYear:currentYear];
    [self buildMonths:date];
    [self appendFutureYears:date year:currentYear];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)appendFutureYears:(NSDate *)date year:(NSInteger)year
{
    for(int i = 1; i <= 6; i++)
    {
        [self.comps setYear:year + i];
        [self buildMonths:date];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)appendPastYears:(NSDate *)date year:(NSInteger)year
{
    for(int i = -6; i < 0; i++)
    {
        [self.comps setYear:year + i];
        [self buildMonths:date];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)buildMonths:(NSDate *)date
{
    NSMutableArray *months = [NSMutableArray array];
    for(int j = 1; j <= 12; j++)
    {
        CALMonth *month = [CALMonth new];
        [self.comps setDay:1];
        [self.comps setMonth:j];
        month.month = j;
        month.year = [self.comps year];
        date = [self.calendar dateFromComponents:self.comps];
        month.date = date;
        month.daysInMonth = [self.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
        NSInteger weekdayOfDate = [self.calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
        month.startDay = weekdayOfDate - 1;
        [months addObject:month];
    }
    
    [self.items addObject:[CALYear createYear:@([self.comps year]) months:[months copy]]];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALYearCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    CALYear *year = self.items[indexPath.row];
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
@end
