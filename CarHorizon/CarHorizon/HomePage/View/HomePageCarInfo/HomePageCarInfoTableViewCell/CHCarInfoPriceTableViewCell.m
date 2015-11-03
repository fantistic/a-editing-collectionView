//
//  CHCarInfoPriceTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHCarInfoPriceTableViewCell.h"

@implementation CHCarInfoPriceTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        self.CHImageView = [[UIImageView alloc] init];
        self.CHTitleLabel = [[UILabel alloc] init];
        [self.CHTitleLabel setNumberOfLines:0];//设置分行
        [self.CHTitleLabel setFont:[UIFont systemFontOfSize:15]];
        
        self.CHDiscountLabel = [[UILabel alloc] init];
        [self.CHDiscountLabel setFont:[UIFont systemFontOfSize:13.5]];
        
        self.CHCurrentPriceLabel = [[UILabel alloc] init];
        [self.CHCurrentPriceLabel setFont:[UIFont systemFontOfSize:13.5]];
        
        self.CHTagLabel = [[UILabel alloc] init];
        [self.CHTagLabel setFont:[UIFont systemFontOfSize:13.5]];
        [self.CHTagLabel setTextAlignment:NSTextAlignmentRight];
        
        self.CHRemainLabel = [[UILabel alloc] init];
        [self.CHRemainLabel setFont:[UIFont systemFontOfSize:13.5]];
        
        
//        [self.CHImageView setBackgroundColor:[UIColor redColor]];
//        [self.CHTitleLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHDiscountLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHCurrentPriceLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHTagLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHRemainLabel setBackgroundColor:[UIColor redColor]];
        
        
        [self.contentView addSubview:_CHImageView];
        [self.contentView addSubview:_CHTitleLabel];
        [self.contentView addSubview:_CHDiscountLabel];
        [self.contentView addSubview:_CHCurrentPriceLabel];
        [self.contentView addSubview:_CHTagLabel];
        [self.contentView addSubview:_CHRemainLabel];
        
    }
    
    
    return self;

}


- (void)layoutSubviews{

    [super layoutSubviews];
    
    
    //图片
    [self.CHImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(self.contentView).offset(8);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.8);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.3);
        
    }];
    
    //标题
    [self.CHTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.CHImageView.mas_right).offset(8);
        make.top.equalTo(self.CHImageView.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.3);
    }];
    
    //降价
    [self.CHDiscountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.CHTitleLabel.mas_left);
        make.top.equalTo(self.CHTitleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(100);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.25);
        
    }];
    
    //现价
    [self.CHCurrentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.CHDiscountLabel.mas_bottom).offset(5);
        make.left.equalTo(self.CHTitleLabel.mas_left);
        make.width.mas_equalTo(80);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.25);
    }];
    
    //有无现车
    [self.CHTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.CHDiscountLabel.mas_top);
        make.left.equalTo(self.CHDiscountLabel.mas_right).offset(5);
        make.right.equalTo(self.CHTitleLabel.mas_right);
        make.height.equalTo(self.CHDiscountLabel.mas_height);
        
    }];
    
    //剩余天数
    [self.CHRemainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.CHTitleLabel.mas_right);
        make.top.equalTo(self.CHCurrentPriceLabel.mas_top);
        make.height.equalTo(self.CHCurrentPriceLabel.mas_height);
        
    }];
}

@end
