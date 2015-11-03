
//
//  CHCarInfoPictureCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHCarInfoPictureCollectionViewCell.h"

@implementation CHCarInfoPictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.CHImageView = [[UIImageView alloc] init];
        self.CHImageView.layer.cornerRadius = 3;
        self.CHImageView.layer.borderWidth = 0.3;
        self.CHImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_CHImageView];
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    
    NSLog(@"%f",self.contentView.bounds.size.width);
    //图片
    [self.CHImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self.contentView);
    }];
}

@end
