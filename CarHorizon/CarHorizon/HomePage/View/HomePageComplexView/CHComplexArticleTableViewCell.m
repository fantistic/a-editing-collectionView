//
//  CHComplexArticleTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHComplexArticleTableViewCell.h"

@implementation CHComplexArticleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.CHTitleLabel = [[UILabel alloc] init];
        self.CHTimeLabel = [[UILabel alloc] init];
        [self.CHTimeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.CHTimeLabel setFont:[UIFont systemFontOfSize:14]];
        self.CHCategoryLabel = [[UILabel alloc] init];
        [self.CHCategoryLabel setTextAlignment:NSTextAlignmentRight];
        [self.CHCategoryLabel setFont:[UIFont systemFontOfSize:14]];
        
//        [self.CHTitleLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHTimeLabel setBackgroundColor:[UIColor redColor]];
//        [self.CHCategoryLabel setBackgroundColor:[UIColor redColor]];
        
        [self.contentView addSubview:_CHTitleLabel];
        [self.contentView addSubview:_CHTimeLabel];
        [self.contentView addSubview:_CHCategoryLabel];
    }
    
    return self;
}


- (void)layoutSubviews{

    [super layoutSubviews];
    
    [self.CHTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
    }];
    
    [self.CHTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.CHTitleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.mas_equalTo(150);
    }];
    
    [self.CHCategoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.CHTimeLabel.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.CHTimeLabel);
        make.width.mas_equalTo(100);
    }];
}

@end
