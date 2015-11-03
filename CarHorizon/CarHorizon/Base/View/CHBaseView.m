//
//  CHBaseView.m
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseView.h"
#import "CHNightSingleYesOrNo.h"

@implementation CHBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    // 添加通知中心
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightVersion) name:@"observer" object:nil];
    
    [self nightVersion];
}
- (void)nightVersion{
    if ([CHNightSingleYesOrNo shareSingleYesOrNo].isNight ) {
        self.backgroundColor = [UIColor colorWithRed:0.102 green:0.133 blue:0.180 alpha:1.000];
        
        
    }else{
        
        self.backgroundColor = [UIColor whiteColor];
        
        
    }
    
}
- (void)dealloc{
    // 释放通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
