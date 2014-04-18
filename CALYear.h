////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALYear.h
//  iOS Tester
//
//  Created by Austin Cherry on 3/24/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@interface CALYear : NSObject

@property(nonatomic, strong)NSNumber *currentYear;
@property(nonatomic, strong)NSArray *months;

+ (instancetype)createYear:(NSNumber *)currentYear months:(NSArray *)array;

@end
