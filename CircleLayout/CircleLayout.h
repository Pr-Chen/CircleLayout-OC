//
//  CircleLayout.h
//  CircleLayout
//
//  Created by 陈凯 on 2017/3/7.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RotateDirection) {
    RotateDirectionClockwise,
    RotateDirectionCounterClockwise,
};


@interface CircleLayout : UICollectionViewLayout

//转动半径
@property (nonatomic, assign) CGFloat radius;

//圆心位置
//@property (nonatomic, assign) CGPoint centrePosition;

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

//滚动方向
//@property (nonatomic, assign) RotateDirection rotateDirection;


@end
