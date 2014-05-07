////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALMonthViewLayout.m
//  iOS Tester
//
//  Created by Austin Cherry on 4/10/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALMonthViewLayout.h"
#import "CALMonthLineView.h"

@interface CALMonthViewLayout ()

@property(nonatomic, strong)NSDictionary *lineRects;

@end

@implementation CALMonthViewLayout

////////////////////////////////////////////////////////////////////////////////////////////////////
- (instancetype)init
{
    if(self = [super init])
    {
        [self registerClass:[CALMonthLineView class] forDecorationViewOfKind:[CALMonthLineView kind]];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareLayout
{
    [super prepareLayout];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    // Calculate where shelves go in a vertical layout
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    CGFloat y = 0;
    CGFloat availableWidth = self.collectionViewContentSize.width - (self.sectionInset.left + self.sectionInset.right);
    int itemsAcross = floorf((availableWidth + self.minimumInteritemSpacing) / (self.itemSize.width + self.minimumInteritemSpacing));
    
    for (int section = 0; section < sectionCount; section++)
    {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        int rows = ceilf(itemCount/(float)itemsAcross);
        for (int row = 0; row < rows; row++)
        {
            dictionary[[NSIndexPath indexPathForItem:row inSection:section]] = [NSValue valueWithCGRect:CGRectMake(0, y, self.collectionViewContentSize.width, 0)];
            y += self.itemSize.height;
            
            if (row < rows - 1)
                y += self.minimumLineSpacing;
        }
    }
    
    self.lineRects = [NSDictionary dictionaryWithDictionary:dictionary];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
// Return attributes of all items (cells, supplementary views, decoration views) that appear within this rect
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // call super so flow layout can return default attributes for all cells, headers, and footers
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // tweak the attributes slightly
    for (UICollectionViewLayoutAttributes *attributes in array)
    {
        attributes.zIndex = 1;

        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal && attributes.representedElementCategory == UICollectionElementCategorySupplementaryView)
        {
            // make label vertical if scrolling is horizontal
            attributes.transform3D = CATransform3DMakeRotation(-90 * M_PI / 180, 0, 0, 1);
            attributes.size = CGSizeMake(attributes.size.height, attributes.size.width);
        }
    }
    
    //Add our decoration views (shelves)
    NSMutableArray *newArray = [array mutableCopy];
    
    [self.lineRects enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (CGRectIntersectsRect([obj CGRectValue], rect))
        {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:[CALMonthLineView kind] withIndexPath:key];
            attributes.frame = [obj CGRectValue];
            attributes.zIndex = 0;
            [newArray addObject:attributes];
        }
    }];
    
    array = [NSArray arrayWithArray:newArray];
    
    return array;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
