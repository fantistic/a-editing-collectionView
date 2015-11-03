//
//  CHCraInfoCollectionViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/21.
//  Copyright © 2015年 luo. All rights reserved.
//



#import "CHCraInfoCollectionViewCell.h"


@interface CHCraInfoCollectionViewCell ()

@property (nonatomic, strong) UITableView *CHTableView;//正文显示的tableView

@property (nonatomic, strong) NSMutableArray *CHComplexArr;//综合页显示的数组

@property (nonatomic, assign) BOOL CHSaleState;//判断综合页面,当前显示的是在售还是停售页面

@property (nonatomic, strong) NSMutableArray *CHPriceArr;//降价页面显示的数组

@property (nonatomic, strong) NSMutableArray *CHConfigArrl;//配置页面显示的数组

@property (nonatomic, strong) NSMutableArray *CHPictureArr;//图片页面显示数组

@property (nonatomic, strong) NSMutableArray *CHInfoArr;//资讯页面显示数组

@property (nonatomic, strong) UIView *firstView;//综合页tableView的头视图

@property (nonatomic, strong) UIView *secondView;//降价页面的头视图

@property (nonatomic, strong) UIView *threeView;//配置页面

@property (nonatomic, strong) UIView *fourView;//图片页面

@property (nonatomic, strong) NSIndexPath *CHComplexCurrentIndexPath;//保存当前综合页面的indexPath

@property (nonatomic, strong) NSMutableArray *CHComplexIndexArr;//保存综合页面点击去对比按钮的下标,避免重用池

@property (nonatomic, strong) NSMutableArray *CHCarArr;

@property (nonatomic, strong) MBProgressHUD *CHHud;

@end

@implementation CHCraInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.CHTableView = [[UITableView alloc] init];
        self.CHTableView.delegate = self;
        self.CHTableView.dataSource = self;
        [self.contentView addSubview:_CHTableView];
        
        self.CHSaleState = YES;
        
        self.CHComplexIndexArr = @[].mutableCopy;
        NSMutableArray *saveCarId = [[NSUserDefaults standardUserDefaults] objectForKey:@"ClickCarIds"];
        [self.CHComplexIndexArr addObjectsFromArray:saveCarId];
        
        NSMutableArray *saveArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"ClickCarId"];
        self.CHCarArr = @[].mutableCopy;
        [self.CHCarArr addObjectsFromArray:saveArr];
    }

    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    [self.CHTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self.contentView);
    }];
}

//请求网络数据并刷新tableView
- (void)loadData{

    self.CHHud = [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
    self.CHHud.labelText = @"数据正在加载...";
    [CHAFNetWorkTool getUrl:self.CHUrl body:nil result:DWJSON headerFile:nil sucess:^(id result) {
        
        //根据当前的indexPath的row来判断是那个页面,从而选择用哪个model数组来接受
        
        if (self.CHIndexPath.row == 0) {//综合页面
            
            self.CHComplexArr = @[].mutableCopy;
            CHCarInfoComplexModel *model = [[CHCarInfoComplexModel alloc] init];
            if ([result isKindOfClass:[NSDictionary class]]) {
                
                [model setValuesForKeysWithDictionary:result];
                [self.CHComplexArr addObject:model];
            }
            
        }else if (self.CHIndexPath.row == 1){//降价页面
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                
                self.CHPriceArr = [CHCarInfoPriceModel baseModelByArr:[result objectForKey:@"discountList"]];
            }
            
        
        }else if (self.CHIndexPath.row == 2){//配置页面
        
            @try {
                
                self.CHConfigArrl = @[].mutableCopy;
                CHCarInfoConfigModel *model = [[CHCarInfoConfigModel alloc] init];
                [model setValuesForKeysWithDictionary:result];
                [self.CHConfigArrl addObject:model];
            }
            @catch (NSException *exception) {
                
                NSLog(@"哈哈,我捕获异常了");
            }
            @finally {
                
                
            }
            
            
        }else if (self.CHIndexPath.row == 3){//图片页面
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                
                self.CHPictureArr = [CHCarInfoPictureModel baseModelByArr:[result objectForKey:@"categoryList"]];
            }
            
            
        }else if (self.CHIndexPath.row == 4){//资讯数组
        
            self.CHInfoArr = [CHHomePageModel baseModelByArr:result];
        
        }
        
        [self.CHHud setHidden:YES];
        [self.CHTableView reloadData];
        [self createTableHeaderView];
        
    } failure:^(NSError *error) {
        
        [self.CHHud setHidden:YES];
        NSLog(@"数据加载失败");
    }];
}

//重写方法用来加载(刷新)数据

- (void)setCHIndexPath:(NSIndexPath *)CHIndexPath{

    if (_CHIndexPath != CHIndexPath) {
        
        _CHIndexPath = CHIndexPath;
        
        [self loadData];
        
    }
    
}

//根据当前的indexPath 创建tableView的头视图

- (void)createTableHeaderView{

    if (self.CHIndexPath.row == 0) {//综合
        
        if (self.CHComplexArr.count > 0) {
            
            CHCarInfoComplexModel *model = self.CHComplexArr[0];
            self.firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 280)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 200)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
            [_firstView addSubview:imageView];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            [titleLabel setText:model.seriesName];
            [titleLabel setTextAlignment:NSTextAlignmentLeft];
            [titleLabel setFont:[UIFont systemFontOfSize:15]];
            [_firstView addSubview:titleLabel];
            [titleLabel setFrame:CGRectMake(10, 200, self.contentView.bounds.size.width, 40)];
            
            UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 240, self.contentView.bounds.size.width, 0.5)];
            [bottomLine setBackgroundColor:[UIColor lightGrayColor]];
            [self.firstView addSubview:bottomLine];
            
            UILabel *priceLabel = [[UILabel alloc] init];
            [self.firstView addSubview:priceLabel];
            [priceLabel setFrame:CGRectMake(10, 240, self.contentView.bounds.size.width, 40)];
            NSString *str1 = nil;
            if (model.price == nil) {
                
                str1 = @"暂无数据";
                
            }else{
                
                str1 = model.price;
            }
            NSString *str = [NSString stringWithFormat:@"厂商指导价:<font color=""red"">(%@)</font>",str1];
            priceLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            [priceLabel setFont:[UIFont systemFontOfSize:15]];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 279.5, self.contentView.bounds.size.width, 0.5)];
            [line setBackgroundColor:[UIColor lightGrayColor]];
            [self.firstView addSubview:line];
            
            self.CHTableView.tableHeaderView = _firstView;
        }
        
    }else{//资讯,降价,图片
    
        self.CHTableView.tableHeaderView = [UIView new];
    }

}


#pragma mark - UITableview的协议方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.CHIndexPath.row == 0) {//综合页面
        
        if (self.CHComplexArr.count > 0) {
            
            CHCarInfoComplexModel *model = self.CHComplexArr[0];
            if (self.CHSaleState) {//在售
                
                return model.saleSubSeries.count;
                
            }else{
            
                return model.saleStopSubSeries.count;
            }
        }
    }else if (self.CHIndexPath.row == 1){//降价页面
    
        if (self.CHPriceArr.count > 0) {
            
            return 1;
        }
    }else if (self.CHIndexPath.row == 2){//配置页面
        
        if (self.CHConfigArrl.count > 0) {
            
            CHCarInfoConfigModel *model = self.CHConfigArrl[0];
            return model.config.count;
        }
    
    }else if (self.CHIndexPath.row == 3){//图片页面
    
        if (self.CHPictureArr.count > 0) {
            
            return 1;
        }
        return 0;
    
    }else if (self.CHIndexPath.row == 4){//资讯页面
    
        if (self.CHInfoArr.count > 0) {
            
            return 1;
        }
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (self.CHIndexPath.row == 0 || self.CHIndexPath.row == 2) {//综合页面,配置页面
        
        return @" ";
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.CHIndexPath.row == 0) {//综合页面
        
        if (self.CHComplexArr.count > 0) {
            
            CHCarInfoComplexModel *model = self.CHComplexArr[0];
            
            UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 40)];
            [sectionView setBackgroundColor:[UIColor lightGrayColor]];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.text = [model.saleSubSeries[section] objectForKey:@"engine"];
            [titleLabel setFont:[UIFont systemFontOfSize:15]];
            [sectionView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.equalTo(sectionView.mas_left).offset(10);
                make.right.top.equalTo(sectionView);
                make.bottom.equalTo(sectionView.mas_bottom).offset(-1);
                
            }];
            
            UIView *bottomLine = [[UIView alloc] init];
            [bottomLine setBackgroundColor:[UIColor lightGrayColor]];
            [sectionView addSubview:bottomLine];
            [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.equalTo(sectionView);
                make.bottom.equalTo(sectionView.mas_bottom).offset(-0.5);
                make.height.mas_equalTo(0.5);
            }];
            
            return sectionView;
        }
    }else if (self.CHIndexPath.row == 2){//配置页面
    
        if (self.CHConfigArrl.count > 0) {
            
            CHCarInfoConfigModel *model = self.CHConfigArrl[0];
            
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 20)];
            [headView setBackgroundColor:[UIColor lightGrayColor]];
            
            UILabel *leftLabel = [[UILabel alloc] init];
            [leftLabel setTextAlignment:NSTextAlignmentLeft];
            [leftLabel setFont:[UIFont systemFontOfSize:13.5]];
            leftLabel.text = [model.config[section] objectForKey:@"typename"];
            [headView addSubview:leftLabel];
            [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(headView.mas_left).offset(8);
                make.top.bottom.equalTo(headView);
                make.width.mas_equalTo(100);
            }];
            
            UILabel *rightLabel = [[UILabel alloc] init];
            [rightLabel setTextAlignment:NSTextAlignmentRight];
            [rightLabel setFont:[UIFont systemFontOfSize:14]];
            [rightLabel setText:@"● 标配 ○ 选配 - 无 △ 待查"];
            [headView addSubview:rightLabel];
            [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(headView.mas_right).offset(-5);
                make.top.bottom.equalTo(headView);
                make.width.mas_equalTo(250);
            }];
            
            
            return headView;
        }
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.CHIndexPath.row == 0) {
        
        return 40;
        
    }else if (self.CHIndexPath.row == 1) {
        
        return 0;
        
    }else if (self.CHIndexPath.row == 2){
        
        return 20;
        
    }else if (self.CHIndexPath.row == 3){
        
        return 0;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    if (self.CHIndexPath.row == 0) {// 综合页面
        
        if (self.CHComplexArr.count > 0) {
            
            CHCarInfoComplexModel *model = self.CHComplexArr[0];
            
            if (self.CHSaleState) {//在售
                
                return [[model.saleSubSeries[section] objectForKey:@"cars"] count];
                
            }else{
                
                return [[[self.CHComplexArr[0] objectForKey:@"saleStopSubSeries"][section] objectForKey:@"cars"] count];
            }
        }
    }else if (self.CHIndexPath.row == 1){//降价页面
    
        if (self.CHPriceArr.count > 0) {
            
            return self.CHPriceArr.count;
        }
    
    }else if (self.CHIndexPath.row == 2){//配置页面
    
        if (self.CHConfigArrl.count > 0) {
            
            CHCarInfoConfigModel *model = self.CHConfigArrl[0];
            return [[model.config[section] objectForKey:@"result"] count];
        }
    }else if (self.CHIndexPath.row == 3){//图片页面
    
        if (self.CHPictureArr.count > 0) {
            
            return 1;
        }
        return 0;
        
    }else if (self.CHIndexPath.row == 4){//资讯页面
    
        if (self.CHInfoArr.count > 0) {
            
            return self.CHInfoArr.count;
        }
        
        return 0;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.CHIndexPath.row == 0) {//综合页面
        
        if (self.CHComplexArr.count > 0) {
            
            CHCarInfoComplexModel *model = self.CHComplexArr[0];
            
            static NSString *requse = @"COMPLEX";
            CHCarInfoComplexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (!cell) {
                
                cell = [[CHCarInfoComplexTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
            }
            
            NSMutableArray *saleStateArr = @[].mutableCopy;
            
            if (self.CHSaleState) {//在售
            
                saleStateArr = model.saleSubSeries;
                
            }else{
            
                saleStateArr = model.saleStopSubSeries;
            }
            
            //标题
            cell.CHTitleLabel.text = [NSString stringWithFormat:@"%@ %@",[[saleStateArr[indexPath.section] objectForKey:@"cars"][indexPath.row] objectForKey:@"subSeriesName"],[[model.saleSubSeries[indexPath.section] objectForKey:@"cars"][indexPath.row] objectForKey:@"carName"]];
            
            //驱动
            cell.CHDriverLabel.text = [NSString stringWithFormat:@"%@ %@ %@",[[saleStateArr[indexPath.section] objectForKey:@"cars"][indexPath.row] objectForKey:@"driver"],[[model.saleSubSeries[indexPath.section] objectForKey:@"cars"][indexPath.row] objectForKey:@"engine"],[[model.saleSubSeries[indexPath.section] objectForKey:@"cars"][indexPath.row] objectForKey:@"transmission"]];
            
            //报价
            NSString *priceStr = [NSString stringWithFormat:@"<font color=""red"">本地最低价: %@</font> (指导价: %@)",[[saleStateArr[indexPath.section] objectForKey:@"cars"][indexPath.row] objectForKey:@"lowestPrice"],[[model.saleSubSeries[indexPath.section] objectForKey:@"cars"][indexPath.row] objectForKey:@"guidePrice"]];
            cell.CHGuidePriceLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[priceStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            [cell.CHGuidePriceLabel setFont:[UIFont systemFontOfSize:14]];
            
            cell.CHIndexPath = indexPath;//记录当前的indexPath
            
            //保存当前indexPath的cell的数据
            cell.CHCarInfoDic = [saleStateArr[indexPath.section] objectForKey:@"cars"][indexPath.row];
            
            //通过block回调的方式将点击的indexPath保存在数组里面
            CarInfoBlock block = ^(NSIndexPath *indexPath){
            
                //将当前点击对比的车的CarId保存在数组中
                [self.CHComplexIndexArr addObject:[[model.saleSubSeries[indexPath.section] objectForKey:@"cars"][indexPath.row] objectForKey:@"carId"]];
            [[NSUserDefaults standardUserDefaults] setValue:self.CHComplexIndexArr forKey:@"ClickCarIds"];
                
            [self.CHCarArr addObject:cell.CHCarInfoDic];
            [[NSUserDefaults standardUserDefaults] setValue:self.CHCarArr forKey:@"ClickCarId"];
            
            };
            
            cell.complexBlock = block;
            CGPoint point = CGPointMake(cell.contentView.center.x, cell.contentView.bounds.origin.y + 130);
            cell.CHCurrentLocation = point;
            
            //判断当前的对比按钮是否被点击
            
            if (!([self.CHComplexIndexArr indexOfObject:[[saleStateArr[indexPath.section] objectForKey:@"cars"][indexPath.row] objectForKey:@"carId"]] == NSNotFound)) {
                
                [cell.CHComparedButton setAlpha:0.5];
                [cell.CHComparedButton setUserInteractionEnabled:NO];
                [cell.CHComparedButton setTitle:@"已对比" forState:UIControlStateNormal];
            }else{
                
                [cell.CHComparedButton setAlpha:1];
                [cell.CHComparedButton setUserInteractionEnabled:YES];
                [cell.CHComparedButton setTitle:@"+对比" forState:UIControlStateNormal];
            }
            
            return cell;

        }
    }else if (self.CHIndexPath.row == 1){//降价页面
    
        if (self.CHPriceArr.count > 0) {
            
            static NSString *requse = @"PRICE";
            
            CHCarInfoPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
            
            if (!cell) {
                
                cell = [[CHCarInfoPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
            }
            
            CHCarInfoPriceModel *model = self.CHPriceArr[indexPath.row];
            
            //图片
            [cell.CHImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
            //标题
            cell.CHTitleLabel.text = model.carName;
            
            //直降价格
            NSString *str = [NSString stringWithFormat:@"<font color=""red"">直降 %@</font>",model.discount];
            cell.CHDiscountLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            [cell.CHDiscountLabel setFont:[UIFont systemFontOfSize:13.5]];
            
            //现价
            cell.CHCurrentPriceLabel.text = [NSString stringWithFormat:@"现价 %@",model.currentPrice];
            
            //有无现车
            cell.CHTagLabel.text = model.tag;
            
            //剩余天数
            NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
            long long int date = (long long int)time;
            NSInteger dates =  (([model.remain longLongValue]  - date) / 60 / 60/ 24.0 + 0.5);
            NSString *remainDate = [NSString stringWithFormat:@"剩余<font color=""red"">%ld</font>天",dates];
            cell.CHRemainLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[remainDate dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            [cell.CHRemainLabel setFont:[UIFont systemFontOfSize:13.5]];
            
            return cell;
        }
    }else if (self.CHIndexPath.row == 2){//配置页面
    
        if (self.CHConfigArrl.count > 0) {
            
            static NSString *requse = @"CONFIG";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
            
            if (!cell) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
                [cell.textLabel setFont:[UIFont systemFontOfSize:13.5]];
                [cell.detailTextLabel setTextColor:[UIColor blueColor]];
                [cell.detailTextLabel setFont:[UIFont systemFontOfSize:13.5]];
            }
            
            CHCarInfoConfigModel *model = self.CHConfigArrl[0];
            
            //参数名
            cell.textLabel.text = [[model.config[indexPath.section] objectForKey:@"result"][indexPath.row] objectForKey:@"langname"];
            
            //参数值
            cell.detailTextLabel.text = [[model.config[indexPath.section] objectForKey:@"result"][indexPath.row] objectForKey:@"value"];
            
            
            return cell;
        }
        
    }else if (self.CHIndexPath.row == 3){//图片页面
    
        if (self.CHPictureArr.count > 0) {
            
            static NSString *requse = @"PICTURE";
            CHPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
            
            if (!cell) {
                
                cell = [[CHPictureTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
            }
            
            cell.CHPicArr = self.CHPictureArr;
            
            return cell;

        }
    }else if (self.CHIndexPath.row == 4){//资讯页面
    
        static NSString *requse = @"INFO";
        
        CHHomePageTypeOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
        
        if (!cell) {
            
            cell = [[CHHomePageTypeOneTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
        }
        
        CHHomePageModel *model = self.CHInfoArr[indexPath.row];
        
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
        
        //小图标
        cell.CHMessageIcon.image = [UIImage imageNamed:@"baitian_pinglun_old"];
        
        //评论数
        cell.CHMessageLabel.text = [model.commentCount stringValue];
        
        //类别
        cell.CHNewsLabel.text = model.newsCategory;
        
        return cell;
    }
    
    static NSString *requse = @"OTHER";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    if (self.CHIndexPath.row == 0) {//综合页面
//        
//        
//    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.CHIndexPath.row == 0) {
        
        return 130;
        
    }else if (self.CHIndexPath.row == 2){
    
        return 40;
        
    }else if (self.CHIndexPath.row == 3){
    
        return self.contentView.bounds.size.height;
    }
    
    return 100;
}

@end
