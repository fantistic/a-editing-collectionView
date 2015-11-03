//
//  AppDelegate.m
//  CarHorizon
//
//  Created by dllo on 15/10/11.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "AppDelegate.h"
//#import "CHUserPageViewController.h"
//#import "CHForumPageViewController.h"
//#import "CHFindCarViewController.h"
#import "CHHomePageViewController.h"
//#import "CHActivityPageViewController.h"
#import "CHNightSingleYesOrNo.h"
#import "CHLeadViewController.h"
#import <UMengSocial/UMSocial.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark 通知中心 调用的方法
- (void)nightVersion{
    if ([CHNightSingleYesOrNo shareSingleYesOrNo].isNight ) {
        // 改变导航栏上时间 电量 运营商 等信息颜色
        
       [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    }else{
        
       [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
    }
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //科大讯飞
//    NSString *initStr = [[NSString alloc] initWithFormat:@"appid=%@",@"562d9d40"];
    NSString *initStr = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",@"562d9d40",@"50000"];
    [IFlySpeechUtility createUtility:initStr];
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 读取之前退出时的状态
    [self nightYesOrNo];
    // 通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightVersion) name:@"observer" object:nil];
    // 夜间模式改变状态
    [self nightVersion];
    

    // 首页
    CHHomePageViewController *homePageVC = [[CHHomePageViewController alloc]init];
    UINavigationController *homePageNAVC = [[UINavigationController alloc]initWithRootViewController:homePageVC];
    homePageVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"tab_shouye_baitian"] selectedImage:[UIImage imageNamed:@"tab_shouye_baitian_hit"]];
    
    // 论坛
//    CHForumPageViewController *forumPageVC = [[CHForumPageViewController alloc]init];
//    UINavigationController *forumPageNAVC = [[UINavigationController alloc]initWithRootViewController:forumPageVC];
//    forumPageVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"论坛" image:[UIImage imageNamed:@"tab_luntan_baitian"] selectedImage:[UIImage imageNamed:@"tab_luntan_baitian_hit"]];
    
    // 找车
//    CHFindCarViewController *findCarVC = [[CHFindCarViewController alloc]init];
//    UINavigationController *findCarNAVC = [[UINavigationController alloc]initWithRootViewController:findCarVC];
//    findCarVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"找车" image:[UIImage imageNamed:@"tab_zhaoche_baitian"] selectedImage:[UIImage imageNamed:@"tab_zhaoche_baitian_hit"]];
    
    // 降价
//    CHActivityPageViewController *activityVC = [[CHActivityPageViewController alloc]init];
//    UINavigationController *activityNAVC = [[UINavigationController alloc]initWithRootViewController:activityVC];
//    activityVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"降价" image:[UIImage imageNamed:@"tab_jiangjia_baitian"] selectedImage:[UIImage imageNamed:@"tab_jiangjia_baitian_hit"]];
    
    // 我的
//    CHUserPageViewController *userVC = [[CHUserPageViewController alloc]init];
//    UINavigationController *userNAVC = [[UINavigationController alloc]initWithRootViewController:userVC];
//    userVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"我的(未选中)"] selectedImage:[UIImage imageNamed:@"我的(选中)"]];
    
    // Tabbar
    UITabBarController *mainVC = [[UITabBarController alloc]init];
    mainVC.tabBar.translucent = NO;
    mainVC.viewControllers = @[homePageNAVC];
    
    void(^block)() = ^(){
        [self.window setRootViewController:mainVC];
    };
    
#warning 引导页创建(只第一次运行)
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"firstLoad"] == nil) {
        [defaults setBool:NO forKey:@"firstLoad"];
        
        CHLeadViewController *leadVC = [[CHLeadViewController alloc] init];
        leadVC.block = block;
        _window.rootViewController = leadVC;
        
        
    }else{
        [self.window setRootViewController:mainVC];
    }
    
   
    return YES;
        
}

#pragma mark 判断是什么模式
- (void)nightYesOrNo{
    // 运行时 判断是什么模式
    // 判断是否是第一次运行
    // else 是判断 boolValue ==  是否是夜间模式
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"observer"] == nil ) {
        [CHNightSingleYesOrNo shareSingleYesOrNo].isNight = NO;
        
    }else{
        [CHNightSingleYesOrNo shareSingleYesOrNo].isNight = [[[NSUserDefaults standardUserDefaults] objectForKey:@"observer"] boolValue];
        
    }
  
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


@end
