//
//  CollectionViewCell.m
//  CircleLayout
//
//  Created by Mr.Chen on 2017/3/9.
//  Copyright © 2017年 陈凯. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CollectionViewCell

+ (UINib *)nib {
    return [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
}

+ (NSString *)cellId {
    return @"CollectionViewCell";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = 0.5*self.bounds.size.width;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

@end
