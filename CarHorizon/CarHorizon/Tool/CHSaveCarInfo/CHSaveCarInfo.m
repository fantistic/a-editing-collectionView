//
//  CHSaveCarInfo.m
//  CarHorizon
//
//  Created by dllo on 15/10/23.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHSaveCarInfo.h"

@implementation CHSaveCarInfo

+ (NSMutableArray *)defalutSaveCarInfo{

    static NSMutableArray *arr = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        arr = @[].mutableCopy;
    });
    
    return arr;
}

@end
