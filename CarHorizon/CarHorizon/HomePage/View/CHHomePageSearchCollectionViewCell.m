//
//  CHHomePageSearchCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/17.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageSearchCollectionViewCell.h"

@implementation CHHomePageSearchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.CHRecommendLabel = [[UILabel alloc] init];
        self.CHRecommendLabel.textAlignment = NSTextAlignmentCenter;
//        [self.CHRecommendLabel setBackgroundColor:[UIColor redColor]];
        self.CHtopImageview = [[UIImageView alloc] init];
        
//        [self.CHtopImageview setBackgroundColor:[UIColor orangeColor]];
        
        [self.contentView addSubview:_CHRecommendLabel];
        [self.contentView addSubview:_CHtopImageview];
        
        self.bottomLine = [[UIView alloc] init];
        self.centerLiner = [[UIView alloc] init];
        
        [self.bottomLine setBackgroundColor:[UIColor lightGrayColor]];
        [self.centerLiner setBackgroundColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_bottomLine];
        [self.contentView addSubview:_centerLiner];
        
    }

    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.CHRecommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self.contentView);
    }];
    
    [self.CHtopImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.CHRecommendLabel);
        make.right.equalTo(self.CHRecommendLabel.mas_right).offset(-5);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.left.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.centerLiner mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.contentView.mas_height);
        make.width.mas_equalTo(0.5);
    }];
}
@end
