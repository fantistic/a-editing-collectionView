//
//  CHPostsTableViewCell.h
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseTableViewCell.h"

@interface CHPostsTableViewCell : CHBaseTableViewCell

@property (nonatomic, strong) UILabel *CHTitleLabel;

@property (nonatomic, strong) UILabel *CHDescLabel;

@property (nonatomic, strong) UILabel *CHTimeLabel;

@property (nonatomic, strong) UILabel *CHAuthorLabel;

@property (nonatomic, strong) UIImageView *CHImageView;

@property (nonatomic, strong) UILabel *CHReplyNumLabel;

@end
