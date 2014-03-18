////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALDayLayout.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/18/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALDayLayout.h"

@interface CALDayLayout()

@property(nonatomic, strong)NSDictionary *layoutInformation;
@property(nonatomic)NSInteger maxNumRows;
@property(nonatomic)UIEdgeInsets insets;

@end

@implementation CALDayLayout

- (id)init {
    if(self = [super init])
    {
        self.insets = UIEdgeInsetsMake(20.0, 0.0, 20.0, 10.0);
    }
    return self;
}

@end
