////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALDayCell.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/24/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALDayCell.h"
#import "CALDayCircleView.h"

@interface CALDayCell ()

@property(nonatomic, strong)UIFontDescriptor *font;
@property(nonatomic, strong)CALDayCircleView *circleView;

@end

@implementation CALDayCell

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.numberLabel = [[UILabel alloc] initWithFrame:frame];
        self.font = [[UIFontDescriptor alloc] initWithFontAttributes:@{}];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        self.circleView = [[CALDayCircleView alloc] init];
        self.circleView.color = [UIColor lightGrayColor];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.circleView];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object
{
    NSNumber *number = (NSNumber*)object;
    self.numberLabel.text = [NSString stringWithFormat:@"%@", number];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger height = self.contentView.frame.size.height;
    NSInteger width = self.contentView.frame.size.width;
    float size = 8.5;
    if(self.isMonth)
        size = 17;
    
    
    self.numberLabel.font = [UIFont fontWithDescriptor:self.font size:size];
    self.numberLabel.frame = CGRectMake(0, 0, width, height/2);
    self.circleView.frame = CGRectMake(0, height/2, width, height/2);
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
