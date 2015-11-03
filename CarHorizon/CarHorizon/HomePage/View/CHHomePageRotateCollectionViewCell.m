//
//  CHHomePageRotateCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/15.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageRotateCollectionViewCell.h"

@implementation CHHomePageRotateCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.CHrotateImageview = [[UIImageView alloc] init];
        [self.CHrotateImageview setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_CHrotateImageview];
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.CHrotateImageview setFrame:self.contentView.frame];
}

@end
