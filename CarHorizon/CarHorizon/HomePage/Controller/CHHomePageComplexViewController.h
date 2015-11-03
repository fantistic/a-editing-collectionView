//
//  CHHomePageComplexViewController.h
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"
#import "CHAFNetWorkTool.h"
#import "CHHomePageComplexModel.h"
#import <UIImageView+WebCache.h>
#import "CHQuotedPriceTableViewCell.h"
#import "CHComplexArticleTableViewCell.h"
#import "CHComplexPictureTableViewCell.h"
#import "CHComplexPostsTableViewCell.h"
#import "CHCarInformationViewController.h"
#import <MBProgressHUD.h>

@interface CHHomePageComplexViewController : CHBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSString *CHComPlexUrl;

@property (nonatomic, copy) NSString *CHComplexName;

@end
