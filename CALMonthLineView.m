////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALMonthLineView.m
//  iOS Tester
//
//  Created by Austin Cherry on 4/9/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALMonthLineView.h"

@interface CALMonthLineView ()

@property(nonatomic)float lineHeight;

@end

@implementation CALMonthLineView

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineHeight = 1;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
            ([UIScreen mainScreen].scale == 2.0))
            self.lineHeight = 0.5;
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1];
        [self addSubview:self.lineView];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
    self.lineView.frame = CGRectMake(0, 0, self.frame.size.width, self.lineHeight);
}
////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)kind
{
    return @"CALMonthLineView";
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
