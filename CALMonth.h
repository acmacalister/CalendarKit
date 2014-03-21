////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALMonth.h
//  iOS Tester
//
//  Created by Austin Cherry on 3/21/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@interface CALMonth : NSObject

@property(nonatomic)NSRange daysInMonth;
@property(nonatomic)NSInteger startDay;
@property(nonatomic)NSInteger month;
@property(nonatomic)NSInteger year;
@property(nonatomic, strong)NSDate *date;

@end
