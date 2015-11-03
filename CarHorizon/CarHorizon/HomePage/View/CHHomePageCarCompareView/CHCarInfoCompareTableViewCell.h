//
//  CHCarInfoCompareTableViewCell.h
//  CarHorizon
//
//  Created by dllo on 15/10/24.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseTableViewCell.h"
#import "CHCArCompareInfoCollectionViewCell.h"
#import "CHSaveCarInfo.h"
#import "CHCarCompareInfoModel.h"

typedef void(^ChangePoint)(CGPoint);//改变headerCollectionView的位移

@interface CHCarInfoCompareTableViewCell : CHBaseTableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *CHParametersLabel;//参数

@property (nonatomic, strong) NSMutableArray *CHCarInfoArr;//parameters数组,对collectionview赋值

@property (nonatomic, strong) NSIndexPath *CHIndexPath;//通过indexPath来对collectionView赋值

@property (nonatomic, copy) ChangePoint ChContentOffSet;//改变collectionView的偏移量

@end
