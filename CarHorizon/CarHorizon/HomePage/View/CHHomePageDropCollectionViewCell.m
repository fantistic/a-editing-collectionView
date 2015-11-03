//
//  CHHomePageDropCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/14.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageDropCollectionViewCell.h"

@implementation CHHomePageDropCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.titleLabel = [[CHBaseLabel alloc] init];
        [self.contentView addSubview:_titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(2.5, 0, self.contentView.bounds.size.width - 5, self.contentView.bounds.size.height)];
    
}

@end
