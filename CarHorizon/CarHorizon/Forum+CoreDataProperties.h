//
//  Forum+CoreDataProperties.h
//  CarHorizon
//
//  Created by dllo on 15/10/21.
//  Copyright © 2015年 luo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Forum.h"

NS_ASSUME_NONNULL_BEGIN

@interface Forum (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *forumId;
@property (nullable, nonatomic, retain) NSString *forumName;

@end

NS_ASSUME_NONNULL_END
