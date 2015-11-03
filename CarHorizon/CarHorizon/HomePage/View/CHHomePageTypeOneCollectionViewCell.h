//
//  CHHomePageTypeOneCollectionViewCell.h
//  CarHorizon
//
//  Created by dllo on 15/10/15.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseCollectionViewCell.h"
#import "CHHomePageTypeOneTableViewCell.h"
#import "CHHomePageModel.h"
#import "CHHomePageRotateModel.h"
#import <UIImageView+WebCache.h>
#import "CHAFNetWorkTool.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "CHHomePageRotateCollectionViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "CHDropRefreshTool.h"

typedef void(^PushBlock)(NSString *);//用来Push到webView得界面

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define CITYURL @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?cityId=%ld&limit=10&offset=0&type=5",CityID

#define NORMAL1URL @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type="

#define NSOMAL0URL @"http://mi.xcar.com.cn/interface/xcarapp/getdingyue.php?limit=10&offset=0&type=1"

@interface CHHomePageTypeOneCollectionViewCell : CHBaseCollectionViewCell<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate>

@property (nonatomic, copy) NSString *CHUrlStr;

@property (nonatomic, assign) NSInteger CHTypeId;//用来拼接网址

@property (nonatomic, assign) NSInteger CHNormal;//用Normal来确定网络请求的网址

@property (nonatomic, strong) UIView *proviceView;

@property (nonatomic, strong) UIView *cityView;

@property (nonatomic, copy) PushBlock pushBlock;//用来push跳转界面

@end
