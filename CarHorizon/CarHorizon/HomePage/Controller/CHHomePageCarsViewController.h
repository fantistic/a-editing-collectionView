//
//  CHHomePageCarsViewController.h
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"
#import <UIImageView+WebCache.h>
#import "CHAFNetWorkTool.h"
#import <MBProgressHUD.h>

@interface CHHomePageCarsViewController : CHBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString *CHCarsUrl;

@end
