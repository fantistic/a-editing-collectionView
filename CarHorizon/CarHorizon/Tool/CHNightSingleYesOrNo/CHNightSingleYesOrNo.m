//
//  CHNightSingleYesOrNo.m
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHNightSingleYesOrNo.h"

@implementation CHNightSingleYesOrNo


+ (CHNightSingleYesOrNo *)shareSingleYesOrNo{
    
    static CHNightSingleYesOrNo *nightTool;
    static dispatch_once_t oneTokey;
    dispatch_once(&oneTokey, ^{
        nightTool = [[CHNightSingleYesOrNo alloc] init];
    });
    return nightTool;
}


@end
