//
//  CHComplexPostsTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHComplexPostsTableViewCell.h"

@implementation CHComplexPostsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.CHTitleLabel = [[UILabel alloc] init];
        self.CHTimeLabel = [[UILabel alloc] init];
        [self.CHTimeLabel setFont:[UIFont systemFontOfSize:14]];
        self.CHAuthorLabel = [[UILabel alloc] init];
        [self.CHAuthorLabel setFont:[UIFont systemFontOfSize:14]];
        self.CHImageView = [[UIImageView alloc] init];
        self.CHReplyNumLabel = [[UILabel alloc] init];
        [self.CHReplyNumLabel setFont:[UIFont systemFontOfSize:14]];
        
//        [self.CHAuthorLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHTimeLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHAuthorLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHImageView setBackgroundColor:[UIColor redColor]];
//        [self.CHReplyNumLabel setBackgroundColor:[UIColor redColor]];
        
        
        [self.contentView addSubview:_CHTitleLabel];
        [self.contentView addSubview:_CHTimeLabel];
        [self.contentView addSubview:_CHAuthorLabel];
        [self.contentView addSubview:_CHImageView];
        [self.contentView addSubview:_CHReplyNumLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    [self.CHTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.5);
    }];
    
    [self.CHTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.CHTitleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.CHTitleLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.mas_equalTo(100);
    }];
    
    [self.CHAuthorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.CHTimeLabel.mas_right).offset(25);
        make.top.bottom.equalTo(self.CHTimeLabel);
        make.width.mas_equalTo(100);
    }];
    
    [self.CHImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(self.CHTimeLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.width.mas_equalTo(20);
    }];
    
    [self.CHReplyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(self.CHTimeLabel);
        make.left.equalTo(self.CHImageView.mas_right).offset(5);
        
    }];
}

@end
