//
//  CHHomePageTypeOneTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/15.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageTypeOneTableViewCell.h"

@implementation CHHomePageTypeOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.CHLeftImageview = [[UIImageView alloc] init];
//        [self.CHLeftImageview setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_CHLeftImageview];
        
        self.CHTitleLabel = [[UILabel alloc] init];
//        [self.CHTitleLabel setBackgroundColor:[UIColor redColor]];
        [self.CHTitleLabel setNumberOfLines:0];
        [self.CHTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:_CHTitleLabel];
        
        self.CHTimeLabel = [[UILabel alloc] init];
//        [self.CHTimeLabel setBackgroundColor:[UIColor redColor]];
        [self.CHTimeLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_CHTimeLabel];
        
        self.CHMessageIcon = [[UIImageView alloc] init];
//        [self.CHMessageIcon setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_CHMessageIcon];
        
        self.CHMessageLabel = [[UILabel alloc] init];
//        [self.CHMessageLabel setBackgroundColor:[UIColor redColor]];
        [self.CHMessageLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_CHMessageLabel];
        
        self.CHNewsLabel = [[UILabel alloc] init];
//        [self.CHNewsLabel setBackgroundColor:[UIColor redColor]];
        [self.CHNewsLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_CHNewsLabel];
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.CHLeftImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.bottom.equalTo(self.contentView).offset(10);
        make.width.equalTo(self.CHLeftImageview.mas_height).multipliedBy(1.2);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.CHTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.CHLeftImageview.mas_right).offset(10);
        make.top.equalTo(self.CHLeftImageview.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.5);
    }];
    
    [self.CHTimeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.CHTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.CHLeftImageview.mas_right).offset(10);
        make.top.equalTo(self.CHTitleLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        
    }];
    
    [self.CHMessageIcon setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.CHMessageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.CHTimeLabel.mas_right).offset(15);
        make.top.equalTo(self.CHTitleLabel.mas_bottom).offset(15);
    }];
    
    [self.CHMessageLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.CHMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.CHMessageIcon.mas_right).offset(5);
        make.top.bottom.equalTo(self.CHMessageIcon);
        
    }];
    
    [self.CHNewsLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.CHNewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.top.equalTo(self.CHTitleLabel.mas_bottom).offset(15);
    }];
    
}

@end
