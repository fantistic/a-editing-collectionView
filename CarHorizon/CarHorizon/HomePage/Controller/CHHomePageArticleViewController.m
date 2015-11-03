//
//  CHHomePageArticleViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageArticleViewController.h"

@interface CHHomePageArticleViewController ()

@property (nonatomic, strong) UITableView *CHArticleTableView;

@property (nonatomic, strong) NSMutableArray *CHArticleModelArr;

@property (nonatomic, strong) MBProgressHUD *CHHud;

@end

@implementation CHHomePageArticleViewController

- (void)loadData{

    if (self.CHArticleUrl != nil) {
        
        [CHAFNetWorkTool getUrl:self.CHArticleUrl body:nil result:DWJSON headerFile:nil sucess:^(id result) {
            
            [self.CHHud setHidden:YES];
            self.CHArticleModelArr = [result objectForKey:@"newsList"];
            [self.CHArticleTableView reloadData];
            
        } failure:^(NSError *error) {
            
            [self.CHHud setHidden:YES];
            NSLog(@"数据加载失败");
        }];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    UIView *CHHeadLine = [[UIView alloc] init];
    [self.view addSubview:CHHeadLine];
    [CHHeadLine setBackgroundColor:[UIColor grayColor]];
    [CHHeadLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0.5);
        make.height.mas_equalTo(0.5);
    }];
    
    self.CHArticleTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.CHArticleTableView setDelegate:self];
    [self.CHArticleTableView setDataSource:self];
    [self.view addSubview:_CHArticleTableView];
    [self.CHArticleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(CHHeadLine.mas_bottom);
    }];
    
    self.CHHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.CHHud.labelText = @"数据正在加载...";
    [self loadData];
}


#pragma mark - UItableview的协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.CHArticleModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *requse = @"ArticleREQUSE";
    CHArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
    if (!cell) {
        
        cell = [[CHArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
    }
    
    //标题
    cell.CHTitleLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[[self.CHArticleModelArr[indexPath.row] objectForKey:@"newsTitle"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [cell.CHTitleLabel setFont:[UIFont systemFontOfSize:15]];
//    [cell.CHTitleLabel setAlpha:0.8];
    
    //详细信息
    cell.CHDescLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[[self.CHArticleModelArr[indexPath.row] objectForKey:@"newsDesc"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [cell.CHDescLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [cell.CHDescLabel setFont:[UIFont systemFontOfSize:14]];
    [cell.CHDescLabel setAlpha:0.8];
    
    //时间
    NSInteger differ = [[self.CHArticleModelArr[indexPath.row] objectForKey:@"newsCreateTime"] integerValue];
    NSDate *times =[NSDate dateWithTimeIntervalSince1970:differ + 28800];
    NSString *str = [NSString stringWithFormat:@"%@",times];
    NSString *newStr = [str substringToIndex:10];
    cell.CHTimeLabel.text = [NSString stringWithFormat:@"%@",newStr];
    [cell.CHTimeLabel setFont:[UIFont systemFontOfSize:13]];
    [cell.CHTimeLabel setAlpha:0.8];
    //类型
    cell.CHCategoryLabel.text = [self.CHArticleModelArr[indexPath.row] objectForKey:@"newsCategory"];
    [cell.CHCategoryLabel setAlpha:0.8];
    [cell.CHCategoryLabel setFont:[UIFont systemFontOfSize:13]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
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
