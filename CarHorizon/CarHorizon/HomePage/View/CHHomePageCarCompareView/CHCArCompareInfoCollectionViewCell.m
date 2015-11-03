//
//  CHCArCompareInfoCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/23.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHCArCompareInfoCollectionViewCell.h"

@interface CHCArCompareInfoCollectionViewCell ()

@property (nonatomic, strong) UIView *CHRightLine;//右边的线

@end

@implementation CHCArCompareInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.CHLabel = [[UILabel alloc] init];
        [self.CHLabel setTextAlignment:NSTextAlignmentCenter];
        [self.CHLabel setFont:[UIFont systemFontOfSize:14]];
        [self.CHLabel setNumberOfLines:0];
        [self.CHLabel setTextColor:[UIColor redColor]];
        [self.contentView addSubview:_CHLabel];
        
        self.CHRightLine = [[UIView alloc] init];
        [self.CHRightLine setBackgroundColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_CHRightLine];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    [self.CHLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.contentView);
        
    }];
    
    [self.CHRightLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView.mas_right).offset(-0.5);
        make.height.equalTo(self.contentView.mas_height);
        make.width.mas_equalTo(0.5);
        
    }];
}

@end
