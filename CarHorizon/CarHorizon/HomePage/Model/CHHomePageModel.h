//
//  CHHomePageModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/12.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHHomePageModel : CHBaseModel

@property (nonatomic, strong) NSNumber *newsId;
@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *newsLink;
@property (nonatomic, strong) NSNumber *pubTime;
@property (nonatomic, strong) NSNumber *newsType;
@property (nonatomic, copy) NSString *newsCategory;
@property (nonatomic, strong) NSNumber *newsCreateTime;
@property (nonatomic, copy) NSString *newsImage;
@property (nonatomic, strong) NSNumber *commentCount;

@end
