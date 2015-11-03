//
//  CHCarInfoComplexTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/21.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHCarInfoComplexTableViewCell.h"

@implementation CHCarInfoComplexTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.CHTitleLabel = [[UILabel alloc] init];
        [self.CHTitleLabel setFont:[UIFont systemFontOfSize:15]];
        
        self.CHDriverLabel = [[UILabel alloc] init];
        [self.CHDriverLabel setFont:[UIFont systemFontOfSize:15]];
        
        self.CHGuidePriceLabel = [[UILabel alloc] init];
        self.CHComparedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.CHComparedButton.layer.borderWidth = 0.3;
        self.CHComparedButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self.CHComparedButton setBackgroundColor:[UIColor orangeColor]];
        [self.CHComparedButton setTitle:@"+对比" forState:UIControlStateNormal];
        [self.CHComparedButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //去对比按钮
        [self.CHComparedButton addTarget:self action:@selector(CHComparedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.CHDistinguishView = [[UIView alloc] init];
        [self.CHDistinguishView setBackgroundColor:[UIColor lightGrayColor]];
        
        [self.contentView addSubview:_CHTitleLabel];
        [self.contentView addSubview:_CHDriverLabel];
        [self.contentView addSubview:_CHGuidePriceLabel];
        [self.contentView addSubview:_CHComparedButton];
        [self.contentView addSubview:_CHDistinguishView];
        
    }
    
    return self;

}


- (void)layoutSubviews{

    [super layoutSubviews];
    
    //标题
    [self.CHTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.right.equalTo(self.contentView).offset(5);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.2);
    }];
    
    //驱动
    [self.CHDriverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.CHTitleLabel);
        make.top.equalTo(self.CHTitleLabel.mas_bottom).offset(5);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.15);
    }];
    
    //指导价
    [self.CHGuidePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
       
        make.left.right.equalTo(self.CHTitleLabel);
        make.top.equalTo(self.CHDriverLabel.mas_bottom).offset(5);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.15);
    }];
    
    //对比
    [self.CHComparedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.left.right.equalTo(self.CHTitleLabel);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.CHGuidePriceLabel.mas_bottom).offset(5);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.2);
    }];
    
    //区分cell的区分色
    [self.CHDistinguishView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.CHComparedButton.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(8);
    }];
}

//按钮的点击方法
- (void)CHComparedButtonClick:(UIButton *)sender{
    
    //发送一个通知去改变去对比按钮的数字
    
    self.complexBlock(self.CHIndexPath);
    
    NSMutableDictionary *message = [NSMutableDictionary dictionary];
    [message setValue:sender forKey:@"CurrentButton"];
    [message setValue:self.CHCarInfoDic forKey:@"CurrentCarMessage"];
    
    //发送一个通知改变去对比按钮的数字
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGENUMBER" object:message];
    
    
}

@end
