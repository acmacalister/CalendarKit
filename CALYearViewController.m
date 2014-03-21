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

@interface CALYearViewController ()

@property(nonatomic, strong)NSMutableArray *items;
@property(nonatomic, strong)NSCalendar *calendar;
@property(nonatomic, strong)NSDateComponents *comps;

@end

#define MAX_COUNT 200
#define CELL_ID @"CELL_ID"

@implementation CALYearViewController

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
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
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
    [self buildYears];
    
//    NSDate *date = [NSDate date];
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSDateComponents *comps = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
//    NSInteger currentYear = [comps year];
//    
//    for(int i = -6; i <= 6; i++)
//    {
//        comps = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
//        [comps setYear:currentYear + i];
//        
//        for(int j = 0; j <= 11; j++)
//        {
//            
//            [comps setDay:1];
//            [comps setMonth:j];
//            date = [cal dateFromComponents:comps];
//            NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
//            NSLog(@"range location %lu, length %lu", range.location, range.length);
//            
//            NSLog(@"date is: %@", date);
//            
//            NSInteger weekdayOfDate = [cal ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
//            NSInteger numberOfDaysToStartOfCurrentWeek = weekdayOfDate - 1;
//            
//            NSLog(@"Month start day: %lu", numberOfDaysToStartOfCurrentWeek);
//        }
//    }

}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)buildYears
{
    NSDate *date = [NSDate date];
    self.comps = [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSInteger currentYear = [self.comps year];
    [self appendPastYears:date year:currentYear];
    [self appendFutureYears:date year:currentYear];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)appendFutureYears:(NSDate *)date year:(NSInteger)year
{
    for(int i = 0; i < 6; i++)
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
    for(int j = 0; j <= 11; j++)
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
    [self.items addObject:months];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    UIColor* cellColor = [UIColor colorWithHue:drand48() saturation:1.0 brightness:1.0 alpha:1.0];
    cell.contentView.backgroundColor = cellColor;
    return cell;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"item count: %lu", self.items.count);
    return self.items.count;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
