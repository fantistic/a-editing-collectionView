//
//  CHPicCollectionHeaderCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHPicCollectionHeaderCell.h"

@implementation CHPicCollectionHeaderCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.CHTitleLabel = [[UILabel alloc] init];
        [self.CHTitleLabel setFont:[UIFont systemFontOfSize:15]];
        
        [self.contentView addSubview:_CHTitleLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    [self.CHTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
       
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.top.bottom.equalTo(self.contentView);
    }];
}

@end
