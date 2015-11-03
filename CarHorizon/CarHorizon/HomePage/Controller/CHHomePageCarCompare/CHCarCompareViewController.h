//
//  CHCarCompareViewController.h
//  CarHorizon
//
//  Created by dllo on 15/10/23.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"
#import "CHCarCompareInfoViewController.h"

@interface CHCarCompareViewController : CHBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *CHCarInfoArr;//对比车辆信息

@end
