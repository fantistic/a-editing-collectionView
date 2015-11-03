//
//  CHCarInformationViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/21.
//  Copyright © 2015年 luo. All rights reserved.
//

// 综合网址
#define COMPLEXURL @"http://mi.xcar.com.cn/interface/xcarapp/getSeriesInfoNew.php?cityId=64&seriesId="

//降价网址
#define PRICEREDUCE @"http://mi.xcar.com.cn/interface/xcarapp/getDiscountList.php?cityId=64&provinceId=6&seriesId=%ld&sortType=1",SeriesId

//配置
#define CONFIGUE @"http://mi.xcar.com.cn/interface/xcarapp/getCarParametersById.php?seriesId="

//图片
#define PICTURE @"http://mi.xcar.com.cn/interface/xcarapp/getImageSummaryNew.php?cityId=475&id=%ld&type=1",SeriesId

//资讯
#define INFO @"http://a.xcar.com.cn/interface/6.0/getNewsListBySeriesId.php?limit=20&offset=0&seriesId=%ld&type=1",SeriesId

#import "CHCarInformationViewController.h"
#import "CHBaseView.h"
#import "FindCarDic.h"
#import "CoreDataManager.h"


@interface CHCarInformationViewController ()

@property (nonatomic, strong) UISegmentedControl *CHSegControl;

@property (nonatomic, strong) UICollectionView *CHCollectionView;//显示正文的CollectionView

@property (nonatomic, strong) NSArray *CHSegArr;//segControl显示的内容数组

@property (nonatomic, strong) NSIndexPath *CHCurrentIndexPath;//保存当前CollectionView的indexPath

@property (nonatomic, strong) UIButton *CHCompareButton;//对比按钮

@property (nonatomic, strong) UIButton *CHCompareNumberButton;//对比按钮的数字

@property (nonatomic, strong) NSMutableArray *CHSaveCurrentCellMeaage;//保存去对比的车辆的信息

@property (nonatomic, assign) NSInteger CHCompareNumber;//对比个数

@property (nonatomic, strong) UIButton *collectButton;

@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) CHBaseView *bottomView;

@property (nonatomic, strong) CoreDataManager *coreManager;

@property (nonatomic, strong) NSMutableArray *coreArr;

@property (nonatomic, copy) NSString *str;

@end

@implementation CHCarInformationViewController

- (void)viewWillAppear:(BOOL)animated{
    
  // 查询
    [self createInquire];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.coreManager = [CoreDataManager shareCoreDataManager];
    
    // 打印沙盒路径
    NSLog(@"沙盒路径%@", [self.coreManager applicationDocumentsDirectory]);
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.title = @"车辆信息";
    
    self.CHSegArr = [NSArray arrayWithObjects:@"综合",@"降价",@"配置",@"图片",@"资讯", nil];
    
    self.CHSegControl = [[UISegmentedControl alloc] initWithItems:_CHSegArr];
    [_CHSegControl addTarget:self action:@selector(CHSegControlClick:) forControlEvents:UIControlEventValueChanged];
    [_CHSegControl setSelectedSegmentIndex:0];
    [self.view addSubview:_CHSegControl];
    [self.CHSegControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.top.equalTo(self.view.mas_top).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(30);
        
    }];
    
    // 创建下划线
    UIView *segBottomLine = [[UIView alloc] init];
    [segBottomLine setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:segBottomLine];
    [segBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.CHSegControl.mas_bottom).offset(4);
        make.height.mas_equalTo(0.5);
    }];
    
    //创建正文的CollectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(WIDTH, HEIGHT - 64 - 49 - 38)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    
    self.CHCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.CHCollectionView.delegate = self;
    self.CHCollectionView.dataSource = self;
    [self.CHCollectionView setPagingEnabled:YES];
    [self.CHCollectionView registerClass:[CHCraInfoCollectionViewCell class] forCellWithReuseIdentifier:@"CARINFO"];
    [self.view addSubview:_CHCollectionView];
    [self.CHCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
        make.top.equalTo(self.CHSegControl.mas_bottom).offset(5);
    }];
    
    //创建对比按钮的数字
    self.CHCompareNumberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.CHCompareNumberButton setBackgroundColor:[UIColor orangeColor]];
    [self.CHCompareNumberButton setAlpha:0.8];
    [self.CHCompareNumberButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.CHCompareNumberButton addTarget:self action:@selector(CHCompareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_CHCompareNumberButton];
    [self.CHCompareNumberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    [self.CHCompareNumberButton setHidden:YES];
    
    //创建对比按钮
    self.CHCompareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.CHCompareButton setTitle:@"去对比" forState:UIControlStateNormal];
    [self.CHCompareButton setBackgroundColor:[UIColor orangeColor]];
    [self.CHCompareButton setAlpha:0.8];
    [self.CHCompareButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.CHCompareButton addTarget:self action:@selector(CHCompareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_CHCompareButton];
    [_CHCompareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.CHCompareNumberButton.mas_left).offset(-0.5);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
        
    }];
    [self.CHCompareButton setHidden:YES];
    
    //注册一个通知用来改变按钮的数字
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chageNumber:) name:@"CHANGENUMBER" object:nil];
    
    //保存当前车辆信息的数组初始化
    NSMutableArray *saveCarId = [[NSUserDefaults standardUserDefaults] objectForKey:@"ClickCarId"];
    self.CHSaveCurrentCellMeaage = @[].mutableCopy;
    [self.CHSaveCurrentCellMeaage addObjectsFromArray:saveCarId];
    [self.CHCompareNumberButton setTitle:[NSString stringWithFormat:@"%ld",self.CHSaveCurrentCellMeaage.count] forState:UIControlStateNormal];
    
    self.CHCompareNumber = self.CHSaveCurrentCellMeaage.count;

    
    // 添加收藏按钮
    [self createBottomView];
}

- (void)createBottomView{
    _bottomView = [[CHBaseView alloc] init];
    [self.view addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@49);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [_bottomView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_bottomView);
        make.height.equalTo(@3);
    }];
    imageView.image = [UIImage imageNamed:@"qiandaotishi_black"];
    
    
    // 创建 收藏按钮
    self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:self.collectButton];
    
    [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView.mas_left).offset(30);
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.width.height.equalTo(@30);
    }];
    
    [self.collectButton addTarget:self action:@selector(collectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // 创建 分享按钮
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:self.shareButton];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView.mas_right).offset(-30);
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.width.height.equalTo(@30);
        
    }];
    [self.shareButton setImage:[UIImage imageNamed:@"uncollect"] forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(collectButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 查询
- (void)createInquire{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FindCarDic" inManagedObjectContext:self.coreManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    if(!_str){
    _str = [_CHSeriesId copy];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"seriesId like [cd] %@", _str];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    
    NSArray *fetchedObjects = nil;
    @try {
        
        fetchedObjects = [self.coreManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    }
    @catch (NSException *exception) {
        
        NSLog(@"暂无数据");
        
    }
    @finally {
        
    }
    if (fetchedObjects == nil) {
        NSLog(@"%@", error);
    }
    self.coreArr = [NSMutableArray array];
    [self.coreArr setArray:fetchedObjects];
    
    if (self.coreArr.count == 0) {
        [self.collectButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    }else{
        [self.collectButton setImage:[UIImage imageNamed:@"shoucang_h"] forState:UIControlStateNormal];
    }
    
}

#pragma mark 按钮点击方法
- (void)collectButton:(UIButton *)button{
    [self createInquire];
    if (button == self.collectButton) {
        if (self.coreArr.count == 0) {
            FindCarDic *temp = [NSEntityDescription insertNewObjectForEntityForName:@"FindCarDic" inManagedObjectContext:self.coreManager.managedObjectContext];
            temp.seriesIcon = _CHFCDic[@"seriesIcon"];
            temp.seriesName = _CHFCDic[@"seriesName"];
            temp.seriesPrice = _CHFCDic[@"seriesPrice"];
            temp.seriesId = [NSString stringWithFormat:@"%@", _CHFCDic[@"seriesId"]];
            [self.coreManager saveContext];
            [self.collectButton setImage:[UIImage imageNamed:@"shoucang_h"] forState:UIControlStateNormal];
        }else{
            FindCarDic *temp = self.coreArr[0];
            [self.coreManager.managedObjectContext deleteObject:temp];
            [self.collectButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
            [self.coreManager saveContext];
        }
    
    }else{
        NSLog(@"2");
    }
}




//通知的调用方法
- (void)chageNumber:(NSNotification *)sender{

    if (self.CHCompareNumber > 19) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"对比个数不能超过20个" message:@"赶紧去对比吧,亲😊" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return ;
    }
    [self.CHCompareNumberButton setTitle:[NSString stringWithFormat:@"%ld",++self.CHCompareNumber] forState:UIControlStateNormal];
    UIButton *btn = [sender.object objectForKey:@"CurrentButton"];
    [btn setAlpha:0.5];
    [btn setUserInteractionEnabled:NO];
    
    
    //获取车辆信息
    NSDictionary *currentCarMessage = [sender.object objectForKey:@"CurrentCarMessage"];
    //保存当前对比车辆信息
    [self.CHSaveCurrentCellMeaage addObject:currentCarMessage];

}

#pragma mark - 去对比的按钮的点击方法
- (void)CHCompareButtonClick:(UIButton *)sender{
    
    CHCarCompareViewController *CHCarCompareControl = [[CHCarCompareViewController alloc] init];
    
    CHCarCompareControl.CHCarInfoArr = self.CHSaveCurrentCellMeaage;
    
    [self.navigationController pushViewController:CHCarCompareControl animated:YES];

}

#pragma mark - UISegControl的协议方法

- (void)CHSegControlClick:(UISegmentedControl *)seg{
    
    NSIndexPath *indexPath = nil;
    switch (seg.selectedSegmentIndex) {
            
        case 0:{//综合页
            
            indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            break;
        }
        case 1:{//降价页
        
            indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            break;
        }
        case 2:{//配置页
        
            indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            break;
        }
        case 3:{//图片页
        
            indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
            break;
        }
        case 4:{//资讯
            
            indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
            break;
        }
        default:
            break;
            
    }
    
    [self.CHCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}


#pragma mark - CollectionView的协议方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.CHSegArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    //保存当前的indexpath
    self.CHCurrentIndexPath = indexPath;
    
    CHCraInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CARINFO" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {//综合
        
        cell.CHUrl = [NSString stringWithFormat:@"%@%@",COMPLEXURL,self.CHSeriesId];
        
        [self.CHCompareButton setHidden:NO];
        [self.CHCompareNumberButton setHidden:NO];
        
    }else if (indexPath.row == 1){//降价
    
        [self.CHCompareButton setHidden:YES];
        [self.CHCompareNumberButton setHidden:YES];
        NSInteger SeriesId = [self.CHSeriesId integerValue];
        NSString *str = [NSString stringWithFormat:PRICEREDUCE];
        cell.CHUrl = str;
        
    }else if (indexPath.row == 2){//配置
    
        [self.CHCompareButton setHidden:YES];
        [self.CHCompareNumberButton setHidden:YES];
        cell.CHUrl = [NSString stringWithFormat:@"%@%@",CONFIGUE,self.CHSeriesId];
        
    }else if (indexPath.row == 3){//图片
    
        [self.CHCompareButton setHidden:YES];
        [self.CHCompareNumberButton setHidden:YES];
        NSInteger SeriesId = [self.CHSeriesId integerValue];
        NSString *str = [NSString stringWithFormat:PICTURE];
        cell.CHUrl = str;
        
    }else if (indexPath.row == 4){//资讯
    
        [self.CHCompareButton setHidden:YES];
        [self.CHCompareNumberButton setHidden:YES];
        NSInteger SeriesId = [self.CHSeriesId integerValue];
        NSString *str = [NSString stringWithFormat:INFO];
        cell.CHUrl = str;
    }
    
    cell.CHIndexPath = indexPath;
    
    return cell;
    
}

#pragma mark - UIScrollView的协议方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger row = scrollView.contentOffset.x / self.view.bounds.size.width;
    [self.CHSegControl setSelectedSegmentIndex:row];
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
