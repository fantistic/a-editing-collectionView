//
//  CHCarInfoComplexTableViewCell.h
//  CarHorizon
//
//  Created by dllo on 15/10/21.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseTableViewCell.h"

typedef void(^ComplexBlock)(NSIndexPath *);

@interface CHCarInfoComplexTableViewCell : CHBaseTableViewCell

@property (nonatomic, strong) UILabel *CHTitleLabel;

@property (nonatomic, strong) UILabel *CHDriverLabel;

@property (nonatomic, strong) UILabel *CHGuidePriceLabel;

@property (nonatomic, strong) UIButton *CHComparedButton;

@property (nonatomic, strong) UIView *CHDistinguishView;

@property (nonatomic, strong) NSIndexPath *CHIndexPath; 

@property (nonatomic, strong) ComplexBlock complexBlock;//通过blobk回调的方式将当前点击的buttonIndexPath保存在数组中

@property (nonatomic, assign) CGPoint CHCurrentLocation;

@property (nonatomic, strong) NSDictionary *CHCarInfoDic;//用来接收当前cell的数据


@end
