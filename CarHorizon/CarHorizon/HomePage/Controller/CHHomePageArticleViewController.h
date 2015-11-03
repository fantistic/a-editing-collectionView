//
//  CHHomePageArticleViewController.h
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"
#import "CHArticleTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "CHAFNetWorkTool.h"
#import <MBProgressHUD.h>

@interface CHHomePageArticleViewController : CHBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString *CHArticleUrl;

@end
