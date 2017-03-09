//
//  CollectionViewCell.h
//  CircleLayout
//
//  Created by Mr.Chen on 2017/3/9.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) NSString *title;

+ (UINib *)nib;
+ (NSString *)cellId;

@end
