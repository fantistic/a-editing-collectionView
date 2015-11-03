//
//  CHBaseCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/13.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseCollectionViewCell.h"

@implementation CHBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}



@end
