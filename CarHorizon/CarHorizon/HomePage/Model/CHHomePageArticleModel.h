//
//  CHHomePageArticleModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHHomePageArticleModel : CHBaseModel

@property (nonatomic, copy) NSString *newsTitle;

@property (nonatomic, copy) NSString *newsDesc;

@property (nonatomic, copy) NSString *newsLink;

@property (nonatomic, strong) NSNumber *newsCreateTime;

@property (nonatomic, copy) NSString *newsCategory;

@property (nonatomic, strong) NSNumber *newsId;

@end
