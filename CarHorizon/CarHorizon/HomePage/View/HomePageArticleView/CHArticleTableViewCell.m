//
//  CHArticleTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHArticleTableViewCell.h"

@implementation CHArticleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.CHTitleLabel = [[UILabel alloc] init];
        self.CHDescLabel = [[UILabel alloc] init];
        [self.CHDescLabel setNumberOfLines:0];
        self.CHTimeLabel = [[UILabel alloc] init];
        [self.CHTimeLabel setTextAlignment:NSTextAlignmentLeft];
        self.CHCategoryLabel = [[UILabel alloc] init];
        [self.CHCategoryLabel setTextAlignment:NSTextAlignmentRight];
        
//        [self.CHTitleLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHDescLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHTimeLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHCategoryLabel setBackgroundColor:[UIColor redColor]];
        
        [self.contentView addSubview:_CHTitleLabel];
        [self.contentView addSubview:_CHDescLabel];
        [self.contentView addSubview:_CHTimeLabel];
        [self.contentView addSubview:_CHCategoryLabel];
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    [self.CHTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.2);
    }];
    
    [self.CHDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.CHTitleLabel);
        make.top.equalTo(self.CHTitleLabel.mas_bottom).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.4);
    }];
    
    [self.CHTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.CHTitleLabel);
        make.top.equalTo(self.CHDescLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.mas_equalTo(120);
    }];
    
    [self.CHCategoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(self.CHTimeLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(120);
    }];
}

@end
