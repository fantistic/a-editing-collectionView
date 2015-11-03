//
//  CHHomePageWebViewController.h
//  CarHorizon
//
//  Created by dllo on 15/10/20.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHBaseViewController.h"
#import "CHBaseView.h"
#import <MBProgressHUD.h>

@interface CHHomePageWebViewController : CHBaseViewController<UIWebViewDelegate>

@property (nonatomic ,copy) NSString *WebUrl;

@end
