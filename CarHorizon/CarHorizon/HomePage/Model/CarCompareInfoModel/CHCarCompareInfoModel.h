//
//  CHCarCompareInfoModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/23.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"


//车辆对比详细界面model

@interface CHCarCompareInfoModel : CHBaseModel

@property (nonatomic, copy) NSString *carName;

@property (nonatomic, copy) NSString *carImage;

@property (nonatomic, strong) NSNumber *carId;

@property (nonatomic, strong) NSMutableArray *config;

@end
