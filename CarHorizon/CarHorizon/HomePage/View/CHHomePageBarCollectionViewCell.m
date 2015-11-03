//
//  CHHomePageBarCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/13.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageBarCollectionViewCell.h"

@implementation CHHomePageBarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.titleLabel = [[CHBaseLabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(2.5, 0, self.contentView.bounds.size.width - 5, self.contentView.bounds.size.height)];
    
//    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//    [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
////        make.edges.equalTo(self.contentView).offset(5);
//        make.top.bottom.equalTo(self.contentView);
//        make.left.equalTo(self.contentView.mas_left).offset(2);
//        make.right.equalTo(self.contentView.mas_right).offset(-2);
//        make.width
////        make.width.equalTo(self.contentView.mas_width);
////        make.right
//    }];
}


//- (CGSize)

@end
