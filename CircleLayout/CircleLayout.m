//
//  CircleLayout.m
//  CircleLayout
//
//  Created by 陈凯 on 2017/3/7.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import "CircleLayout.h"

@implementation CircleLayout

- (instancetype)init {
    
    if (self = [super init]) {
        [self defaultSetup];
    }
    return self;
}

- (void)defaultSetup {
    self.radius = 200.0;
    self.angleBetweenItem = M_PI/6;
    self.itemSize = CGSizeMake(50, 50);
    self.startAngle = 0;
    self.endAngle = M_PI;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    
    //需要根据可见角度来设置ContentSize, 当可见角度在竖直方向时ContentSize需要设置竖直方向的尺寸
    CGFloat width = [self.collectionView numberOfItemsInSection:0] *self.radius*sin(self.angleBetweenItem);
    return CGSizeMake(width, self.collectionView.bounds.size.height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat centerX = self.collectionView.contentOffset.x + 0.5*self.collectionView.bounds.size.width;
    CGFloat centerY = self.collectionView.contentOffset.y + 0.5*self.collectionView.bounds.size.height;
    CGFloat angle = -M_PI_2-indexPath.item*self.angleBetweenItem;
    CGFloat x = centerX + self.radius*cos(-angle-M_PI_2);
    CGFloat y = centerY - self.radius*sin(-angle);
    attribute.center = CGPointMake(x, y);
    attribute.transform = CGAffineTransformMakeRotation(angle);
    
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    
    return [super layoutAttributesForElementsInRect:rect];
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    
    return CGPointZero;
}

@end
