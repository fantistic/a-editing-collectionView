//
//  FindCarDic+CoreDataProperties.h
//  CarHorizon
//
//  Created by 刘刘刘 on 15/10/26.
//  Copyright © 2015年 luo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FindCarDic.h"

NS_ASSUME_NONNULL_BEGIN

@interface FindCarDic (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *seriesName;
@property (nullable, nonatomic, retain) NSString *seriesIcon;
@property (nullable, nonatomic, retain) NSString *seriesPrice;
@property (nullable, nonatomic, retain) NSString *seriesId;

@end

NS_ASSUME_NONNULL_END
