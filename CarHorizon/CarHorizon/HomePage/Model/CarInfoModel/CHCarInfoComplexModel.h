//
//  CHCarInfoComplexModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/21.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHCarInfoComplexModel : CHBaseModel

@property (nonatomic, copy) NSString *seriesName;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) NSMutableArray *saleSubSeries;//在售数组

@property (nonatomic, strong) NSMutableArray *saleStopSubSeries;//停售数组

@property (nonatomic, strong) NSNumber *imageCount;//图片个数

@end
