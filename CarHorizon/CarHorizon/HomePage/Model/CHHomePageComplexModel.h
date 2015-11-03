//
//  CHHomePageComplexModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHHomePageComplexModel : CHBaseModel

@property (nonatomic, strong) NSMutableArray *seriesList;

@property (nonatomic, strong) NSMutableDictionary *news;

@property (nonatomic,strong) NSMutableDictionary *post;

@end
