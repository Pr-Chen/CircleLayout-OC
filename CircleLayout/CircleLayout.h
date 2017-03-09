//
//  CircleLayout.h
//  CircleLayout
//
//  Created by 陈凯 on 2017/3/7.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SortDirection) {
    SortDirectionClockwise,
    SortDirectionCounterClockwise,
};


@interface CircleLayout : UICollectionViewLayout

//转动半径
@property (nonatomic, assign) CGFloat radius;

//圆心位置(取值为相对collectionView的size，如（0.5，0.5）表示中心点)
@property (nonatomic, assign) CGPoint centrePosition;

//cell夹角
@property (nonatomic, assign) CGFloat angleBetweenItem;

//cell的尺寸
@property (nonatomic, assign) CGSize itemSize;

//缩放率
//@property (nonatomic, assign) CGFloat scale;

//开始角度
@property (nonatomic, assign) CGFloat startAngle;

//结束角度
@property (nonatomic, assign) CGFloat endAngle;

//排列方向
@property (nonatomic, assign) SortDirection sortDirection;

@end
