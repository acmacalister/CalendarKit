////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  DateManager.h
//  iOS Tester
//
//  Created by Austin Cherry on 4/5/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@interface CALDateManager : NSObject

@property(nonatomic, strong, readonly)NSArray *dates;

+ (id)sharedDateManager;

- (void)appendFutureYears;
- (void)appendPastYears;

@end
