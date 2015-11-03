//
//  CHCarInfoTabHeaderCollectionViewCell.h
//  CarHorizon
//
//  Created by dllo on 15/10/24.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseCollectionViewCell.h"

typedef void(^ChangePoint)(CGPoint);//改变headerCollectionView的位移

@interface CHCarInfoTabHeaderCollectionViewCell : CHBaseCollectionViewCell

@property (nonatomic, strong) UILabel *CHLabel;

@end
