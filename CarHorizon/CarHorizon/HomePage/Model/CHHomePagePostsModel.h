//
//  CHHomePagePostsModel.h
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseModel.h"

@interface CHHomePagePostsModel : CHBaseModel

@property (nonatomic, strong) NSNumber *postId;
@property (nonatomic, copy) NSString *postTitlel;
@property (nonatomic, copy) NSString *author;
@property (nonatomic ,copy) NSString *postDesc;
@property (nonatomic ,copy) NSString *postLink;
@property (nonatomic, strong) NSNumber *replyNum;
@property (nonatomic, strong) NSNumber *postCreateTime;


@end
