//
//  CHHomePageTypeThreeCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/15.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageTypeThreeCollectionViewCell.h"

@implementation CHHomePageTypeThreeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(100, 100, 100, 50)];
}
@end
