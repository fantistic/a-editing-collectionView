//
//  CHHomePageComplexViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageComplexViewController.h"

@interface CHHomePageComplexViewController ()

@property (nonatomic, strong) UITableView *CHComplexTableView;

@property (nonatomic, strong) NSMutableArray *CHComplexArr;

@property (nonatomic, strong) MBProgressHUD *CHhud;

@end

@implementation CHHomePageComplexViewController


- (void)loaComPlexData{

    [CHAFNetWorkTool getUrl:self.CHComPlexUrl body:nil result:DWJSON headerFile:nil sucess:^(id result) {
        
        [self.CHhud setHidden:YES];
        self.CHComplexArr = @[].mutableCopy;
        
        CHHomePageComplexModel *model = [[CHHomePageComplexModel alloc] init];
        
        [model setValuesForKeysWithDictionary:result];
        
        [self.CHComplexArr addObject:model];
        
        [self.CHComplexTableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        [self.CHhud setHidden:YES];
        NSLog(@"数据请求失败");
    }];
}

- (void)setCHComPlexUrl:(NSString *)CHComPlexUrl{

    if (_CHComPlexUrl != CHComPlexUrl) {
        
        _CHComPlexUrl = CHComPlexUrl;
    }
    [self loaComPlexData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor redColor]];
    
    self.CHComplexTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.CHComplexTableView setDelegate:self];
    [self.CHComplexTableView setDataSource:self];
    [self.view addSubview:_CHComplexTableView];
    [self.CHComplexTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    self.CHhud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.CHhud.labelText = @"数据正在加载...";
    [self loaComPlexData];
}

#pragma mark - UItableview的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (self.CHComplexArr.count > 0) {
        
        return 4;
        
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.CHComplexArr.count > 0) {
        
        CHHomePageComplexModel *model = self.CHComplexArr[0];
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 1;
                break;
            case 2:
                
                if (model.news == nil) {
                    
                    return 1;
                    
                }else{
                    
                    return [[model.news objectForKey:@"newsList"] count];
                }
                break;
            case 3:
                
                if (model.post == nil) {
                    
                    return 1;
                }else{
                    
                    return [[model.post objectForKey:@"postList"] count];
                }
                break;
            default:
                break;
        }
    }
    
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (self.CHComplexArr.count > 0) {
        
        switch (section) {
            case 0:
                return @"推荐";
                break;
            case 1:
                return [NSString stringWithFormat:@"%@ 图片",self.CHComplexName];
                break;
            case 2:
                
                return [NSString stringWithFormat:@"%@ 资讯文章",self.CHComplexName];
                break;
            case 3:
                return [NSString stringWithFormat:@"%@ 论坛帖子",self.CHComplexName];
                break;
            default:
                break;
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    UIView *headLine = [[UIView alloc] init];
    [headLine setBackgroundColor:[UIColor grayColor]];
    UILabel *label = [[UILabel alloc] init];
    UIView *bootomLine = [[UIView alloc] init];
    [bootomLine setBackgroundColor:[UIColor grayColor]];
    
    [headView addSubview:headLine];
    [headLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.left.equalTo(headView);
        make.top.equalTo(headView.mas_top).offset(0.5);
        make.height.mas_equalTo(0.5);
    }];
    [headView addSubview:bootomLine];
    [bootomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.left.equalTo(headView);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(headView.mas_bottom).offset(-0.5);
    }];
    
    [headView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headView.mas_left).offset(10);
        make.right.equalTo(headView.mas_right);
        make.top.equalTo(headLine.mas_bottom);
        make.bottom.equalTo(bootomLine.mas_top);
    }];
    
    NSString *str = nil;
    if (section == 0) {
        
        str = @"<font color=""red"">推荐</font>";
    }else if(section == 1){
        
        str = [NSString stringWithFormat:@"<font color=""red"">%@</font> 图片",self.CHComplexName];
    }else if (section == 2){
    
        str = [NSString stringWithFormat:@"<font color=""red"">%@</font> 资讯文章",self.CHComplexName];
    }else if (section == 3){
        
        str = [NSString stringWithFormat:@"<font color=""red"">%@</font> 论坛帖子",self.CHComplexName];
    }
    label.attributedText = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [label setFont:[UIFont systemFontOfSize:16]];
    return headView;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{

    if (section == 3) {
        
        return nil;
    }
    return @" ";
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    [footerView setBackgroundColor:[UIColor grayColor]];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 3) {
        
        return 0;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (self.CHComplexArr.count > 0) {
        
        if (indexPath.section == 0) {
            
            return 80;
        }else if (indexPath.section == 1){
            
            return 100;
        }else if (indexPath.section == 2){
            
            return 60;
        }else if (indexPath.section == 3){
            
            return 60;
        }

    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.CHComplexArr.count > 0) {
        
        CHHomePageComplexModel *model = self.CHComplexArr[0];
        if (indexPath.section == 0) {
        
            static NSString *requse = @"PRICEREQUSE";
            CHQuotedPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
            if (!cell) {
                
                cell = [[CHQuotedPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
            }
            
            [cell.CHleftImageView sd_setImageWithURL:[NSURL URLWithString:[model.seriesList[0] objectForKey:@"seriesImage"]] placeholderImage:[UIImage imageNamed:@"u=798229201,2772024962&fm=21&gp=0"]];
            
            NSString *str = nil;
            if ([model.seriesList[0] objectForKey:@"guidePrice"] == nil) {
                
               str = [NSString stringWithFormat:@"指导价: 暂无数据"];
                
            }else{
                
                str = [NSString stringWithFormat:@"指导价: %@",[model.seriesList[0] objectForKey:@"guidePrice"]];
            }
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:str];
            
            [attString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, str.length - 5)];
            cell.CHPriceLabel.attributedText = attString;
            
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:[[model.seriesList[0] objectForKey:@"seriesName"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            cell.CHBrandLabel.attributedText = attStr;
            [cell.CHBrandLabel setFont:[UIFont systemFontOfSize:17]];
            return cell;
        }else if (indexPath.section == 1){
        
            static NSString *requse = @"PICTUREREQUSE";
            CHComplexPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
            if (!cell) {
                
                cell = [[CHComplexPictureTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
                
            }
            [cell.CHLeftImageview sd_setImageWithURL:[[model.seriesList[0] objectForKey:@"imageList"][0] objectForKey:@"imageUrl"] placeholderImage:[UIImage imageNamed:@"u=798229201,2772024962&fm=21&gp=0"]];
            [cell.CHMediuImageViw sd_setImageWithURL:[[model.seriesList[0] objectForKey:@"imageList"][1] objectForKey:@"imageUrl"] placeholderImage:[UIImage imageNamed:@"u=798229201,2772024962&fm=21&gp=0"]];
            [cell.ChRightImageView sd_setImageWithURL:[[model.seriesList[0] objectForKey:@"imageList"][2] objectForKey:@"imageUrl"] placeholderImage:[UIImage imageNamed:@"u=798229201,2772024962&fm=21&gp=0"]];
            return cell;
        }else if (indexPath.section == 2){
        
            static NSString *requse = @"ARTICLEREQUSE";
            CHComplexArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
            if (!cell) {
                
                cell = [[CHComplexArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
            }
            if (model.news == nil) {
                
                cell.CHTitleLabel.text = @"暂无数据";
                
            }else{
            
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:[[[model.news objectForKey:@"newsList"][indexPath.row] objectForKey:@"newsTitle"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                cell.CHTitleLabel.attributedText = attStr;
                [cell.CHTitleLabel setFont:[UIFont systemFontOfSize:15]];
                
                NSInteger differ = [[[model.news objectForKey:@"newsList"][indexPath.row] objectForKey:@"newsCreateTime"] integerValue];
                NSDate *times =[NSDate dateWithTimeIntervalSince1970:differ + 28800];
                NSString *str1 = [NSString stringWithFormat:@"%@",times];
                NSString *newStr = [str1 substringToIndex:10];
                cell.CHTimeLabel.text = [NSString stringWithFormat:@"%@",newStr];
                
                [cell.CHTimeLabel setFont:[UIFont systemFontOfSize:13]];
                cell.CHCategoryLabel.text = [[model.news objectForKey:@"newsList"][indexPath.row] objectForKey:@"newsCategory"];
                [cell.CHCategoryLabel setFont:[UIFont systemFontOfSize:13]];
            }
            
            return cell;
                                     
        }else if (indexPath.section == 3){
        
            static NSString *requse = @"POSTSREQUSE";
            CHComplexPostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
            if (!cell) {
                
                cell = [[CHComplexPostsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
            }
            //标题
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:[[[model.post objectForKey:@"postList"][indexPath.row] objectForKey:@"postTitle"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            cell.CHTitleLabel.attributedText = attStr;
            [cell.CHTitleLabel setFont:[UIFont systemFontOfSize:15]];
            [cell.CHTitleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
            //时间
            NSInteger differ = [[[model.post objectForKey:@"postList"][indexPath.row] objectForKey:@"postCreateTime"] integerValue];
            NSDate *times =[NSDate dateWithTimeIntervalSince1970:differ + 28800];
            NSString *str1 = [NSString stringWithFormat:@"%@",times];
            NSString *newStr = [str1 substringToIndex:10];
            cell.CHTimeLabel.text = [NSString stringWithFormat:@"%@",newStr];
            [cell.CHTimeLabel setFont:[UIFont systemFontOfSize:13]];
            
            //作者
            cell.CHAuthorLabel.text = [[model.post objectForKey:@"postList"][indexPath.row] objectForKey:@"author"];
            [cell.CHAuthorLabel setFont:[UIFont systemFontOfSize:13]];
            
            //评论数字
            cell.CHReplyNumLabel.text = [[[model.post objectForKey:@"postList"][indexPath.row] objectForKey:@"replyNum"] stringValue];
            [cell.CHReplyNumLabel setFont:[UIFont systemFontOfSize:13]];
            
            //图片
            cell.CHImageView.image = [UIImage imageNamed:@"dianji_black"];
            
            return cell;
        }
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.CHComplexArr.count > 0) {
        
        CHHomePageComplexModel *model = self.CHComplexArr[0];
        
        if (indexPath.section == 0) {//跳转到车的详情页面
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[model.seriesList[0] objectForKey:@"seriesId"],@"seriesId",[model.seriesList[0] objectForKey:@"seriesName"],@"seriesName",[model.seriesList[0] objectForKey:@"price"],@"seriesPrice",[model.seriesList[0] objectForKey:@"seriesImage"],@"seriesIcon", nil];
            CHCarInformationViewController *carInfoControl = [[CHCarInformationViewController alloc] init];
            [carInfoControl setHidesBottomBarWhenPushed:YES];
            carInfoControl.CHSeriesId = [[model.seriesList[0] objectForKey:@"seriesId"] stringValue];
            carInfoControl.CHFCDic = (NSMutableDictionary *)dic;
            [self.navigationController pushViewController:carInfoControl animated:YES];
        }
        
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
