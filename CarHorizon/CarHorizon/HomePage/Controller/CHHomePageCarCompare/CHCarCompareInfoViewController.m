//
//  CHCarCompareInfoViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/23.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHCarCompareInfoViewController.h"

@interface CHCarCompareInfoViewController ()

@property (nonatomic, strong) NSMutableArray *CHCarInfoCompareArr;//用来保存车辆对比信息

@property (nonatomic, strong) UITableView *CHTableview;

@property (nonatomic, strong) UICollectionView *CHHeadCollectionView;//创建tableView的headView

@property (nonatomic, copy) ChangePoint CHContentOffSet;//改变collectionView的偏移量

@property (nonatomic, strong) MBProgressHUD *CHHud;

@end

@implementation CHCarCompareInfoViewController

- (void)loaData{

    [CHAFNetWorkTool getUrl:self.CHCarCompareInfoUrl body:nil result:DWJSON headerFile:nil sucess:^(id result) {
        
        [self.CHHud setHidden:YES];
        self.CHCarInfoCompareArr = [CHCarCompareInfoModel baseModelByArr:[result objectForKey:@"parameters"]];
        
        [self.CHTableview reloadData];
        [self.CHHeadCollectionView reloadData];
        
    } failure:^(NSError *error) {
        
        [self.CHHud setHidden:YES];
        NSLog(@"数据加载失败");
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    //创建头部的headerView
    UIView *CHHeadView = [[UIView alloc] init];
    [CHHeadView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:CHHeadView];
    [CHHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *CHCarNameLabel = [[UILabel alloc] init];
    [CHCarNameLabel setBackgroundColor:[UIColor whiteColor]];
    [CHHeadView addSubview:CHCarNameLabel];
    [CHCarNameLabel setText:@"车型\n名称"];
    [CHCarNameLabel setNumberOfLines:0];
    [CHCarNameLabel setTextAlignment:NSTextAlignmentCenter];
    [CHCarNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(CHHeadView.mas_left);
        make.top.equalTo(CHHeadView.mas_top).offset(10);
        make.bottom.equalTo(CHHeadView.mas_bottom).offset(-10);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.18);
    }];
    
    //创建collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(120, 60)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    [flowLayout setMinimumInteritemSpacing:5];
//    [flowLayout setMinimumInteritemSpacing:5];
    
    self.CHHeadCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.CHHeadCollectionView.delegate = self;
    self.CHHeadCollectionView.dataSource = self;
    self.CHHeadCollectionView.showsHorizontalScrollIndicator = NO;
    self.CHHeadCollectionView.showsVerticalScrollIndicator = NO;
    [self.CHHeadCollectionView setBounces:NO];
    [self.CHHeadCollectionView setBackgroundColor:[UIColor lightGrayColor]];
    [self.CHHeadCollectionView registerClass:[CHCarInfoTabHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"CARINFOTABHEADER"];
    [CHHeadView addSubview:_CHHeadCollectionView];
    [self.CHHeadCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(CHCarNameLabel.mas_right).offset(8);
        make.top.equalTo(CHCarNameLabel.mas_top);
        make.bottom.equalTo(CHCarNameLabel.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        
    }];
    
    self.CHContentOffSet = ^(CGPoint point){
    
        [self.CHHeadCollectionView setContentOffset:point];
    };
    
    //创建tableView
    self.CHTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.CHTableview.delegate = self;
    self.CHTableview.dataSource = self;
    self.CHTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.CHTableview.showsVerticalScrollIndicator = NO;
    self.CHTableview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_CHTableview];
    [self.CHTableview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(CHHeadView.mas_bottom);
        
    }];
    
    self.CHHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.CHHud.labelText = @"数据正在加载...";
    [self loaData];
}

#pragma mark - UITableview的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (self.CHCarInfoCompareArr.count > 0) {
        
        CHCarCompareInfoModel *model = self.CHCarInfoCompareArr[0];
        
        return model.config.count;
        
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.CHCarInfoCompareArr.count > 0) {
        
        CHCarCompareInfoModel *model = self.CHCarInfoCompareArr[0];
        
        return [[model.config[section] objectForKey:@"result"] count];
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (self.CHCarInfoCompareArr.count > 0) {
        
        return @" ";
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (self.CHCarInfoCompareArr.count > 0) {
        
        
        CHCarCompareInfoModel *model = self.CHCarInfoCompareArr[0];
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
        [headView setBackgroundColor:[UIColor colorWithRed:118 / 255.0 green:176 / 255.0 blue:226 / 255.0 alpha:1]];
        
        UILabel *headLabel = [[UILabel alloc] init];
        headLabel.text = [model.config[section] objectForKey:@"typename"];
        [headView addSubview:headLabel];
        [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.bottom.equalTo(headView);
            make.left.equalTo(headView.mas_left).offset(8);
            make.width.mas_equalTo(90);
            
        }];
        
        UILabel *headRightLabel = [[UILabel alloc] init];
        headRightLabel.text = @"● 标配 ○ 选配 - 无 △ 待查";
        [headView addSubview:headRightLabel];
        [headRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(headView);
            make.right.equalTo(headView.mas_right).offset(-5);
            make.width.mas_equalTo(250);
            
        }];
        [headRightLabel setTextAlignment:NSTextAlignmentRight];
        
        return headView;

    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.CHCarInfoCompareArr.count > 0) {
        
        static NSString *requse = @"CArInfoRequse";
        CHCarInfoCompareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
        
        if (!cell) {
            
            cell = [[CHCarInfoCompareTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
        }
        
        CHCarCompareInfoModel *model = self.CHCarInfoCompareArr[0];
        
        cell.CHParametersLabel.text = [[model.config[indexPath.section] objectForKey:@"result"][indexPath.row] objectForKey:@"langname"];
        
        cell.CHCarInfoArr = self.CHCarInfoCompareArr;
        
        cell.CHIndexPath = indexPath;
        
        cell.ChContentOffSet = self.CHContentOffSet;
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

#pragma mark - UICollectionView的协议方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (self.CHCarInfoCompareArr.count > 0) {
        
        return self.CHCarInfoCompareArr.count;
    }
    
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    if (self.CHCarInfoCompareArr.count > 0) {
        
        return UIEdgeInsetsMake(10, 5, 10, 5);
    }
    
    return UIEdgeInsetsMake(0,0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(self.view.bounds.size.width * 0.8 / 2.0 - 10, 60);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.CHCarInfoCompareArr.count > 0) {
        
        CHCarCompareInfoModel *model = self.CHCarInfoCompareArr[indexPath.row];
        
        CHCarInfoTabHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CARINFOTABHEADER" forIndexPath:indexPath];
        
        cell.CHLabel.text = model.carName;
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UISrollecView的协议方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView == _CHHeadCollectionView) {
        
        NSArray *arr = [NSArray arrayWithObject:[NSValue valueWithCGPoint:scrollView.contentOffset]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeContentOffSet" object:arr];
    }
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
