//
//  HotPost+CoreDataProperties.h
//  CarHorizon
//
//  Created by dllo on 15/10/20.
//  Copyright © 2015年 luo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HotPost.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotPost (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *forumName;
@property (nullable, nonatomic, retain) NSString *hasImage;
@property (nullable, nonatomic, retain) NSString *postId;
@property (nullable, nonatomic, retain) NSString *postTitle;
@property (nullable, nonatomic, retain) NSString *postType;
@property (nullable, nonatomic, retain) NSString *replyCount;
@property (nullable, nonatomic, retain) NSString *replyDate;

@end

NS_ASSUME_NONNULL_END
