//
//  CircleLayout.m
//  CircleLayout
//
//  Created by 陈凯 on 2017/3/7.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import "CircleLayout.h"

@interface CircleLayout ()

@property (strong, nonatomic) NSMutableArray *rectAttributes;

@end

@implementation CircleLayout

- (instancetype)init {
    
    if (self = [super init]) {
        [self defaultSetup];
    }
    return self;
}

- (void)defaultSetup {
    self.radius = 200.0;
    self.angleBetweenItem = M_PI/5;
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
    CGFloat centerX = self.collectionView.contentOffset.x + 0.5*CGRectGetWidth(self.collectionView.bounds);
    CGFloat centerY = CGRectGetMidY(self.collectionView.frame);
    
    CGFloat startAngle = self.collectionView.contentOffset.x/[self collectionViewContentSize].width*([self.collectionView numberOfItemsInSection:0]-1)*self.angleBetweenItem;
    CGFloat angle = startAngle+indexPath.item*self.angleBetweenItem;
    CGFloat x = centerX + self.radius*cos(angle+M_PI);
    CGFloat y = centerY - self.radius*sin(angle);
    attribute.center = CGPointMake(x, y);
    attribute.size = self.itemSize;
    attribute.transform = CGAffineTransformMakeRotation(angle);
    
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return [self attributesInRect:rect];
}

- (NSArray *)attributesInRect:(CGRect)rect {
    
    CGFloat spacing = self.radius*sin(self.angleBetweenItem);
    NSInteger preIndex = rect.origin.x/spacing;
    preIndex = preIndex<0 ? 0 : preIndex;
    
    NSInteger latIndex = CGRectGetMaxX(rect)/spacing;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger minCount = MIN(itemCount, 2*M_PI/self.angleBetweenItem);
    latIndex = latIndex>=minCount ? minCount-1 : latIndex;
    
    [self.rectAttributes removeAllObjects];
    for (NSInteger i=0; i<=latIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [self.rectAttributes addObject:attribute];
        }
    }
    
    return self.rectAttributes;
}

- (NSMutableArray *)rectAttributes {
    
    if (!_rectAttributes) {
        _rectAttributes = [NSMutableArray array];
    }
    return _rectAttributes;
}

@end
