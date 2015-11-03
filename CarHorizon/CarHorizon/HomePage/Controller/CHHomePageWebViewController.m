//
//  CHHomePageWebViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/20.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageWebViewController.h"

@interface CHHomePageWebViewController ()

@property (nonatomic, strong) UIButton *CHCollectButton;

@property (nonatomic, strong) UIButton *CHShareButton;

@property (nonatomic, strong) UIWebView *CHWebView;

@property (nonatomic, strong) MBProgressHUD *CHHud;

@end

@implementation CHHomePageWebViewController


//创建底部的组件(收藏与分享)
- (void)createBottomView{
    
    CHBaseView *view = [[CHBaseView alloc] init];
//    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@49);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [view addSubview:imageView];
    [imageView setBackgroundColor:[UIColor redColor]];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(view);
        make.height.equalTo(@3);
    }];
    imageView.image = [UIImage imageNamed:@"qiandaotishi_black"];
    
    
    // 创建 收藏按钮
    self.CHCollectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:self.CHCollectButton];
//    [self.CHCollectButton setBackgroundColor:[UIColor orangeColor]];
    [self.CHCollectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(30);
        make.centerY.equalTo(view.mas_centerY);
        make.width.height.equalTo(@30);
    }];
    [self.CHCollectButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [self.CHCollectButton addTarget:self action:@selector(collectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // 创建 分享按钮
    self.CHShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:self.CHShareButton];
//    [self.CHShareButton setBackgroundColor:[UIColor blueColor]];
    [self.CHShareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-30);
        make.centerY.equalTo(view.mas_centerY);
        make.width.height.equalTo(@30);
        
    }];
    
    [self.CHShareButton setImage:[UIImage imageNamed:@"uncollect"] forState:UIControlStateNormal];
    [self.CHShareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
}

//收藏按钮
- (void)collectButton:(UIButton *)sender{

    
}

//分享按钮
- (void)shareButton:(UIButton *)sender{

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick:)];
    
    [self createBottomView];
    
    //创建webView
    self.CHWebView = [[UIWebView alloc] init];
    self.CHWebView.delegate = self;
    [self.view addSubview:_CHWebView];
    [self.CHWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
    
    [self.CHWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.WebUrl]]];
    
    self.CHHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.CHHud.labelText = @"数据正在加载...";
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [self.CHHud setHidden:YES];
}

- (void)rightBarButtonItemClick:(UIBarButtonItem *)sender{

    
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
