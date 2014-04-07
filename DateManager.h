////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DateManager.h
//  iOS Tester
//
//  Created by Austin Cherry on 4/5/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@interface DateManager : NSObject

+ (id)sharedDateManager;

- (void)buildYears;
- (void)appendFutureYears:(NSDate *)date year:(NSInteger)year;
- (void)appendPastYears:(NSDate *)date year:(NSInteger)year;
- (void)buildMonths:(NSDate *)date;

@end
