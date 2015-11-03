//
//  CHQuotedPriceTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHQuotedPriceTableViewCell.h"

@implementation CHQuotedPriceTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.CHleftImageView = [[UIImageView alloc] init];
        self.CHleftImageView.layer.borderWidth = 0.3;
        self.CHleftImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.CHBrandLabel = [[UILabel alloc] init];
        [self.CHBrandLabel setTextAlignment:NSTextAlignmentLeft];
        [self.CHBrandLabel setFont:[UIFont systemFontOfSize:15]];
        
        self.CHPriceLabel = [[UILabel alloc] init];
        [self.CHPriceLabel setTextAlignment:NSTextAlignmentLeft];
        [self.CHPriceLabel setFont:[UIFont systemFontOfSize:14]];
        
//        [self.CHleftImageView setBackgroundColor:[UIColor redColor]];
//        [self.CHBrandLabel setBackgroundColor:[UIColor purpleColor]];
//        [self.CHPriceLabel setBackgroundColor:[UIColor blueColor]];
        
        [self.contentView addSubview:_CHleftImageView];
        [self.contentView addSubview:_CHBrandLabel];
        [self.contentView addSubview:_CHPriceLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    [self.CHleftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
//        make.width.equalTo(self.CHleftImageView.mas_height);
        make.width.equalTo(self.CHleftImageView.mas_height).multipliedBy(1.5);
    }];
    
    [self.CHBrandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.CHleftImageView.mas_top);
        make.left.equalTo(self.CHleftImageView.mas_right).offset(15);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.35);
    }];
    
    [self.CHPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.CHleftImageView.mas_bottom).offset(-5);
        make.left.equalTo(self.CHBrandLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.35);
    }];
}

@end
