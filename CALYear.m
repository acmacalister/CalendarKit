////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALYear.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/24/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALYear.h"

@implementation CALYear

+ (instancetype)createYear:(NSNumber *)currentYear months:(NSArray *)array
{
    CALYear *year = [self new];
    year.currentYear = currentYear;
    year.months = array;
    
    return year;
}

@end
