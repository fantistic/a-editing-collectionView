//
//  AppDelegate.h
//  CarHorizon
//
//  Created by dllo on 15/10/11.
//  Copyright © 2015年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
// 语音识别的库
#import <iflyMSC/IFlyMSC.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

