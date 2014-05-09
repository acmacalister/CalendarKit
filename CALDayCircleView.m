////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALMonthCircleView.m
//  iOS Tester
//
//  Created by Austin Cherry on 5/9/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALDayCircleView.h"

@implementation CALDayCircleView

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.padding = 10;
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, self.padding, self.padding)].CGPath;
    CGContextAddPath(ctx, path);
    CGContextClip(ctx);
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextFillRect(ctx, self.bounds);
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
