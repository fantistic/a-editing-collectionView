//
//  CHHomePageTypeOneCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/15.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageTypeOneCollectionViewCell.h"

@interface CHHomePageTypeOneCollectionViewCell ()

@property (nonatomic, strong) UITableView *CHTableview;

@property (nonatomic, strong) NSMutableArray *CHModelArray;

@property (nonatomic, strong) NSMutableArray *CHRotateArray;

@property (nonatomic, strong) UICollectionView *CHRetotaCollectionView;

@property (nonatomic, strong) UIButton *CHLocationButton;

@property (nonatomic, strong) CLLocationManager *CHLocationManager;

@property (nonatomic, strong) UITableView *proviceTableview;

@property (nonatomic, strong) UITableView *cityTableview;

@property (nonatomic, strong) NSMutableDictionary *areaDic
;
@property (nonatomic, strong) UISearchBar *proviceSearchBar;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@property (nonatomic, copy) NSString *currentUrl;

@property (nonatomic, copy) NSString *currentCityName;

@property (nonatomic ,strong) UIView *CHWindowView;//给视图铺上一层模糊色

@property (nonatomic, strong) UIButton *proviceCloseButton;//省视图上的关闭按钮

@property (nonatomic, strong) UIButton *proviceBackButton;//省视图上的返回按钮

@property (nonatomic, strong) UITableView *proviceSearTableview;//省区视图搜索框显示的tableView

@property (nonatomic, strong) NSMutableArray *proViceSearArr;//供省区搜索tableView显示的数组

@property (nonatomic ,strong) NSMutableArray *proviceSearShowArr;//搜索框显示的数组(包含城市id,城市中文名,城市英文名)

@property (nonatomic, strong) MBProgressHUD *CHHud;

@property (nonatomic, assign) BOOL CHState;

@end

@implementation CHHomePageTypeOneCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.CHTableview = [[UITableView alloc] init];
        self.CHTableview.delegate = self;
        self.CHTableview.dataSource = self;
        [self.contentView addSubview:_CHTableview];
        
        self.CHState = YES;
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.CHTableview setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height - 49)];
}

- (void)lodData{
    
    if (_CHUrlStr == nil) {
        
        return ;
    }
    
    
    if (self.currentUrl != nil) {
        
        [self.CHLocationButton setTitle:self.currentCityName forState:UIControlStateNormal];
        _CHUrlStr = _currentUrl;
    }
    if (self.CHState) {
        
        self.CHHud = [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
        _CHHud.labelText = @"数据正在加载...";
        [_CHHud hide:YES afterDelay:10];
    }
    
    [CHAFNetWorkTool getUrl:_CHUrlStr body:nil result:DWJSON headerFile:nil sucess:^(id result) {
        
        NSDictionary *dic = [result objectForKey:@"focusList"];
        NSMutableArray *arr = [dic objectForKey:@"focusImgs"];
        self.CHRotateArray = [CHHomePageRotateModel baseModelByArr:arr];
        
        NSMutableArray *dics = [result objectForKey:@"newsList"];
        self.CHModelArray = [CHHomePageModel baseModelByArr:dics];;
        
        [self.CHTableview reloadData];
        
        [self.CHRetotaCollectionView reloadData];
        
        //让他停留一会
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.CHTableview.header endRefreshing];
            
        });
        
        //隐藏菊花
        [_CHHud setHidden:YES];
        
    } failure:^(NSError *error) {
        
        NSLog(@"数据请求失败");
    }];
    
    self.currentUrl = nil;
    
}


//重写set方法,用来请求数据
- (void)setCHUrlStr:(NSString *)CHUrlStr{

    if (![_CHUrlStr isEqualToString:CHUrlStr]) {
        
        _CHUrlStr = CHUrlStr;
        [self lodData];
    }
    self.CHTableview.header = [CHDropRefreshTool headerWithRefreshingBlock:^{
        
        self.CHState = NO;
        [self lodData];
    }];
    
}

//重写set方法,用来更改tableViewCell的样式
- (void)setCHTypeId:(NSInteger)CHTypeId{

    if (_CHTypeId != CHTypeId) {
        
        _CHTypeId = CHTypeId;
        [self createTableHeaderView];
    }
    
}

//根据typeId的不同创建不同的tableViewHeaderView
- (void)createTableHeaderView{

    if (_CHTypeId == 1 && _CHNormal == 1) {//属于最新cell样式
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(self.contentView.bounds.size.width, self.contentView.bounds.size.width / 2.0f)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setMinimumInteritemSpacing:0.0f];
        [flowLayout setMinimumLineSpacing:0.0f];
        
        self.CHRetotaCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.width / 2.0f) collectionViewLayout:flowLayout];
        [_CHRetotaCollectionView setShowsHorizontalScrollIndicator:NO];
        [_CHRetotaCollectionView setShowsVerticalScrollIndicator:NO];
        [_CHRetotaCollectionView setPagingEnabled:YES];
        _CHRetotaCollectionView.delegate = self;
        _CHRetotaCollectionView.dataSource = self;
        [_CHRetotaCollectionView registerClass:[CHHomePageRotateCollectionViewCell class] forCellWithReuseIdentifier:@"RETOTATEREQUSE"];
        
        self.CHTableview.tableHeaderView = _CHRetotaCollectionView;
        
        
    }else if (_CHTypeId == 5 && _CHNormal == 1){//属于行情cell样式,在这里获取当前用户的位置
        
//        [self.CHRetotaCollectionView removeFromSuperview];
//        
//        if ([CLLocationManager locationServicesEnabled]) {
//            
//            self.CHLocationManager = [[CLLocationManager alloc] init];
//        }else{
//            
//            NSLog(@"定位未打开");
//        }
//        self.CHLocationManager.delegate = self;
//        self.CHLocationManager.distanceFilter = kCLDistanceFilterNone;
//        [self.CHLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//        [self.CHLocationManager startUpdatingLocation];
        
        //创建TableView的headView
        
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 44)];
        self.CHTableview.tableHeaderView = tableHeaderView;
        
        self.CHLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_CHLocationButton setFrame:CGRectMake(15, 0, 60, 43)];
        [_CHLocationButton setTitle:@"大连 >" forState:UIControlStateNormal];
        [_CHLocationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_CHLocationButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_CHLocationButton addTarget:self action:@selector(CHLocationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tableHeaderView addSubview: _CHLocationButton];
        
        //创建大连下面的下划线
        UIView *locationBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, self.contentView.bounds.size.width, 0.5)];
        [locationBottomView setBackgroundColor:[UIColor lightGrayColor]];
        [tableHeaderView addSubview:locationBottomView];
        
        
        //加载本地地区数据(放在子线程中去使用)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [self loadAreaData];
        });
        
        UIWindow *window =  [[UIApplication sharedApplication].delegate window];
        //设置模糊色
        self.CHWindowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        [self.CHWindowView setBackgroundColor:[UIColor blackColor]];
        [self.CHWindowView setAlpha:0];
        
        //给contentview添加一个手势,用来使省市视图消失
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        tap.numberOfTapsRequired = 1;
        [self.CHWindowView addGestureRecognizer:tap];

        
        [window addSubview:_CHWindowView];
        
        //定位的省区视图
        self.proviceView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH - 50, HEIGHT)];
#warning 颜色
        [self.proviceView setBackgroundColor:[UIColor lightGrayColor]];
        
        [window addSubview:_proviceView];
        
        UIPanGestureRecognizer *tapV = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapVClick:)];
        [self.proviceView addGestureRecognizer:tapV];
        
        UILabel *proviewLabel = [[UILabel alloc] init];
        proviewLabel.text = @"选择省份";
        [self.proviceView addSubview:proviewLabel];
        [proviewLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//        [proviewLabel setBackgroundColor:[UIColor whiteColor]];
        [proviewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.proviceView.mas_top).offset(20);
            make.centerX.equalTo(self.proviceView.mas_centerX);
            make.height.mas_equalTo(44);
            make.width.equalTo(proviewLabel.mas_height).multipliedBy(2);
            
        }];
        
        //创建省视图上的关闭按钮
        self.proviceCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_proviceCloseButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_proviceCloseButton addTarget:self action:@selector(proviceCloseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_proviceCloseButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.proviceView addSubview:_proviceCloseButton];
        [_proviceCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.proviceView.mas_top).offset(20);
            make.right.equalTo(self.proviceView.mas_right).offset(-10);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(60);
            
        }];
        
        //创建省视图上的返回按钮
        self.proviceBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_proviceBackButton setTitle:@"返回" forState:UIControlStateNormal];
        [_proviceBackButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_proviceBackButton addTarget:self action:@selector(proviceBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.proviceView addSubview:_proviceBackButton];
        [_proviceBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.proviceView.mas_top).offset(20);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(60);
            make.left.equalTo(self.proviceView.mas_left).offset(10);
        }];
        //先将其隐藏起来
        [_proviceBackButton setHidden:YES];

        self.cityView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH - 50, HEIGHT)];
        [_cityView setBackgroundColor:[UIColor lightGrayColor]];
        [self.proviceView addSubview:_cityView];
        
        //创建省区视图的搜索框
        self.proviceSearchBar = [[UISearchBar alloc] init];
        self.proviceSearchBar.delegate = self;
        self.proviceSearchBar.placeholder = @"搜索城市名";
        self.proviceSearchBar.searchBarStyle = UISearchBarStyleMinimal;
        [self.proviceSearchBar setBackgroundColor:[UIColor whiteColor]];
        [self.proviceView addSubview:_proviceSearchBar];
        [self.proviceSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(proviewLabel.mas_bottom);
            make.left.equalTo(self.proviceView.mas_left);
            make.height.mas_equalTo(40);
            make.right.equalTo(self.proviceView.mas_right);
            
        }];
        //创建显示省区的视图
        self.proviceTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.proviceView addSubview:_proviceTableview];
        self.proviceTableview.delegate = self;
        self.proviceTableview.dataSource = self;
        [self.proviceTableview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.proviceSearchBar.mas_bottom);
            make.right.left.bottom.equalTo(self.proviceView);
        }];
        
        //创建省区视图搜索框的tableView
        self.proviceSearTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _proviceSearTableview.delegate = self;
        _proviceSearTableview.dataSource = self;
        [self.proviceView addSubview:_proviceSearTableview];
        [self.proviceSearTableview mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.proviceSearchBar.mas_bottom);
            make.right.left.bottom.equalTo(self.proviceView);
            
        }];
        
        //先将proviceSearTableview隐藏
        [self.proviceSearTableview setHidden:YES];
        
        
        //创建显示城市的视图
        
        UIButton *cityBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cityBackButton setTitle:@"返回" forState:UIControlStateNormal];
//        [cityBackButton setBackgroundColor:[UIColor lightGrayColor]];
        cityBackButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [cityBackButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [cityBackButton addTarget:self action:@selector(cityBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.cityView addSubview:cityBackButton];
        [cityBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.cityView.mas_top).offset(20);
            make.left.equalTo(self.cityView.mas_left);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(60);
        }];
        
        UILabel *cityLabel = [[UILabel alloc] init];
        [cityLabel setText:@"选择城市"];
        [self.cityView addSubview:cityLabel];
        [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self.cityView.mas_centerX);
            make.top.equalTo(self.cityView.mas_top).offset(20);
            make.height.mas_equalTo(44);
            
        }];
        
        self.cityTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.cityTableview.delegate = self;
        self.cityTableview.dataSource = self;
        [self.cityView addSubview:_cityTableview];
        [self.cityTableview mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(cityLabel.mas_bottom);
            make.left.right.bottom.equalTo(self.cityView);
            
        }];
        
        UIButton *cityCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cityCloseButton setTitle:@"关闭" forState:UIControlStateNormal];
//        [cityCloseButton setBackgroundColor:[UIColor redColor]];
        [cityBackButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [cityCloseButton addTarget:self action:@selector(proviceCloseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.cityView addSubview:cityCloseButton];
        [cityCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.cityView.mas_top).offset(20);
            make.right.equalTo(self.cityView.mas_right).offset(-10);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(60);
        }];
        
        //对搜索tableviewd的数组初始化
        self.proViceSearArr = @[].mutableCopy;
        
        
    }else{//其他普通的样式
    
        [self.CHRetotaCollectionView removeFromSuperview];
        self.CHTableview.tableHeaderView = [UIView new];
    }
}

- (void)cityBackButtonClick:(UIButton *)sender{

    [self setViewHidden:YES view:self.cityView];
}

//加载本地地区信息
- (void)loadAreaData{
    
    NSString *fileStr = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:fileStr];
    self.areaDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    //对字典进行初始化
    self.proviceSearShowArr = @[].mutableCopy;
    
    for (NSDictionary *dic in [self.areaDic objectForKey:@"area"]) {
        
        for (NSMutableDictionary *proNameDic in [dic objectForKey:@"provinces"]) {
            
            for (NSMutableDictionary *cityDic in [proNameDic objectForKey:@"cities"]) {
                
                //创建一个字典用来保存当前城市的Id,城市中文名,城市英文名
                NSMutableDictionary *cityDics = [NSMutableDictionary dictionary];
                [cityDics setObject:[cityDic objectForKey:@"cityId"] forKey:@"cityId"];
                [cityDics setObject:[cityDic objectForKey:@"cityName"] forKey:@"cityName"];
                
                NSString *str = [[NSMutableString alloc] initWithString:[cityDic objectForKey:@"cityName"]];
                
                //将汉字转化为拼音保存在字典里面
                if (CFStringTransform((__bridge CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO)){
                    
                    
                }
                if(CFStringTransform((__bridge CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO)){
                   
                    NSString *cityEngilshName = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
                    [cityDics setObject:cityEngilshName forKey:@"cityEngishName"];
                }
                
                [self.proviceSearShowArr addObject:cityDics];
            }
        }
    }
    
}

//让city的视图出现
- (void)showbuttonClick:(UIButton *)sender{
    
    NSLog(@"显示");
    [self setViewHidden:NO view:self.cityView];
}

- (void)backButtonClick:(UIButton *)sender{
    
    [self setViewHidden:YES view:self.cityView];
}


//定位按钮
- (void)CHLocationButtonClick:(UIButton *)sender{

    [self setViewHidden:NO view:self.proviceView];
    [self.proviceTableview setHidden:NO];
    [self.CHWindowView setAlpha:0.5];
    
}

- (void)tapVClick:(UIPanGestureRecognizer *)sender{
    
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)sender;
    CGPoint point = [gesture translationInView:self.proviceView];
    
    if (self.proviceView.frame.origin.x + point.x < 50) {
        
        return ;
        
    }else{
        
        self.proviceView.transform = CGAffineTransformTranslate(self.proviceView.transform, point.x, self.proviceView.frame.origin.y);
        
        if (sender.state == UIGestureRecognizerStateRecognized) {
            
            if (self.proviceView.frame.origin.x + point.x > 220) {
                
                [self setViewHidden:YES view:self.proviceView];
                
                //将模糊色去掉
                [self.CHWindowView setAlpha:0];
            }else{
                
                [self setViewHidden:NO view:self.proviceView];
            }
        }
        
    }
    
    [sender setTranslation:CGPointZero inView:self.proviceView];
    
}

//让省区的关闭按钮让省区视图隐藏起来
- (void)proviceCloseButtonClick:(UIButton *)sender{
    
    [self setViewHidden:YES view:self.proviceView];
    [self.CHWindowView setAlpha:0];
}

//省区的返回按钮
- (void)proviceBackButtonClick:(UIButton *)sender{

    //取消搜索框第一响应者
    [self.proviceSearchBar resignFirstResponder];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [self.proviceView setFrame:CGRectMake(50, 0, WIDTH - 50, HEIGHT)];
    [UIView commitAnimations];
    
    //取消省区tableView的隐藏
    [self.proviceTableview setHidden:NO];
    
    //取消关闭按钮的隐藏
    [self.proviceCloseButton setHidden:NO];
    
    //将返回按钮影藏
    [self.proviceBackButton setHidden:YES];
    
    //将搜索框的tableView隐藏
    [self.proviceSearTableview setHidden:YES];
    
    //将搜索框的内容质空
    self.proviceSearchBar.text = @"";
}

- (void)tapClick:(UITapGestureRecognizer *)sender{
    
    [self setViewHidden:YES view:self.cityView];
    [self setViewHidden:YES view:self.proviceView];
    [self.CHWindowView setAlpha:0];
}


//决定省,城市视图也是否出现,及他的动画效果
- (void)setViewHidden:(BOOL)hidden view:(UIView *)view{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.15];
    if (hidden) {
        
        [view setFrame:CGRectMake(WIDTH, 0, WIDTH - 50, HEIGHT)];
    }else{
        
        if (view == self.cityView) {
            
            [view setFrame:CGRectMake(0, 0, WIDTH - 50, HEIGHT)];
            [self.proviceView bringSubviewToFront:view];
        }else{
            
            [view setFrame:CGRectMake(50, 0, WIDTH - 50, HEIGHT)];
        }
        
    }
    [UIView commitAnimations];
}


#pragma mark - UITableview的协议方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (tableView == _CHTableview) {
        
        return 1;
        
    }else if (tableView == _proviceTableview){//省区数组的section个数
    
        return [[self.areaDic objectForKey:@"area"] count];
        
    }else if (tableView == _cityTableview){//城市数组的个数
    
        return 1;
        
    }else if (tableView == _proviceSearTableview){//搜索框tableview
    
        return 1;
    
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == _CHTableview) {
        
        return self.CHModelArray.count;
        
    }else if (tableView == _proviceTableview){//省区数组的section个数
        
        return [[[self.areaDic objectForKey:@"area"][section] objectForKey:@"provinces"] count];
        
    }else if (tableView == _cityTableview){//城市数组的个数
        
//        return [[self.areaDic objectForKey:@"area"][section] ];
        if (self.currentIndexPath == nil) {
            
            return 0;
        }
        return [[[[self.areaDic objectForKey:@"area"][self.currentIndexPath.section] objectForKey:@"provinces"][0] objectForKey:@"cities"] count];
        
    }else if (tableView == _proviceSearTableview){//搜索框tableview
    
        return self.proViceSearArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _CHTableview) {//正文tableView
        
        static NSString *requse = @"TYPEONECELL";
        CHHomePageTypeOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
        if (!cell) {
            
            cell = [[CHHomePageTypeOneTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
        }
        
        if (self.CHModelArray.count > indexPath.row) {
            
            CHHomePageModel *model = self.CHModelArray[indexPath.row];
            //评论数
            cell.CHMessageLabel.text = [model.commentCount stringValue];
            
            //图片
            [cell.CHLeftImageview sd_setImageWithURL:[NSURL URLWithString:model.newsImage]];
            
            //标题
            cell.CHTitleLabel.text = model.newsTitle;
            
            //时间
            NSInteger differ = [model.newsCreateTime integerValue];
            NSDate *times =[NSDate dateWithTimeIntervalSince1970:differ + 28800];
            NSString *str = [NSString stringWithFormat:@"%@",times];
            NSString *newStr = [str substringToIndex:10];
            cell.CHTimeLabel.text = [NSString stringWithFormat:@"%@",newStr];
            
            //类别
            cell.CHNewsLabel.text = model.newsCategory;
            
            //图标
            cell.CHMessageIcon.image = [UIImage imageNamed:@"baitian_pinglun_old"];
        }
        
        return cell;
        
    }else if (tableView == _proviceTableview){//省区数组
        
        static NSString *requse = @"PROVICEREQUSE";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:requse];
        }
        cell.textLabel.text = [[[self.areaDic objectForKey:@"area"][indexPath.section] objectForKey:@"provinces"][indexPath.row] objectForKey:@"name"];
        cell.textLabel.textColor = [UIColor blackColor];
//        [cell.textLabel setFont:[UIFont systemFontOfSize:20]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        return cell;
        
    }else if (tableView == _cityTableview){//城市数组
        
        static NSString *requse = @"CITYREQUSE";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:requse];
        }
        cell.textLabel.text = [[[[self.areaDic objectForKey:@"area"][self.currentIndexPath.section] objectForKey:@"provinces"][0] objectForKey:@"cities"][indexPath.row] objectForKey:@"cityName"];
        cell.textLabel.textColor = [UIColor blackColor];
//        [cell.textLabel setFont:[UIFont systemFontOfSize:20]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        return cell;
        
    }else if (tableView == _proviceSearTableview){//搜索框tableview
    
        static NSString *requse = @"SEARCHREQUSE";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:requse];
        }
        if (self.proViceSearArr.count > indexPath.row) {
            
            cell.textLabel.text = [self.proViceSearArr[indexPath.row] objectForKey:@"cityName"];
        }
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _CHTableview) {
        
        //在这里处理cell的点击方法
        CHHomePageModel *model =  self.CHModelArray[indexPath.row];
        self.pushBlock(model.newsLink);
        
        
    }else if (tableView == _proviceTableview){
    
        NSLog(@"省区cell");
        
        self.currentIndexPath = indexPath;
        if ([[[[self.areaDic objectForKey:@"area"][indexPath.section] objectForKey:@"provinces"][0] objectForKey:@"cities"] count] > 1) {
            
            [self setViewHidden:NO view:self.cityView];
            [self.cityTableview reloadData];
            
            
        }else{
        
            [self.CHWindowView setAlpha:0];
            [self setViewHidden:YES view:self.proviceView];
            
            NSInteger CityID = [[[[[self.areaDic objectForKey:@"area"][indexPath.section] objectForKey:@"provinces"][0] objectForKey:@"cities"][0] objectForKey:@"cityId"] integerValue];
            self.currentUrl =  [NSString stringWithFormat:CITYURL];
            self.currentCityName = [NSString stringWithFormat:@"%@ >",[[[[self.areaDic objectForKey:@"area"][self.currentIndexPath.section] objectForKey:@"provinces"][0] objectForKey:@"cities"][indexPath.row] objectForKey:@"cityName"]];
            
            //在这里刷新视图(变化的的只是cityId)
            [self lodData];
            
        }
        
    }else if (tableView == _cityTableview){
    
        [self.CHWindowView setAlpha:0];
        [self setViewHidden:YES view:self.proviceView];
        
        NSInteger CityID = [[[[[self.areaDic objectForKey:@"area"][self.currentIndexPath.section] objectForKey:@"provinces"][0] objectForKey:@"cities"][indexPath.row] objectForKey:@"cityId"] integerValue];
        self.currentUrl = [NSString stringWithFormat:CITYURL];
        self.currentCityName = [NSString stringWithFormat:@"%@ >",[[[[self.areaDic objectForKey:@"area"][self.currentIndexPath.section] objectForKey:@"provinces"][0] objectForKey:@"cities"][indexPath.row] objectForKey:@"cityName"]];
        
        //在这里刷新视图
        [self lodData];
        
    }else if (tableView == _proviceSearTableview){//搜索框的tableView
    
        if (self.proViceSearArr.count > 0) {
            
            //注销搜索框的第一响应者身份
            [self.proviceSearchBar resignFirstResponder];
            
            //将windows的模糊色去掉
            [self.CHWindowView setAlpha:0];
            
            //将搜索框的tableView视图隐藏掉
            [self.proviceSearTableview setHidden:YES];
            
            //将省视图隐藏掉
//            [self.proviceView setHidden:YES];
//            [self.proviceView removeFromSuperview];
            [self setViewHidden:YES view:self.proviceView];
            //
            NSInteger CityID = [[self.proViceSearArr[indexPath.row] objectForKey:@"areaId"] integerValue];
            self.currentUrl = [NSString stringWithFormat:CITYURL];
            self.currentCityName = [NSString stringWithFormat:@"%@ >",[self.proViceSearArr[indexPath.row] objectForKey:@"cityName"]];
            //刷新视图
            [self lodData];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (tableView == _CHTableview) {
        
        return nil;
        
    }else if (tableView == _proviceTableview){
    
        return [[self.areaDic objectForKey:@"area"][section] objectForKey:@"letter"];
        
    }else if (tableView == _cityTableview){
        
        return [NSString stringWithFormat:@"%@省",[[[self.areaDic objectForKey:@"area"][self.currentIndexPath.section] objectForKey:@"provinces"][0] objectForKey:@"name"]];
        
    }else if (tableView == _proviceSearTableview){//搜索框tableview
    
        return nil;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == _CHTableview) {
        
        return 100;
        
    }else if (tableView == _proviceTableview){//省区数组的section个数
        
        return 60;
        
    }else if (tableView == _cityTableview){//城市数组的个数
        
        return 60;
        
    }else if (tableView == _proviceSearTableview){//搜索框tableview
    
        return 60;
    }
    return 0;
}


#pragma mark - UICollectionView的协议方法(最新页面的轮播图)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.CHRotateArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CHHomePageRotateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RETOTATEREQUSE" forIndexPath:indexPath];
    CHHomePageRotateModel *model = self.CHRotateArray[indexPath.row];
    [cell.CHrotateImageview sd_setImageWithURL:[NSURL URLWithString:model.imgURL]];
    
    return cell;
}

#pragma mark - UISearchBar的协议方法

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [self.proviceView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [UIView commitAnimations];
    
    //让省区的返回按钮显示出来
    [self.proviceBackButton setHidden:NO];
    
    //隐藏省区的关闭按钮
    [self.proviceCloseButton setHidden:YES];
    
    //将省区数组的tableView隐藏起来
    [self.proviceTableview setHidden:YES];
    
    //将搜索框的tableView显示出来
    [self.proviceSearTableview setHidden:NO];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self.proViceSearArr removeAllObjects];
    NSMutableString *str = [[NSMutableString alloc] initWithString:searchText];
    if (CFStringTransform((__bridge CFMutableStringRef)str, 0, kCFStringTransformMandarinLatin, NO))
    {
    }
    if (CFStringTransform((__bridge CFMutableStringRef)str, 0, kCFStringTransformStripDiacritics, NO))
    {
    }
    NSString *text = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    //当搜索的文字发生改变时,对数组进行赋值
    for (NSDictionary *dic in self.proviceSearShowArr) {
        
        if ([[[dic objectForKey:@"cityEngishName"] uppercaseString] rangeOfString:[text uppercaseString]].location != NSNotFound) {
            
            [self.proViceSearArr addObject:dic];
            
        }
    }
    [self.proviceSearTableview reloadData];
}


#pragma mark - UIScrollewView的协议方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //取消搜索框的第一响应者
    [self.proviceSearchBar resignFirstResponder];
}


@end
