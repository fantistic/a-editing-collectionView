//
//  CHHomePageViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/12.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageViewController.h"
#import "LXReorderableCollectionViewFlowLayout.h"

#define AURL @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type="

#define MURL @"http://mi.xcar.com.cn/interface/xcarapp/getdingyue.php?limit=10&offset=0&type="

@interface CHHomePageViewController ()<LXReorderableCollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *CHHPVCCollectionView;

@property (nonatomic, strong) NSMutableArray *CHHPVCConfirmedArray;

@property (nonatomic, strong) NSMutableArray *CHHPVCSubScribedArray;

@property (nonatomic, strong) NSMutableArray *CHHPVCNotsubscribedArray;

@property (nonatomic, strong) UICollectionView *CHHPVCDropCollectionView;

@property (nonatomic, strong) UITableView *CHHPVCDropTableview;

@property (nonatomic, strong) UIButton *searchButton;

@property (nonatomic, strong) UIButton *dropButton;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UICollectionView *CHHPVCTextCollectionView;

@property (nonatomic, copy) PushHomeBlock pushBlock;

@property (nonatomic, strong) UIView *proviceView;

@property (nonatomic, strong) UIView *cityView;

@property (nonatomic, strong) UIView *CHBottomLineView;//给上面那个ColectionView添加下划线

@property (nonatomic, strong) NSMutableArray *CHCurrentItemWidthArr;//保存当前


//@property (nonatomic, strong) UIView *CHCoverWindowView;//给window上添加一层模糊色

@property (nonatomic, strong) NSIndexPath *oldIndexPath;//保存上一次collectionView被点击的indexPath;

@property (nonatomic, strong) UIView *CHDropView;//下拉按钮的隐藏View

@end

@implementation CHHomePageViewController


- (void)loaData{

    NSDictionary *dic =  [[NSUserDefaults standardUserDefaults] objectForKey:@"subject"];
    
    if (dic == nil || [dic count] == 0) {
        
        NSString *fileStr = [[NSBundle mainBundle] pathForResource:@"subject" ofType:@"json"];
        
        NSData *data = [NSData dataWithContentsOfFile:fileStr];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.CHHPVCConfirmedArray  = [dic objectForKey:@"confirmed"];
        self.CHHPVCSubScribedArray = [dic objectForKey:@"subscribed"];
        self.CHHPVCNotsubscribedArray = [dic objectForKey:@"notsubscribed"];
    }else{
        
        NSMutableArray *confirmArray = @[].mutableCopy;
        [confirmArray addObjectsFromArray:[dic objectForKey:@"confirmed"]];
        self.CHHPVCConfirmedArray = confirmArray;
        
        NSMutableArray *subArray = @[].mutableCopy;
        [subArray addObjectsFromArray:[dic objectForKey:@"subscribed"]];
        self.CHHPVCSubScribedArray = subArray;
        
        NSMutableArray *notSubArray = @[].mutableCopy;
        [notSubArray addObjectsFromArray:[dic objectForKey:@"notsubscribed"]];
        
        self.CHHPVCNotsubscribedArray = notSubArray;
    }
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self setNavigationBarHidden:NO];
    [self loaData];
    
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor redColor]];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((self.view.bounds.size.width - 80) / 3.2f, 44)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setMinimumInteritemSpacing:5.0f];
    
    self.CHHPVCCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 80, 44) collectionViewLayout:flowLayout];
    _CHHPVCCollectionView.showsHorizontalScrollIndicator = NO;
    _CHHPVCCollectionView.showsVerticalScrollIndicator = NO;
    [_CHHPVCCollectionView setBounces:YES];
    [_CHHPVCCollectionView setPagingEnabled:NO];
    [_CHHPVCCollectionView registerClass:[CHHomePageBarCollectionViewCell class] forCellWithReuseIdentifier:@"CHHPBCVCREQUSE"];
    _CHHPVCCollectionView.delegate = self;
    _CHHPVCCollectionView.dataSource = self;
#warning 设置颜色
    [_CHHPVCCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar addSubview: _CHHPVCCollectionView];
    
    UIImage *searchImage = [UIImage imageNamed:@"sousuo_baitian_hit"];
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setBackgroundImage:searchImage forState:UIControlStateNormal];
    [_searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:_searchButton];
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.CHHPVCCollectionView.mas_bottom).offset(-15);
        make.right.equalTo(self.navigationController.view.mas_right).offset(-5);
        make.width.mas_equalTo(searchImage.size.width);
        make.height.mas_equalTo(searchImage.size.height);
    }];
    
    
    UIImage *dropImage = [UIImage imageNamed:@"xiala_baitian_hit"];
    self.dropButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dropButton setBackgroundImage:dropImage forState:UIControlStateNormal];
    [_dropButton addTarget:self action:@selector(dropButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:_dropButton];
    [_dropButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.CHHPVCCollectionView.mas_bottom).offset(-20);
        make.right.equalTo(_searchButton.mas_left).offset(-15);
        make.width.mas_equalTo(dropImage.size.width);
        make.height.mas_equalTo(dropImage.size.height);
    }];
    
    //创建正文CollectionView
    UICollectionViewFlowLayout *textFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [textFlowLayout setItemSize:CGSizeMake(WIDTH, HEIGHT - 64)];
    [textFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [textFlowLayout setMinimumInteritemSpacing:0];
    [textFlowLayout setMinimumLineSpacing:0];
    
    self.CHHPVCTextCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) collectionViewLayout:textFlowLayout];
    _CHHPVCTextCollectionView.showsHorizontalScrollIndicator = NO;
    _CHHPVCTextCollectionView.showsVerticalScrollIndicator = NO;
    [_CHHPVCTextCollectionView setPagingEnabled:YES];
    _CHHPVCTextCollectionView.delegate = self;
    _CHHPVCTextCollectionView.dataSource = self;
    
    [_CHHPVCTextCollectionView registerClass:[CHHomePageTypeOneCollectionViewCell class] forCellWithReuseIdentifier:@"TYPEONE"];
#warning 颜色
    [_CHHPVCTextCollectionView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:_CHHPVCTextCollectionView];
    
    //保存上面collectionview每一个ItemSize的大小
    self.CHCurrentItemWidthArr = @[].mutableCopy;
    
    //创建上面Collectionview的下划线
    self.CHBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(5, 42, 40, 2)];
    [self.CHBottomLineView setBackgroundColor:[UIColor blueColor]];
    [self.CHHPVCCollectionView addSubview:self.CHBottomLineView];
    
    //用来push界面
    self.pushBlock  = ^(NSString *url){
    
        CHHomePageWebViewController *webController = [[CHHomePageWebViewController alloc] init];
        webController.WebUrl = url;
        [webController setHidesBottomBarWhenPushed:YES];
        [self setNavigationBarHidden:YES];
        [self.navigationController pushViewController:webController animated:YES];
    
    };
    /*****************************************/
    //下拉保护色
    self.CHDropView = [[UIView alloc] initWithFrame:CGRectMake(0, 400 + 64, self.view.bounds.size.width, [[UIScreen mainScreen] bounds].size.height - 400 - 64)];
    [self.CHDropView setBackgroundColor:[UIColor blackColor]];
    [self.CHDropView setAlpha:0.5];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:_CHDropView];
    [self.CHDropView setHidden:YES];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClick:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.CHDropView addGestureRecognizer:tapGesture];
}

//保护色的手势方法
- (void)tapGestureClick:(UITapGestureRecognizer *)sender{

    [self.CHDropView setHidden:YES];
    [self.CHHPVCDropCollectionView setHidden:YES];
    [self.coverView setHidden:YES];
    [self setNavigationBarHidden:NO];
}

- (void)setNavigationBarHidden:(BOOL)hidden{

    [_CHHPVCCollectionView setHidden:hidden];
    [_searchButton setHidden:hidden];
    [_dropButton setHidden:hidden];
}

//搜索
- (void)searchButtonClick:(UIButton *)sender{
    
    NSLog(@"搜索");
    
    [self setNavigationBarHidden:YES];
//    self.ch
    CHHomePageSearchViewController *CHHPSearchController = [[CHHomePageSearchViewController alloc] init];
    [self.navigationController pushViewController:CHHPSearchController animated:YES];

}


- (void)createDropCollectionView{

    LXReorderableCollectionViewFlowLayout *flowLayout = [[LXReorderableCollectionViewFlowLayout  alloc] init];
    [flowLayout setItemSize:CGSizeMake((self.view.bounds.size.width - 20) / 4.0f, 30)];
    [flowLayout setMinimumInteritemSpacing:5.0f];
    [flowLayout setMinimumLineSpacing:10.0f];
    [flowLayout setHeaderReferenceSize:CGSizeMake(self.view.bounds.size.width, 50)];
    [flowLayout setFooterReferenceSize:CGSizeMake(self.view.bounds.size.width, 15)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.CHHPVCDropCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(100, 0, 0, 0) collectionViewLayout:flowLayout];
    [_CHHPVCDropCollectionView setShowsHorizontalScrollIndicator:YES];
    [_CHHPVCDropCollectionView setShowsVerticalScrollIndicator:YES];
    _CHHPVCDropCollectionView.delegate = self;
    _CHHPVCDropCollectionView.dataSource = self;
#warning 颜色
    [_CHHPVCDropCollectionView setBackgroundColor:[UIColor whiteColor]];
    [_CHHPVCDropCollectionView registerClass:[CHHomePageDropCollectionViewCell class] forCellWithReuseIdentifier:@"CHHPVCDCREQUSE"];
    
    [_CHHPVCDropCollectionView registerClass:[CHetxt class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CHHPVCDCHEADERREQUSE"];
    
    [_CHHPVCDropCollectionView registerClass:[CHHomePageFooterCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CHHPVCDCFOOTERREQUSE"];
    [self.view addSubview:_CHHPVCDropCollectionView];
}

- (void)setDropCollectionViewHidden:(BOOL)hidden{
    
    NSInteger hight = hidden ? 0 : 400;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [self.CHHPVCDropCollectionView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, hight)];
    [UIView commitAnimations];
    
}

//下拉按钮
- (void)dropButtonClick:(UIButton *)sender{

    [self setNavigationBarHidden:YES];
    [self createDropCollectionView];
    [self setDropCollectionViewHidden:NO];
    [self.CHDropView setHidden:NO];
    
    self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [self.navigationController.navigationBar addSubview:_coverView];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    [_coverView addSubview:rightLabel];
    [rightLabel setText:@"已订阅的标签"];
    [rightLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_coverView.mas_left).offset(10);
        make.top.bottom.equalTo(_coverView);
    }];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"收起" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_coverView addSubview:leftButton];
    [leftButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_coverView.mas_right).offset(-10);
        make.top.bottom.equalTo(_coverView);
    }];
    
    //添加下划线
    UIView *bootomLineView = [[UIView alloc] init];
    [self.coverView addSubview:bootomLineView];
    [bootomLineView setBackgroundColor:[UIColor grayColor]];
    [bootomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.coverView);
        make.bottom.equalTo(self.coverView.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
    
//    //将window的背景设为灰色
//    self.CHCoverWindowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
//    [self.CHCoverWindowView setBackgroundColor:[UIColor blackColor]];
//    [self.CHCoverWindowView setAlpha:0.5];
//    [self.CHCoverWindowView setUserInteractionEnabled:NO];
//    [[[UIApplication sharedApplication].delegate window] addSubview:_CHCoverWindowView];
    
}

//收起按钮
- (void)leftButtonClick:(UIButton *)sender{

    //将模糊色移除
//    [self.CHCoverWindowView removeFromSuperview];
    [self.CHDropView setHidden:YES];
    [self setDropCollectionViewHidden:YES];
    [self setNavigationBarHidden:NO];
    [self.coverView removeFromSuperview];
    //当上面的ColletionView刷新时,将数组清空
    [self.CHCurrentItemWidthArr removeAllObjects];
    [_CHHPVCCollectionView reloadData];
    [_CHHPVCTextCollectionView reloadData];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.CHHPVCConfirmedArray,@"confirmed",self.CHHPVCSubScribedArray,@"subscribed",self.CHHPVCNotsubscribedArray,@"notsubscribed", nil];
    [[NSUserDefaults standardUserDefaults] setValue:dic forKey:@"subject"];

}

#pragma mark - UICollectionview的协议方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (collectionView == _CHHPVCCollectionView) {
    
        return 1;
        
    }else if(collectionView == _CHHPVCDropCollectionView){
        
        return 2;
    }else if (collectionView == _CHHPVCTextCollectionView){
        
        return 1;
    }
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (collectionView == _CHHPVCCollectionView) {//导航栏
    
        return self.CHHPVCConfirmedArray.count + self.CHHPVCSubScribedArray.count;
        
    }else if (collectionView == _CHHPVCDropCollectionView){//下拉
    
        if (section == 0) {
            
            return self.CHHPVCConfirmedArray.count + self.CHHPVCSubScribedArray.count;
        }else if (section == 1){
            
            return self.CHHPVCNotsubscribedArray.count;
        }
    }else if (collectionView == _CHHPVCTextCollectionView){//正文
    
        return self.CHHPVCConfirmedArray.count + self.CHHPVCSubScribedArray.count;
    }
    
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (collectionView == _CHHPVCCollectionView) {
    
        CHHomePageBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHHPBCVCREQUSE" forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            
            cell.titleLabel.text = [self.CHHPVCConfirmedArray[0] objectForKey:@"title"];
        }else{
            
            cell.titleLabel.text = [self.CHHPVCSubScribedArray[indexPath.row - 1] objectForKey:@"title"];
        }
        return cell;
        
    }else if (collectionView == _CHHPVCDropCollectionView){
    
        CHHomePageDropCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHHPVCDCREQUSE" forIndexPath:indexPath];
        
        cell.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.titleLabel setBackgroundColor:[UIColor lightGrayColor]];
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                cell.titleLabel.text = [self.CHHPVCConfirmedArray[0] objectForKey:@"title"];
                [cell setUserInteractionEnabled:NO];
                [cell.titleLabel setBackgroundColor:[UIColor redColor]];
            }else{
                 [cell setUserInteractionEnabled:YES];
                cell.titleLabel.text = [self.CHHPVCSubScribedArray[indexPath.row - 1] objectForKey:@"title"];
            }
        }else{
            [cell setUserInteractionEnabled:YES];
            cell.titleLabel.text = [self.CHHPVCNotsubscribedArray[indexPath.row] objectForKey:@"title"];
        }
        
        return cell;
    }else if (collectionView == _CHHPVCTextCollectionView){
    
        CHHomePageTypeOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TYPEONE" forIndexPath:indexPath];
        cell.pushBlock = self.pushBlock;
        if (indexPath.row == 0) {
            
            if ([[self.CHHPVCConfirmedArray[indexPath.row] objectForKey:@"normal"] integerValue] == 1) {
                
                cell.CHNormal = 1;
                cell.CHUrlStr = [NSString stringWithFormat:@"%@%@",AURL,[self.CHHPVCConfirmedArray[indexPath.row] objectForKey:@"typeId"]];
                
            }else if([[self.CHHPVCConfirmedArray[indexPath.row] objectForKey:@"normal"] integerValue] == 0){
            
                cell.CHNormal = 0;
                cell.CHUrlStr = [NSString stringWithFormat:@"%@%@",MURL,[self.CHHPVCConfirmedArray[indexPath.row] objectForKey:@"typeId"]];
            }
            cell.CHTypeId = [[self.CHHPVCConfirmedArray[indexPath.row] objectForKey:@"typeId"] integerValue];

        }else{
        
            if ([[self.CHHPVCSubScribedArray[indexPath.row - 1] objectForKey:@"normal"] integerValue] == 1) {
                
                cell.CHNormal = 1;
                cell.CHUrlStr = [NSString stringWithFormat:@"%@%@",AURL,[self.CHHPVCSubScribedArray[indexPath.row - 1] objectForKey:@"typeId"]];
                
            }else if ([[self.CHHPVCSubScribedArray[indexPath.row - 1] objectForKey:@"normal"] integerValue] == 0){
                
                cell.CHNormal = 0;
                cell.CHUrlStr = [NSString stringWithFormat:@"%@%@",MURL,[self.CHHPVCSubScribedArray[indexPath.row - 1] objectForKey:@"typeId"]];
            }
            
            cell.CHTypeId = [[self.CHHPVCSubScribedArray[indexPath.row - 1] objectForKey:@"typeId"] integerValue];
            
        }
        return cell;
    }
    
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CHetxt *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CHHPVCDCHEADERREQUSE" forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            
            cell.textlabel.text = @" 长按拖动排序/点击删除";
            [cell.textlabel setBackgroundColor:[UIColor colorWithRed:21 / 255.0 green:122 /255.0 blue:169 / 255.0 alpha:1]];
        }else{
            
            cell.textlabel.text = @" 点击订阅更多标签";
            [cell.textlabel setBackgroundColor:[UIColor colorWithRed:21 / 255.0 green:122 /255.0 blue:169 / 255.0 alpha:1]];
        }
        [cell.textlabel setFont:[UIFont systemFontOfSize:15]];
        return cell;
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
        CHHomePageFooterCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CHHPVCDCFOOTERREQUSE" forIndexPath:indexPath];
        [cell.footerView setBackgroundColor:[UIColor redColor]];
        
        return cell;
    }
    
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _CHHPVCDropCollectionView) {
        
        if (indexPath.section == 0) {
            
            [self.CHHPVCNotsubscribedArray addObject:self.CHHPVCSubScribedArray[indexPath.row - 1]];
            [self.CHHPVCSubScribedArray removeObjectAtIndex:indexPath.row - 1];
            
        }else if (indexPath.section == 1){
            
            [self.CHHPVCSubScribedArray addObject:self.CHHPVCNotsubscribedArray[indexPath.row]];
            [self.CHHPVCNotsubscribedArray removeObjectAtIndex:indexPath.row];
        }
        
        [_CHHPVCDropCollectionView reloadData];

    }else if (collectionView == _CHHPVCCollectionView){
    
        //改变上面的collectionView的bootomLine的位置
        CGFloat width = 0;
        for (NSInteger i = 0; i < indexPath.row; i++) {
            
            width += [self.CHCurrentItemWidthArr[i] floatValue] + 5;
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [self.CHBottomLineView setFrame:CGRectMake(width, 42, [self.CHCurrentItemWidthArr[indexPath.row] floatValue], 2)];
        [UIView commitAnimations];
        
        //改变正文collectionView的位置
        [self.CHHPVCTextCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        
        
    }else if (collectionView == _CHHPVCTextCollectionView){
    
        NSLog(@"%ld --- %ld",(long)indexPath.section,(long)indexPath.row);
    }
    
}



- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    if (fromIndexPath.section == 0) {
        
        [self.CHHPVCSubScribedArray exchangeObjectAtIndex:fromIndexPath.row - 1 withObjectAtIndex:toIndexPath.row - 1];
       
        
    }else{
        NSLog(@"增加区挪动");
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return NO;
        }
    }
    if (indexPath.section == 1) {
        return NO;
    }
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    
    if (toIndexPath.section == 1) {
        return NO;
    }
    if (toIndexPath.row == 0) {
        return NO;
    }
    return YES;
}

//动态决定每一个ItemSize的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == _CHHPVCCollectionView) {
        
        NSDictionary *fontDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
        
        NSMutableString *str = @"".mutableCopy;
        
        if (indexPath.row == 0) {
            
            str = [self.CHHPVCConfirmedArray[indexPath.row] objectForKey:@"title"];
            
        }else{
        
            str = [self.CHHPVCSubScribedArray[indexPath.row - 1] objectForKey:@"title"];
        }
        
        CGRect rect = [str boundingRectWithSize:CGSizeMake(44, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDic context:nil];
        
        //将当前的ItemSize的大小保存在数组中
        [self.CHCurrentItemWidthArr addObject:@(rect.size.height * 2.4) ];
        return CGSizeMake(rect.size.height * 2.4, 44);
        
    }else if(collectionView == _CHHPVCDropCollectionView){
        
        return CGSizeMake((self.view.bounds.size.width - 20) / 4.0f, 30);
    }else {
    
        return CGSizeMake(WIDTH, HEIGHT - 64);
    }
}


//在这个函数里面对上面那个collectionView添加下划线,根据scrollerView的滑动方向改变下划线的坐标
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    UICollectionView *view = (UICollectionView *)scrollView;
    if (view == _CHHPVCTextCollectionView) {
        
        static CGFloat oldContentOffsetX = 0;
        
        NSInteger row = scrollView.contentOffset.x / self.view.bounds.size.width;
        
//        if (scrollView.contentOffset.x > oldContentOffsetX) {
//            
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:0.1];
//            
//            [self.CHBottomLineView setFrame:CGRectMake(self.CHBottomLineView.frame.origin.x + [self.CHCurrentItemWidthArr[row - 1] integerValue] + 5, 42, [self.CHCurrentItemWidthArr[row] floatValue], 2)];
//            [UIView commitAnimations];
//            
//        }else if (scrollView.contentOffset.x < oldContentOffsetX){
//        
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:0.1];
//            [self.CHBottomLineView setFrame:CGRectMake(self.CHBottomLineView.frame.origin.x - [self.CHCurrentItemWidthArr[row] floatValue] - 5, 42, [self.CHCurrentItemWidthArr[row] integerValue], 2)];
//            [UIView commitAnimations];
//        }
        
        CGFloat width = 0;
        for (NSInteger i = 0; i < row; i++) {
            
            width += [self.CHCurrentItemWidthArr[i] floatValue] + 5;
        }
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [self.CHBottomLineView setFrame:CGRectMake(width, 42, [self.CHCurrentItemWidthArr[row] floatValue], 2)];
        [UIView commitAnimations];
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:scrollView.contentOffset.x / self.view.bounds.size.width inSection:0];
        [self.CHHPVCCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        
        oldContentOffsetX = scrollView.contentOffset.x;
        
    }else if (view == _CHHPVCCollectionView){
        
        NSLog(@"上面");
    }else if (view == _CHHPVCDropCollectionView){
        
        NSLog(@"下面");
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    UICollectionView *view = (UICollectionView *)scrollView;
//    if (view == _CHHPVCTextCollectionView) {
//        
//        static CGFloat oldContentOffsetX = 0;
//        
//        NSInteger row = scrollView.contentOffset.x / self.view.bounds.size.width;
//        
//        if (scrollView.contentOffset.x > oldContentOffsetX) {//向右拐
//            
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:0.1];
//            
//            if (row <= 0) {
//                
//                return ;
//            }
//            [self.CHBottomLineView setFrame:CGRectMake(self.CHBottomLineView.frame.origin.x + [self.CHCurrentItemWidthArr[row - 1] integerValue] + 5, 42, [self.CHCurrentItemWidthArr[row] floatValue], 2)];
//            [UIView commitAnimations];
//            
//        }else if (scrollView.contentOffset.x < oldContentOffsetX){//向左拐
//            
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDuration:0.1];
//            [self.CHBottomLineView setFrame:CGRectMake(self.CHBottomLineView.frame.origin.x - [self.CHCurrentItemWidthArr[row] floatValue] - 5, 42, [self.CHCurrentItemWidthArr[row] integerValue], 2)];
//            [UIView commitAnimations];
//        }
//        
//        NSIndexPath *path = [NSIndexPath indexPathForRow:scrollView.contentOffset.x / self.view.bounds.size.width inSection:0];
//        [self.CHHPVCCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
//        
//        oldContentOffsetX = scrollView.contentOffset.x;
//        
//    }else if (view == _CHHPVCCollectionView){
//        
//        NSLog(@"上面");
//    }else if (view == _CHHPVCDropCollectionView){
//        
//        NSLog(@"下面");
//    }
//}

//改变footerItemSize的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (collectionView == _CHHPVCDropCollectionView) {
        
        if (section == 0) {
            
            return CGSizeMake(self.view.bounds.size.width, 15);
            
        }else{
            
            return CGSizeMake(self.view.bounds.size.width, 70);
        }
    }
    
    return CGSizeMake(0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
