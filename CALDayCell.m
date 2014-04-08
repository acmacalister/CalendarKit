////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALDayCell.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/24/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALDayCell.h"

@interface CALDayCell ()

@property(nonatomic, strong)UIFontDescriptor *font;

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
        [self.contentView addSubview:self.numberLabel];
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
    
    float size = 8.5;
    if(self.isMonth)
        size = 17;
    
    self.numberLabel.font = [UIFont fontWithDescriptor:self.font size:size];
    self.numberLabel.frame = self.contentView.bounds;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
