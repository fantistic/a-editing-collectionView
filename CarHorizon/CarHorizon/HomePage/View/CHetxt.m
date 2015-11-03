//
//  CHetxt.m
//  CarHorizon
//
//  Created by dllo on 15/10/13.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHetxt.h"

@implementation CHetxt

- (instancetype)initWithFrame:(CGRect)frame{

    self =  [super initWithFrame:frame];
    if (self) {
        
        self.textlabel = [[UILabel alloc] init];
        [self.contentView addSubview:_textlabel];
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.textlabel setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 40)];
}
@end
