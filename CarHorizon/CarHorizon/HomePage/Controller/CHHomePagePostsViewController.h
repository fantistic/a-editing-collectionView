//
//  CHHomePagePostsViewController.h
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"
#import "CHAFNetWorkTool.h"
#import <UIImageView+WebCache.h>
#import "CHHomePagePostsModel.h"
#import "CHPostsTableViewCell.h"
#import <MBProgressHUD.h>

@interface CHHomePagePostsViewController : CHBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString *CHPostsUrl;

@end
