//
//  CHCarInfoPriceTableViewCell.h
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseTableViewCell.h"

@interface CHCarInfoPriceTableViewCell : CHBaseTableViewCell

@property (nonatomic, strong) UIImageView *CHImageView;//图片

@property (nonatomic, strong) UILabel *CHTitleLabel;//标题

@property (nonatomic, strong) UILabel *CHDiscountLabel;//降价

@property (nonatomic, strong) UILabel *CHCurrentPriceLabel;//当前价格

@property (nonatomic, strong) UILabel *CHTagLabel;//有无现车

@property (nonatomic, strong) UILabel *CHRemainLabel;//剩余天数

@end
