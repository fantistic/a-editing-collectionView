//
//  CHCarInfoPictureModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHCarInfoPictureModel : CHBaseModel

@property (nonatomic, copy) NSString *imageCategory;

@property (nonatomic, strong) NSNumber *imageCount;

@property (nonatomic, strong) NSNumber *imageCategoryId;

@property (nonatomic, strong) NSMutableArray *imagesList;

@end
