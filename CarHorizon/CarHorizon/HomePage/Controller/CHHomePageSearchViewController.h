//
//  CHHomePageSearchViewController.h
//  CarHorizon
//
//  Created by dllo on 15/10/14.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"
#import "CHHomePageSearchTableViewCell.h"
#import "CHAFNetWorkTool.h"
#import "CHHomePageSearchCollectionViewCell.h"
#import "CHHomePageSearchView.h"
#import "CHTextViewController.h"
#import "CHHomePageArticleViewController.h"
#import "CHHomePageComplexViewController.h"
#import "CHHomePageCarsViewController.h"
#import "CHHomePagePostsViewController.h"
// 语音识别的库
#import <iflyMSC/IFlyMSC.h>
#import <Masonry/Masonry.h>

typedef void(^OneTimeBlock)(UISearchBar *);

@interface CHHomePageSearchViewController : CHBaseViewController<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate,IFlySpeechRecognizerDelegate>

@end
