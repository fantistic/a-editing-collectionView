//
//  CHHomePageViewController.h
//  CarHorizon
//
//  Created by dllo on 15/10/12.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"
#import "CHHomePageBarCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "CHetxt.h"
#import "CHHomePageFooterCollectionViewCell.h"
#import "CHHomePageDropCollectionViewCell.h"
#import "CHHomePageSearchViewController.h"
#import "CHHomePageTypeTwoCollectionViewCell.h"
#import "CHHomePageTypeOneCollectionViewCell.h"
#import "CHHomePageTypeThreeCollectionViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "CHHomePageWebViewController.h"

typedef void(^PushHomeBlock)(NSString *);

//typedef void(^bloc)(NSString *);
@interface CHHomePageViewController : CHBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate,UICollectionViewDelegateFlowLayout>

@end
