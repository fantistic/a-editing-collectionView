//
//  CoreDataManager.h
//  UseCoreData
//
//  Created by dllo on 15/9/28.
//  Copyright © 2015年 cml. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

// 管理对象上下文(豪瑞)
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

// 管理对象模型
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

// 持久化存储协调器(助理 - 鹰王)
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// 保存上下文(保存对数据的修改)
- (void)saveContext;

// 沙盒路径
- (NSURL *)applicationDocumentsDirectory;

// 单例方法, 获取对象
+ (CoreDataManager *)shareCoreDataManager;

@end
