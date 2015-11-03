//
//  CHCraInfoCollectionViewCell.h
//  CarHorizon
//
//  Created by dllo on 15/10/21.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseCollectionViewCell.h"
#import "CHAFNetWorkTool.h"
#import "CHCarInfoComplexModel.h"
#import "CHCarInfoComplexTableViewCell.h"
#import "CHCarInfoPriceModel.h"
#import "CHCarInfoPriceTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "CHCarInfoConfigModel.h"
#import "CHCarInfoPictureModel.h"
#import "CHCarInfoPictureCollectionViewCell.h"
#import "CHPictureTableViewCell.h"
#import "CHHomePageModel.h"
#import "CHHomePageTypeOneTableViewCell.h"
#import <MBProgressHUD.h>

typedef void(^CarInfoBlock)(NSIndexPath *);

@interface CHCraInfoCollectionViewCell : CHBaseCollectionViewCell<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSString *CHUrl;

@property (nonatomic, strong) NSIndexPath *CHIndexPath;//通过这个来决定使用那种cell

@end
