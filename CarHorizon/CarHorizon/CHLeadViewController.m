//
//  CHLeadViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/26.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHLeadViewController.h"

@interface CHLeadViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *page;

@end

@implementation CHLeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}
- (void)createView{
#warning 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(WIDTH * 4, 0);
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.userInteractionEnabled = YES;

    
#warning 创建page
    _page = [[UIPageControl alloc] init];
    [self.view addSubview:_page];
    _page.numberOfPages = 4;
   [_page mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(self.view.mas_bottom).offset(-50);
       make.centerX.equalTo(self.view.mas_centerX);
       make.width.equalTo(@50);
       make.height.equalTo(@30);
   }];
    
    
#warning 创建imageView
    for (NSInteger i = 0; i < 4; i++) {
        
        NSString *name = [NSString stringWithFormat:@"%ld",(long)i+1];
        UIImageView *imagei = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        imagei.frame = CGRectMake(WIDTH *i, 0, WIDTH , HEIGHT  );
        [self.scrollView addSubview:imagei];
        imagei.userInteractionEnabled = YES;
        
        
        if (i == 0) {
            UIButton *rightRutton = [[UIButton alloc] init];
            [imagei addSubview:rightRutton];
            rightRutton.backgroundColor = [UIColor whiteColor];
            rightRutton.layer.cornerRadius = 15;
            rightRutton.frame = CGRectMake(WIDTH - 40, HEIGHT / 2.0 - 20, 30, 30);
            [rightRutton setImage:[UIImage imageNamed:@"iconfont-nextpage"] forState:UIControlStateNormal];
            [rightRutton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
            
            
        }else if(i == 3){
            
            
            UIButton *leftButton = [[UIButton alloc] init];
            [imagei addSubview:leftButton];
            [leftButton setBackgroundColor:[UIColor whiteColor]];
            leftButton.layer.cornerRadius = 15;
            leftButton.frame = CGRectMake(10, HEIGHT / 2.0 - 20, 30, 30);
            [leftButton setImage:[UIImage imageNamed:@"iconfont-prev"] forState:UIControlStateNormal];
            [leftButton addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
        }else{
            UIButton *rightRutton = [[UIButton alloc] init];
            [imagei addSubview:rightRutton];
            rightRutton.layer.cornerRadius = 15;
            rightRutton.backgroundColor = [UIColor whiteColor];
            rightRutton.frame = CGRectMake(WIDTH - 40, HEIGHT / 2.0 - 20, 30, 30);
            [rightRutton setImage:[UIImage imageNamed:@"iconfont-nextpage"] forState:UIControlStateNormal];
            [rightRutton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *leftButton = [[UIButton alloc] init];
            [imagei addSubview:leftButton];
            leftButton.layer.cornerRadius = 15;
            [leftButton setBackgroundColor:[UIColor whiteColor]];
            leftButton.frame = CGRectMake(10, HEIGHT / 2.0 - 20, 30, 30);
            [leftButton setImage:[UIImage imageNamed:@"iconfont-prev"] forState:UIControlStateNormal];
            [leftButton addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    
#warning 创建button
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    enterButton.frame = CGRectMake(WIDTH *3+ 120/375.0 * WIDTH, 500 / 667.0 *HEIGHT, 150 /375.0 *WIDTH, 40 / 667.0 *HEIGHT);
    enterButton.backgroundColor = [UIColor whiteColor];
    enterButton.alpha = 0.9;
    enterButton.layer.borderWidth = 1;
    enterButton.layer.cornerRadius = 5;
    [self.scrollView addSubview:enterButton];
    [enterButton setTitle:@"进入应用" forState:UIControlStateNormal];
    enterButton.titleLabel.font = [UIFont systemFontOfSize:20 / 375.0 *WIDTH];
    [enterButton addTarget:self action:@selector(enterAction:) forControlEvents:UIControlEventTouchUpInside];
    
#warning 创建跳过按钮
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeSystem];
        jumpButton.frame=CGRectMake(WIDTH *i +300 / 375.0 * WIDTH, 40 /667.0 *HEIGHT, 50/ 375.0 * WIDTH, 30 /667.0 *HEIGHT);
        jumpButton.layer.borderWidth = 1;
        jumpButton.layer.cornerRadius = 5;
        jumpButton.backgroundColor = [UIColor whiteColor];
        jumpButton.alpha = 0.5;
        [self.scrollView addSubview:jumpButton];
        [jumpButton setTitle:@"跳过" forState:UIControlStateNormal];
        [jumpButton addTarget:self action:@selector(enterAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _page.currentPage = _scrollView.contentOffset.x / WIDTH;
}


- (void)left{
    
    self.scrollView.contentOffset  = CGPointMake(self.scrollView.contentOffset.x - WIDTH, 0);
    
}

- (void)right{
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + WIDTH, 0);
}

// 进入应用
- (void)enterAction:(UIButton *)button{
    
    self.block();
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
