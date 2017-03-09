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
    self.centrePosition = CGPointMake(0.5, 0.5);
    self.sortDirection = SortDirectionCounterClockwise;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    
    //需要根据可见角度来设置ContentSize, 当可见角度在竖直方向时ContentSize需要设置竖直方向的尺寸
    CGFloat width = [self.collectionView numberOfItemsInSection:0] * self.radius * sin(self.angleBetweenItem);
    return CGSizeMake(width, self.collectionView.bounds.size.height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat centreX = self.collectionView.contentOffset.x + self.centrePosition.x*CGRectGetWidth(self.collectionView.bounds);
    CGFloat centreY = self.collectionView.frame.origin.y + self.centrePosition.y*self.collectionView.bounds.size.height;
    
    CGFloat contentWidth = [self collectionViewContentSize].width;
    CGFloat itemCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat firstItemAngle = 0.0;
    if (self.sortDirection == SortDirectionClockwise) {
        firstItemAngle = self.endAngle - self.collectionView.contentOffset.x/contentWidth*(itemCount-1)*self.angleBetweenItem;
    }
    else {
        firstItemAngle = self.startAngle + self.collectionView.contentOffset.x/contentWidth*(itemCount-1)*self.angleBetweenItem;
    }
    CGFloat angle = firstItemAngle+indexPath.item*self.angleBetweenItem;
    
    CGFloat offsetAngle = self.sortDirection==SortDirectionClockwise ? M_PI : 0;
    CGFloat x = centreX + self.radius*cos(angle-offsetAngle);
    CGFloat y = centreY - self.radius*sin(angle);
    
    attribute.center = CGPointMake(x, y);
    attribute.size = self.itemSize;
    attribute.transform = CGAffineTransformMakeRotation(-angle+self.startAngle);
    
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return [self attributesInRect:rect];
}

- (NSArray *)attributesInRect:(CGRect)rect {
    
    CGFloat spacing = self.radius*sin(self.angleBetweenItem);
    NSInteger firstIndex = rect.origin.x/spacing;
    firstIndex = firstIndex<0 ? 0 : firstIndex;
    
    NSInteger lastIndex = CGRectGetMaxX(rect)/spacing;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger minCount = MIN(itemCount, ceilf(2*M_PI/self.angleBetweenItem));
    lastIndex = lastIndex>=minCount ? firstIndex+minCount-1 : lastIndex;
    
    [self.rectAttributes removeAllObjects];
    for (NSInteger i=firstIndex; i<=lastIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.rectAttributes addObject:attribute];
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
