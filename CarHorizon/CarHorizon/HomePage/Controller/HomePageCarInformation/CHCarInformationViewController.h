//
//  CHCarInformationViewController.h
//  CarHorizon
//
//  Created by dllo on 15/10/21.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"
#import "CHCraInfoCollectionViewCell.h"
#import "CHCarCompareViewController.h"

@interface CHCarInformationViewController : CHBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, copy) NSString *CHSeriesId;//根据这个来拼接网址

@property (nonatomic, strong) NSMutableDictionary *CHFCDic;

@end
