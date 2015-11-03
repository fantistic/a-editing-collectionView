//
//  CHHomePageSearchTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/17.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageSearchTableViewCell.h"

@implementation CHHomePageSearchTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.CHtopLeftImageview = [[UIImageView alloc] init];
        [self.CHtopLeftImageview setBackgroundColor:[UIColor redColor]];
        self.CHRecommendLeftLabel = [[UILabel alloc] init];
        [self.CHRecommendLeftLabel setTextAlignment:NSTextAlignmentCenter];
        
        self.CHtopRightImageview = [[UIImageView alloc] init];
        [self.CHtopRightImageview setBackgroundColor:[UIColor orangeColor]];
        self.CHRecommendRightLabel = [[UILabel alloc] init];
        
        self.bottomLine = [[UIView alloc] init];
        [self.bottomLine setBackgroundColor:[UIColor lightGrayColor]];
        self.centerLiner = [[UIView alloc] init];
        [self.centerLiner setBackgroundColor:[UIColor lightGrayColor]];
        
        [self.contentView addSubview:_CHtopLeftImageview];
        [self.contentView addSubview:_CHRecommendLeftLabel];
        [self.contentView addSubview:_CHRecommendRightLabel];
        [self.contentView addSubview:_CHtopRightImageview];
        
        [self.contentView addSubview:_bottomLine];
        [self.contentView addSubview:_centerLiner];
    }
    
    return self;
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.CHRecommendLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.height.bottom.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
    }];
    
    [self.CHtopLeftImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.equalTo(self.CHRecommendLeftLabel);
        make.width.height.mas_equalTo(15);
        
    }];
    
    [self.CHRecommendRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.bottom.height.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
    }];
    
    [self.CHtopRightImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.equalTo(self.CHRecommendRightLabel);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.mas_bottom);
        
        make.height.mas_equalTo(0.3);
        make.right.left.equalTo(self.contentView);
    }];
    
    [self.centerLiner mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.equalTo(self.contentView.mas_height);
        make.width.mas_equalTo(0.5);
    }];
}

@end
