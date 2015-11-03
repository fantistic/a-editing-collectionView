//
//  CHBaseViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/12.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"

#import "CHNightSingleYesOrNo.h"



@interface CHBaseViewController ()

@property (strong, nonatomic) UIView *stateView;

@end

@implementation CHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    // 添加通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightVersion) name:@"observer" object:nil];
    
    [self nightVersion];
}

- (void)nightVersion{
    if ([CHNightSingleYesOrNo shareSingleYesOrNo].isNight ) {
        
        self.view.backgroundColor = [UIColor colorWithRed:31 / 255.0 green:34 / 255.0 blue:41 / 255.0 alpha:1.000];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.102 green:0.133 blue:0.180 alpha:1.000];
        self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.102 green:0.133 blue:0.180 alpha:1.000];
     // 改变字体颜色
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor whiteColor]forKey:NSForegroundColorAttributeName];
        self.navigationController.navigationBar.titleTextAttributes = dic;
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
     // 改变字体颜色
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor blackColor]forKey:NSForegroundColorAttributeName];
        self.navigationController.navigationBar.titleTextAttributes = dic;
        
    }
    
}
- (void)dealloc{
    // 释放通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
