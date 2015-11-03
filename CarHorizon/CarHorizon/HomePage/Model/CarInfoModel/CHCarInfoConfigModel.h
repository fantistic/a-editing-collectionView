//
//  CHCarInfoConfigModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHCarInfoConfigModel : CHBaseModel

@property (nonatomic, copy) NSString *carName;

@property (nonatomic, strong) NSMutableArray *config;

@property (nonatomic, strong) NSNumber *country;

@property (nonatomic, strong) NSNumber *carId;

@property (nonatomic, copy) NSString *carImage;

@end
