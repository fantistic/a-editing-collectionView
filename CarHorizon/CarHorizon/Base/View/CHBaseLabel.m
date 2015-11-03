//
//  CHBaseLabel.m
//  CarHorizon
//
//  Created by dllo on 15/10/13.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseLabel.h"
#import "CHNightSingleYesOrNo.h"
@implementation CHBaseLabel


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightVersion) name:@"observer" object:nil];
    
    [self nightVersion];
    
}

-(void)nightVersion{
    if ([CHNightSingleYesOrNo shareSingleYesOrNo].isNight) {
        self.textColor = [UIColor whiteColor];
    }else{
        self.textColor = [UIColor blackColor];
    }
    
    
}


- (void)dealloc{
    // 释放通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
