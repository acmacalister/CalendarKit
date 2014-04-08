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

@property(nonatomic, strong)NSMutableArray *items;
@property(nonatomic, strong)NSCalendar *calendar;
@property(nonatomic, strong)NSDateComponents *comps;
@property(nonatomic, strong)NSDate *now;
@property(nonatomic)NSInteger currentYear;
@property(nonatomic)NSInteger lastPastYear;
@property(nonatomic)NSInteger lastFutureYear;
@property(nonatomic)BOOL isFirst;

@end

@implementation DateManager

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init
{
    if(self = [super init])
    {
        self.calendar = [NSCalendar currentCalendar];
        self.items = [NSMutableArray array];
        self.isFirst = YES;
        [self buildYears];
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
    self.now = [NSDate date];
    self.comps = [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self.now];
    self.currentYear = [self.comps year];
    self.lastFutureYear = (self.currentYear + 6);
    self.lastPastYear = (self.currentYear - 6);
    [self appendPastYears];
    [self.comps setYear:self.currentYear];
    [self buildMonths:self.now future:YES];
    [self appendFutureYears];
    self.isFirst = NO;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)appendFutureYears
{
    for(int i = 1; i <= 6; i++)
    {
        if(self.isFirst)
        {
            [self.comps setYear:self.currentYear + i];
            [self buildMonths:self.now future:YES];
        }
        else
        {
            [self.comps setYear:self.lastFutureYear += 1];
            [self buildMonths:self.now future:YES];
            //[self.items removeObjectAtIndex:0];
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)appendPastYears
{
    for(int i = -6; i < 0; i++)
    {
        if(self.isFirst)
        {
            [self.comps setYear:self.currentYear + i];
            [self buildMonths:self.now future:YES];
        }
        else
        {
            [self.comps setYear:self.lastPastYear -= 1];
            [self buildMonths:self.now future:NO];
            //[self.items removeObjectAtIndex:self.items.count-1];
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)buildMonths:(NSDate *)date future:(BOOL)future
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
    
    if(future)
        [self.items addObject:[CALYear createYear:@([self.comps year]) months:[months copy]]];
    else
        [self.items insertObject:[CALYear createYear:@([self.comps year]) months:[months copy]] atIndex:0];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray *)dates
{
    return [self.items copy];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
