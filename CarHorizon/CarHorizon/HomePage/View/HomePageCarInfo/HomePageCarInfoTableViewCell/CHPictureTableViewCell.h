//
//  CHPictureTableViewCell.h
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseTableViewCell.h"
#import "CHCarInfoPictureCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "CHCarInfoPictureModel.h"
#import "CHPicCollectionHeaderCell.h"

@interface CHPictureTableViewCell : CHBaseTableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *CHPicArr;//图片数组

@end
