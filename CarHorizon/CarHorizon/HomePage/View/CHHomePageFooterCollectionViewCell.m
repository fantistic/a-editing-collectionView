//
//  CHHomePageFooterCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/14.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageFooterCollectionViewCell.h"

@implementation CHHomePageFooterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.footerView = [UIView new];
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.footerView setFrame:self.contentView.frame];
}

@end
