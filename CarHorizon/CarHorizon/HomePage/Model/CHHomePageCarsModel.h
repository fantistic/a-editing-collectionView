//
//  CHHomePageCarsModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHHomePageCarsModel : CHBaseModel

@property (nonatomic, strong) NSNumber *seriesId;

@property (nonatomic, copy) NSString *seriesName;

@property (nonatomic, copy) NSString *seriesImage;

@property (nonatomic, strong) NSMutableArray *carList;

@property (nonatomic, copy) NSString *guidePrice;

@end
