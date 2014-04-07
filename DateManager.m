////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DateManager.m
//  iOS Tester
//
//  Created by Austin Cherry on 4/5/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "DateManager.h"
#import "CALYear.h"
#import "CALMonth.h"

@interface DateManager ()

@property(nonatomic, strong)NSMutableArray *dates;
@property(nonatomic, strong)NSCalendar *calendar;
@property(nonatomic, strong)NSDateComponents *comps;

@end

@implementation DateManager

- (id)init
{
    if(self = [super init])
    {
        self.calendar = [NSCalendar currentCalendar];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)sharedDateManager
{
    static dispatch_once_t once;
    static DateManager *sharedDateManager;
    dispatch_once(&once, ^{
        sharedDateManager = [[self alloc] init];
    });
    return sharedDateManager;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)buildYears
{
    //self.isFirst = YES;
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
    
    [self.dates addObject:[CALYear createYear:@([self.comps year]) months:[months copy]]];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
