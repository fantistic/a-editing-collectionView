//
//  CHHomePageSearchViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/14.
//  Copyright © 2015年 luo. All rights reserved.
//

//第一次搜索的网址
#define URL @"http://mi.xcar.com.cn/interface/xcarapp/getSearchAd.php?param=param"

//热门搜索的网址
#define SEARCHURL @"http://mi.xcar.com.cn/interface/xcarapp/searchAll.php?searchContent="

//综合网址
#define COMPLEXURL @"http://mi.xcar.com.cn/interface/xcarapp/searchAll.php?cityId=475&searchContent="
//文章网址
#define ARTICLEURL @"http://mi.xcar.com.cn/interface/xcarapp/searchNews.php?page=1&searchContent="
//车系网址
#define CARSYRL @"http://mi.xcar.com.cn/interface/xcarapp/searchCar.php?cityId=475&searchContent="
//帖子网址
#define POSTSURL @"http://mi.xcar.com.cn/interface/xcarapp/searchPost.php?page=1&searchContent="

#import "CHHomePageSearchViewController.h"

@interface CHHomePageSearchViewController ()

@property (nonatomic, strong) UISearchBar *CHSearchBar;

@property (nonatomic, strong) UITableView *CHTableView;

@property (nonatomic, strong) NSMutableArray *CHSearChArray;

@property (nonatomic, strong) UICollectionView *CHCollectionView;

@property (nonatomic, strong) UILabel *CHPopularSearches;

@property (nonatomic, strong) UIView *searchView;

@property (nonatomic, strong) UISegmentedControl *searchSegController;

@property (nonatomic, strong) UITableView *searchComPlexTableView;

@property (nonatomic, strong) UITableView *searchArticleTableView;

@property (nonatomic, strong) UIPageViewController *searchPageViewController;

@property (nonatomic, strong) NSArray *controllerArr;

@property (nonatomic, strong) NSIndexPath *CHCurrentIndexPath;//CollectionView当前的indexPath

@property (nonatomic, strong) NSIndexPath *CHCurrentTableViewIndexPath;//TableView当前的indepath

@property (nonatomic, copy) NSString *UrlResult;//保存网址后面的汉字

@property (nonatomic, strong) UITableView *searchRecordTableView;

@property (nonatomic, strong) NSMutableArray *searchRecordArr;

@property (nonatomic, strong) UIButton *CHVoiceButton;//语音按钮

@property (nonatomic, strong) UIButton *CHVoiceShowButton;//语音显示按钮,显示在试图中间

@property (nonatomic, strong) UIView *CHVoiceShowView;//语音显示View改变背景色

@property (nonatomic, strong) UIImageView *CHVoiceImageView;//语音显示圆圈

@property (nonatomic, strong) UIView *CHVoiceButtonView;//改变语音的语音按钮的颜色,根据音量

@property (nonatomic, strong) IFlySpeechUnderstander *iFlySpeechUnderstander;//科大讯飞语义接口

//科大讯飞使用的类
@property (nonatomic,strong) NSString *result;

@property (nonatomic,strong) NSString *str_result;

@property (nonatomic) BOOL isCanceled;

@property (nonatomic, assign) BOOL state;

@property (nonatomic, assign) NSInteger iflyTime;

@property (nonatomic, assign) NSInteger iflyVolume;

@end

@implementation CHHomePageSearchViewController

- (void)loadData{

    [CHAFNetWorkTool getUrl:URL body:nil result:DWJSON headerFile:nil sucess:^(id result) {
        
        self.CHSearChArray = result;
        [self.CHCollectionView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"加载失败");
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.searchRecordArr = @[].mutableCopy;
    [self.searchRecordArr addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"SEARCHRECORDARR"]];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.CHSearchBar removeFromSuperview];
    [self.CHVoiceButton removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setValue:self.searchRecordArr forKey:@"SEARCHRECORDARR"];
    
    //科大讯飞
    [_iFlySpeechUnderstander cancel];
    _iFlySpeechUnderstander.delegate = self;
    [_iFlySpeechUnderstander destroy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick:)];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    self.CHSearchBar = [[UISearchBar alloc] init];
    _CHSearchBar.delegate = self;
    _CHSearchBar.placeholder = @"请输入关键词";
    _CHSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.navigationController.navigationBar addSubview:_CHSearchBar];
    [_CHSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.navigationController.view.mas_top).offset(20);
        make.height.mas_equalTo(44);
        make.right.equalTo(self.navigationController.view.mas_right).offset(-10);
        make.width.equalTo(self.navigationController.view.mas_width).multipliedBy(0.8);
    }];
    
    //语音搜索按钮
    UIImage *voiceImage = [UIImage imageNamed:@"mai_black_h"];
    self.CHVoiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_CHVoiceButton setBackgroundImage:voiceImage forState:UIControlStateNormal];
    [self.CHVoiceButton addTarget:self action:@selector(CHVoiceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.CHSearchBar addSubview:_CHVoiceButton];
    [_CHVoiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.CHSearchBar.mas_right).offset(-5);
        make.width.equalTo(_CHVoiceButton.mas_height).multipliedBy(0.8);
        make.top.equalTo(self.CHSearchBar.mas_top).offset(10);
        make.bottom.equalTo(self.CHSearchBar.mas_bottom).offset(-10);
        
    }];
    
    self.CHPopularSearches = [[UILabel alloc] init];
    [_CHPopularSearches setBackgroundColor:[UIColor lightGrayColor]];
    [_CHPopularSearches setText:@"热门搜索"];
    [_CHPopularSearches setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_CHPopularSearches];
    [_CHPopularSearches mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.left.equalTo(self.view.mas_left).offset(10);
        
    }];
    
    //创建搜索记录TableView
    self.searchRecordTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.searchRecordTableView.delegate = self;
    self.searchRecordTableView.dataSource = self;
    [self.view addSubview:_searchRecordTableView];
    [self.searchRecordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self.view);
    }];
    [self.searchRecordTableView setHidden:YES];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(self.view.bounds.size.width / 2.0, 60)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    ///设置collectionView的FooterSize
    [flowLayout setFooterReferenceSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 300 - 64 - 48)];
    self.CHCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.CHCollectionView.delegate = self;
    self.CHCollectionView.dataSource = self;
    [self.CHCollectionView setBackgroundColor:[UIColor clearColor]];
    self.CHCollectionView.showsHorizontalScrollIndicator = NO;
    self.CHCollectionView.showsVerticalScrollIndicator = NO;
    [self.CHCollectionView setBackgroundColor:[UIColor lightGrayColor]];
    [self.CHCollectionView registerClass:[CHHomePageSearchCollectionViewCell class] forCellWithReuseIdentifier:@"SEARCHREQUSE"];
    [self.view addSubview:self.CHCollectionView];
    [self.CHCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
        make.top.equalTo(_CHPopularSearches.mas_bottom);
        
        
    }];
    
    [self loadData];
    
    /*
     创建搜索显示界面的视图
     */
    self.searchView = [[UIView alloc] init];
    [self.view addSubview:_searchView];
#warning 颜色
    [_searchView setBackgroundColor:[UIColor whiteColor]];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    NSArray *searchArr = [NSArray arrayWithObjects:@"综合",@"文章",@"车系",@"帖子", nil];
    self.searchSegController = [[UISegmentedControl alloc] initWithItems:searchArr];
    [_searchView addSubview:_searchSegController];
    [self.searchSegController mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_searchView.mas_top).offset(5);
        make.left.equalTo(_searchView.mas_left).offset(15);
        make.right.equalTo(_searchView.mas_right).offset(-15);
        make.height.mas_equalTo(30);
        
    }];
    self.searchSegController.selectedSegmentIndex = 0;
    [self.searchSegController addTarget:self action:@selector(searchSegControllerClick:) forControlEvents:UIControlEventValueChanged];
    
    CHHomePageComplexViewController *CHComplexController = [[CHHomePageComplexViewController alloc] init];
    //给综合视图设置网络请求网址
//    CHComplexController.CHComPlexUrl = url;
//    CHComplexController.CHComplexName = self.CHSearChArray[indexPath.row];
    CHHomePageArticleViewController *CHArticleController = [[CHHomePageArticleViewController alloc] init];
    CHHomePageCarsViewController *CHCarsController = [[CHHomePageCarsViewController alloc] init];
    CHHomePagePostsViewController *CHPostsController = [[CHHomePagePostsViewController alloc] init];
    self.controllerArr = [NSArray arrayWithObjects:CHComplexController,CHArticleController,CHCarsController,CHPostsController, nil];
    
    self.searchPageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.searchPageViewController.delegate = self;
    self.searchPageViewController.dataSource = self;
    [self addChildViewController:_searchPageViewController];
    [self.searchView addSubview:_searchPageViewController.view];
    [self.searchPageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.searchSegController.mas_bottom).offset(5);
        make.left.right.bottom.equalTo(self.searchView);
        
    }];
    
    UIScrollView *scrollView = self.searchPageViewController.view.subviews[0];
    
    [scrollView setScrollEnabled:NO];
    
    [self.searchView setHidden:YES];
    
    //科大讯飞(获取单例)
    _iFlySpeechUnderstander = [IFlySpeechUnderstander sharedInstance];
    _iFlySpeechUnderstander.delegate = self;
    
    //初始化状态来保证点击语音按钮时(试图只创建一次)
    self.state = YES;
    
    //设置音量初始化话大小为0
    self.iflyVolume = 0;
}

//手势的触发方法用来移除试图

- (void)tapGestureClick:(UITapGestureRecognizer *)gesture{

    [self.CHVoiceShowView removeFromSuperview];
    //关闭会话
    [_iFlySpeechUnderstander stopListening];
    [UIView commitAnimations];
}

//语音搜索按钮
- (void)CHVoiceButtonClick:(UIButton *)sender{

    if (!self.state) {
        
        return ;
    }
    self.state = NO;
    self.iflyTime = 0;
    
    self.CHVoiceShowView = [[UIView alloc] init];
    [self.CHVoiceShowView setBackgroundColor:[UIColor whiteColor]];
    [self.CHVoiceShowView setAlpha:0.9];
    [self.view addSubview:_CHVoiceShowView];
    [self.CHVoiceShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    //添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture addTarget:self action:@selector(tapGestureClick:)];
    [self.CHVoiceShowView addGestureRecognizer:tapGesture];
    
    self.CHVoiceButtonView = [[UIView alloc] init];
    [self.CHVoiceButtonView setBackgroundColor:[UIColor blueColor]];
    [self.CHVoiceShowView addSubview:_CHVoiceButtonView];
    
    self.CHVoiceShowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"yuyin"];
//    [self.CHVoiceShowButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.CHVoiceShowButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.CHVoiceShowView addSubview:_CHVoiceShowButton];
    [self.CHVoiceShowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.CHVoiceShowView.mas_centerX);
        make.centerY.equalTo(self.CHVoiceShowView.mas_centerY);
        make.width.mas_equalTo(image.size.width);
        make.height.mas_equalTo(image.size.height);
    }];
    self.CHVoiceShowButton.layer.cornerRadius = image.size.width / 2.0;
    self.CHVoiceShowButton.layer.masksToBounds = YES;
    
    [self.CHVoiceButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.CHVoiceShowButton.mas_bottom);
        make.centerX.equalTo(self.CHVoiceShowButton.mas_centerX);
        make.width.equalTo(self.CHVoiceShowButton.mas_width);
//        make.height.equalTo(self.CHVoiceShowButton.mas_height);
        make.height.mas_equalTo(1);
        
    }];
    
    self.CHVoiceButtonView.layer.cornerRadius = image.size.width / 2.0;
    self.CHVoiceButtonView.layer.masksToBounds = YES;
    
    UIImage *CircleImage = [UIImage imageNamed:@"weixuan-1"];
    self.CHVoiceImageView = [[UIImageView alloc] init];
    self.CHVoiceImageView.image = CircleImage;
    [self.CHVoiceImageView setAlpha:1];
    [self.CHVoiceShowView addSubview:_CHVoiceImageView];
    [self.CHVoiceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.CHVoiceShowButton.mas_centerX);
        make.centerY.equalTo(self.CHVoiceShowButton.mas_centerY);
        make.width.equalTo(self.CHVoiceShowButton.mas_width);
        make.height.equalTo(self.CHVoiceShowButton.mas_height);
    }];
    
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        
        CATransform3D transform = CATransform3DMakeScale(3, 3, 1.0);
        _CHVoiceImageView.layer.transform = transform;
        _CHVoiceImageView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [_CHVoiceImageView removeFromSuperview];
        [UIView commitAnimations];
    }];
    
    //开始一次会话
    BOOL rect = [_iFlySpeechUnderstander startListening];
    
    if(rect){
    
        self.isCanceled = NO;
        NSLog(@"启动成功");
        
    }else{
        
        NSLog(@"启动失败");
    }
}

#pragma mark - 科大讯飞的协议方法
- (void)onVolumeChanged:(int)volume{
    
    
    self.iflyVolume = volume;
    
    [self.CHVoiceButtonView setFrame:CGRectMake(self.CHVoiceShowButton.frame.origin.x, self.CHVoiceShowButton.frame.origin.y + self.CHVoiceShowButton.frame.size.height, self.CHVoiceShowButton.frame.size.width, - self.CHVoiceShowButton.frame.size.height * volume / 100.0 * 2)];
    self.CHVoiceButtonView.center = self.CHVoiceShowButton.center;
//    [self.CHVoiceButtonView setNeedsUpdateConstraints];

    
}

//- (void)updateViewConstraints{
//
//    [self.CHVoiceButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.equalTo(self.CHVoiceShowButton.mas_bottom);
//        make.width.equalTo(self.CHVoiceShowButton.mas_width);
//        make.height.mas_equalTo(self.iflyVolume / 100.0);
//        
//    }];
//    
//    [super updateViewConstraints];
//}

//开始说话是触发的方法
- (void)onBeginOfSpeech{
    
    NSLog(@"开始会话");
    
}

//结束说话时触发的方法
- (void)onEndOfSpeech{

    NSLog(@"结束会话");
}

- (void) onError:(IFlySpeechError *) error
{
    self.state = YES;
    NSString *text ;
    if (self.isCanceled) {
        text = @"识别取消";
    }
    else if (error.errorCode ==0 ) {
        if (_result.length==0) {
            text = @"无识别结果";
        }
        else{
            text = @"识别成功";
        }
    }
    else{
        text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
        NSLog(@"%@",text);
    }
    //将试图移除
    [self.CHVoiceShowView removeFromSuperview];
    
//    [self.CHSearchBar resignFirstResponder];
//    NSString *str1 = [NSString stringWithFormat:@"%@%@",COMPLEXURL,@"对不起"];
//    NSString *url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str1, NULL, NULL, kCFStringEncodingUTF8));
//    [self.searchView setHidden:NO];
//    CHHomePageComplexViewController *CHComplexController = self.controllerArr[0];
//    CHComplexController.CHComPlexUrl = url;
//    CHComplexController.CHComplexName = _result;
//    [self.searchPageViewController setViewControllers:@[CHComplexController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

}

- (void)onResults:(NSArray *)results isLast:(BOOL)isLast{
    
    self.state = YES;
    ++self.iflyTime;
    
    if (self.iflyTime > 1) {
        
        return ;
    }
    
    NSArray *temp = [[NSArray alloc] init];
    NSString *str = [[NSString alloc] init];
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        
        [result appendFormat:@"%@",key];
    }
    
    NSLog(@"听写结果为%@",result);
    
    NSLog(@"听写结果：%@",result);
    //---------讯飞语音识别JSON数据解析---------//
    NSError * error;
    NSData * data = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dic_result =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"%@",dic_result);
    NSArray * array_ws = [dic_result objectForKey:@"ws"];
    //遍历识别结果的每一个单词
    for (int i = 0; i < array_ws.count; i++) {
        
        temp = [[array_ws objectAtIndex:i] objectForKey:@"cw"];
        NSDictionary * dic_cw = [temp objectAtIndex:0];
        str = [str  stringByAppendingString:[dic_cw objectForKey:@"w"]];
        NSLog(@"识别结果:%@",[dic_cw objectForKey:@"w"]);
        
    }
    
    NSLog(@"最终的识别结果:%@",str);
    
    //去掉识别结果最后的标点符号
    if ([str isEqualToString:@"。"] || [str isEqualToString:@"？"] || [str isEqualToString:@"！"]) {
        
        NSLog(@"末尾标点符号：%@",str);
        
    }
    else{
        
        self.CHSearchBar.text = str;
        
    }
    _result = str;
    self.UrlResult = _result;
    
    //在将语音转化为文本的的时候将显示视图移除
    [self.CHVoiceShowView removeFromSuperview];
    [self.CHVoiceButton removeFromSuperview];
    
    //拼接网址
    [self.CHSearchBar resignFirstResponder];
    NSString *str1 = [NSString stringWithFormat:@"%@%@",COMPLEXURL,_UrlResult];
    NSString *url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str1, NULL, NULL, kCFStringEncodingUTF8));
    [self.searchView setHidden:NO];
    CHHomePageComplexViewController *CHComplexController = self.controllerArr[0];
    CHComplexController.CHComPlexUrl = url;
    CHComplexController.CHComplexName = _result;
    [self.searchPageViewController setViewControllers:@[CHComplexController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
//    [_iFlySpeechUnderstander stopListening];

    
}

#pragma mark - UISearchBar的协议方法

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    [self.CHCollectionView removeFromSuperview];
    [self.searchView setHidden:YES];
    [self.searchRecordTableView setHidden:NO];
    [self.searchRecordTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    if (![self.searchRecordArr containsObject:searchBar.text]) {
        
        [self.searchRecordArr addObject:searchBar.text];
    }
    
    [self.CHVoiceButton setHidden:YES];
    NSString *str = [NSString stringWithFormat:@"%@%@",COMPLEXURL,searchBar.text];
    self.UrlResult = searchBar.text;
    NSString *url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, NULL, kCFStringEncodingUTF8));
    [self.searchView setHidden:NO];
    CHHomePageComplexViewController *CHComplexController = self.controllerArr[0];
    CHComplexController.CHComPlexUrl = url;
    CHComplexController.CHComplexName = searchBar.text;
    [self.searchPageViewController setViewControllers:@[CHComplexController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [searchBar resignFirstResponder];
    
    [self.searchView setHidden:NO];

}

#pragma masrk - collectionView的协议方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.CHSearChArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CHHomePageSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SEARCHREQUSE" forIndexPath:indexPath];
    
    if (self.CHSearChArray.count > 0) {
        
        cell.CHRecommendLabel.text = self.CHSearChArray[indexPath.row];
        cell.CHtopImageview.image = [UIImage imageNamed:@"tuijian"];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [self.CHVoiceButton removeFromSuperview];
    self.CHSearchBar.text = self.CHSearChArray[indexPath.row];
    //将选中的cell的加入到搜索记录的数组里面
    if (![self.searchRecordArr containsObject:self.CHSearChArray[indexPath.row]]) {
        
        [self.searchRecordArr addObject:self.CHSearChArray[indexPath.row]];
    }
    
    self.CHCurrentIndexPath = indexPath;
    self.UrlResult = self.CHSearChArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@%@",COMPLEXURL,self.CHSearChArray[indexPath.row]];
    NSString *url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, NULL, kCFStringEncodingUTF8));
    
    [self.CHCollectionView removeFromSuperview];
    [self.CHPopularSearches removeFromSuperview];
    
    //给综合视图设置网络请求网址
    [self.searchView setHidden:NO];
    CHHomePageComplexViewController *CHComplexController = self.controllerArr[0];
    CHComplexController.CHComPlexUrl = url;
    CHComplexController.CHComplexName = self.CHSearChArray[indexPath.row];
    [self.searchPageViewController setViewControllers:@[CHComplexController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

}

//返回上一一视图
- (void)leftBarButtonItemClick:(UIBarButtonItem *)sender{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createArticleTableview{

    self.searchArticleTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.searchArticleTableView.delegate = self;
    self.searchArticleTableView.dataSource = self;
    [_searchView addSubview:self.searchArticleTableView];
    [self.searchArticleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.searchSegController.mas_bottom).offset(5);
        make.right.left.bottom.equalTo(_searchView);
    }];
    
    
}


//UISegmentedControl的点击方法
- (void)searchSegControllerClick:(UISegmentedControl *)seg{

    switch (seg.selectedSegmentIndex) {
        case 0:{
        
            [self.searchPageViewController setViewControllers:@[self.controllerArr[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            break;
        
        }
        case 1:
        {
        
            NSString *str = nil;
            if (self.CHCurrentIndexPath != nil) {//说明点击的是热门搜索
                
                str = [NSString stringWithFormat:@"%@%@",ARTICLEURL,self.CHSearChArray[self.CHCurrentIndexPath.row]];
            }else if (self.CHCurrentTableViewIndexPath != nil){//根据tableView选中Cell的搜索
            
                str = [NSString stringWithFormat:@"%@%@",ARTICLEURL,self.searchRecordArr[self.CHCurrentTableViewIndexPath.row]];
            }else{//根据用户输入进行搜索
                
                str = [NSString stringWithFormat:@"%@%@",ARTICLEURL,self.UrlResult];
            }
            
            NSString *url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, NULL, kCFStringEncodingUTF8));
            CHHomePageArticleViewController *articleController = self.controllerArr[1];
            articleController.CHArticleUrl = url;
            [self.searchPageViewController setViewControllers:@[self.controllerArr[1]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            break;
        }
        case 2:{
            
            NSString *str = nil;
            if (self.CHCurrentIndexPath != nil) {//说明点击的是热门搜索
                
                str = [NSString stringWithFormat:@"%@%@",CARSYRL,self.CHSearChArray[self.CHCurrentIndexPath.row]];
            }else if (self.CHCurrentTableViewIndexPath != nil){//根据tableView选中Cell的搜索
                
                str = [NSString stringWithFormat:@"%@%@",CARSYRL,self.searchRecordArr[self.CHCurrentTableViewIndexPath.row]];
            }else{//根据用户输入进行搜索
                
                str = [NSString stringWithFormat:@"%@%@",CARSYRL,self.UrlResult];
            }
            
            NSString *url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, NULL, kCFStringEncodingUTF8));
            CHHomePageCarsViewController *carsController = self.controllerArr[2];
            carsController.CHCarsUrl = url;
            [self.searchPageViewController setViewControllers:@[self.controllerArr[2]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            break;

            
        }
        case 3:
        {
            NSString *str = nil;
            if (self.CHCurrentIndexPath != nil) {//说明点击的是热门搜索
                
                str = [NSString stringWithFormat:@"%@%@",POSTSURL,self.CHSearChArray[self.CHCurrentIndexPath.row]];
            }else if (self.CHCurrentTableViewIndexPath != nil){//根据tableView选中Cell的搜索
                
                str = [NSString stringWithFormat:@"%@%@",POSTSURL,self.searchRecordArr[self.CHCurrentTableViewIndexPath.row]];
            }else{//根据用户输入进行搜索
                
                str = [NSString stringWithFormat:@"%@%@",POSTSURL,self.UrlResult];
            }

            NSString *url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, NULL, kCFStringEncodingUTF8));
            CHHomePagePostsViewController *postsController = self.controllerArr[3];
            postsController.CHPostsUrl = url;
            [self.searchPageViewController setViewControllers:@[self.controllerArr[3]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            break;
        
        }
        default:
            break;
    }
}

#pragma mark - UIPageviewController的协议方法

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    NSUInteger index = [self.controllerArr indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) {
        
        return nil;
    }
    index --;
    return self.controllerArr[index];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    NSUInteger index = [self.controllerArr indexOfObject:viewController];
    if (index == NSNotFound) {
        
        return nil;
    }
    index ++;
    if (index == self.controllerArr.count) {
        
        return nil;
    }
    
    return self.controllerArr[index];
}

#pragma mark - UiTableview的协议方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.searchRecordArr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{

    if (self.searchRecordArr.count > 0) {
        
        return @"清楚历史记录";
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (self.searchRecordArr.count > 0) {
        
        UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
        
        UIView *headLine = [[UIView alloc] init];
        [headLine setBackgroundColor:[UIColor grayColor]];
        [clearView addSubview:headLine];
        [headLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(clearView.mas_top).offset(0.5);
            make.right.left.equalTo(clearView);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *footerLine = [[UIView alloc] init];
        [footerLine setBackgroundColor:[UIColor grayColor]];
        [clearView addSubview:footerLine];
        [footerLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.left.equalTo(clearView);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(clearView.mas_bottom).offset(-0.5);
        }];
        
        UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton setTitle:@"清楚历史记录" forState:UIControlStateNormal];
        [clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [clearButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        clearButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [clearView addSubview:clearButton];
        [clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(clearView.mas_centerX);
            make.centerY.equalTo(clearView.mas_centerY);
            make.left.right.equalTo(clearView);
            make.top.equalTo(headLine.mas_bottom);
            make.bottom.equalTo(footerLine.mas_top);
        }];
        
        return clearView;
    }
    
    return nil;
    
}

- (void)clearButtonClick:(UIButton *)sender{

    [self.searchRecordArr removeAllObjects];
    [self.searchRecordTableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.searchRecordArr.count > 0) {
        
        return 60;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (self.searchRecordArr.count > 0) {
        
        return 40;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.searchRecordArr.count > 0) {
        
        static NSString *requse = @"SEARCHRECORDREQUSE";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:requse];
            [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
        }
        
        cell.textLabel.text = self.searchRecordArr[indexPath.row];
        
        return cell;

    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.CHVoiceButton removeFromSuperview];
    self.CHSearchBar.text = self.searchRecordArr[indexPath.row];
    self.CHCurrentTableViewIndexPath = indexPath;
    [self.CHSearchBar resignFirstResponder];
    NSString *str = [NSString stringWithFormat:@"%@%@",COMPLEXURL,self.searchRecordArr[indexPath.row]];
    NSString *url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, NULL, kCFStringEncodingUTF8));
    [self.searchView setHidden:NO];
    CHHomePageComplexViewController *CHComplexController = self.controllerArr[0];
    CHComplexController.CHComPlexUrl = url;
    CHComplexController.CHComplexName = self.searchRecordArr[indexPath.row];
    [self.searchPageViewController setViewControllers:@[CHComplexController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView == self.searchRecordTableView) {
        
//        static OneTimeBlock block = ^(UISearchBar *searchBar){
        
        [self.CHSearchBar resignFirstResponder];
        
//        };
//        block(self.CHSearchBar);
        
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
