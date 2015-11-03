//
//  CHCarInfoPriceModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHCarInfoPriceModel : CHBaseModel

@property (nonatomic, copy) NSString *currentPrice;

@property (nonatomic, copy) NSString *discount;

@property (nonatomic, strong) NSNumber *provinceId;

@property (nonatomic, strong) NSNumber *cityId;

@property (nonatomic, strong) NSNumber *remain;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *carName;

@property (nonatomic, copy) NSString *seriesName;

@property (nonatomic, strong) NSNumber *seriesId;

@property (nonatomic, copy) NSString *imageUrl;

@end
