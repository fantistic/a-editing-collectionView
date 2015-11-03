//
//  CHCarCompareInfoViewController.h
//  CarHorizon
//
//  Created by dllo on 15/10/23.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"
#import "CHAFNetWorkTool.h"
#import "CHCarCompareInfoModel.h"
#import "CHCarInfoCompareTableViewCell.h"
#import "CHCarInfoTabHeaderCollectionViewCell.h"
#import <MBProgressHUD.h>


@interface CHCarCompareInfoViewController : CHBaseViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSString *CHCarCompareInfoUrl;//用来请求车辆对比信息的网址

@end
