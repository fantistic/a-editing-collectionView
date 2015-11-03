//
//  CHComplexPictureTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHComplexPictureTableViewCell.h"

@implementation CHComplexPictureTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.CHLeftImageview = [[UIImageView alloc] init];
        self.CHMediuImageViw = [[UIImageView alloc] init];
        self.ChRightImageView = [[UIImageView alloc] init];
        
        
        [self.CHLeftImageview setBackgroundColor:[UIColor redColor]];
        [self.CHMediuImageViw setBackgroundColor:[UIColor blueColor]];
        [self.ChRightImageView setBackgroundColor:[UIColor purpleColor]];
        
        [self.contentView addSubview:_CHLeftImageview];
        [self.contentView addSubview:_CHMediuImageViw];
        [self.contentView addSubview:_ChRightImageView];
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.CHLeftImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.equalTo(self.CHMediuImageViw);
    }];
    
    [self.CHMediuImageViw mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(self.CHLeftImageview);
        make.left.equalTo(self.CHLeftImageview.mas_right).offset(15);
        make.width.equalTo(self.CHLeftImageview);
    }];
    
    [self.ChRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(self.CHLeftImageview);
        make.left.equalTo(self.CHMediuImageViw.mas_right).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.equalTo(self.CHLeftImageview);
    }];
}

@end
