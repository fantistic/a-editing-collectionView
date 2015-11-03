//
//  CHCarInfoTabHeaderCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/24.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHCarInfoTabHeaderCollectionViewCell.h"

@implementation CHCarInfoTabHeaderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.CHLabel = [[UILabel alloc] init];
        [self.CHLabel setNumberOfLines:0];
        [self.CHLabel setFont:[UIFont systemFontOfSize:14]];
        [self.CHLabel setTextAlignment:NSTextAlignmentCenter];
        [self.CHLabel setBackgroundColor:[UIColor whiteColor]];
        [self.CHLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:_CHLabel];
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.CHLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self.contentView);
    }];
    
}

@end
