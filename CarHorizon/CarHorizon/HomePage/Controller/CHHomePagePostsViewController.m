//
//  CHHomePagePostsViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePagePostsViewController.h"

@interface CHHomePagePostsViewController ()

@property (nonatomic, strong) UITableView *CHPostsTableView;

@property (nonatomic, strong) NSMutableArray *CHPostsModelArr;

@property (nonatomic, strong) MBProgressHUD *CHHud;

@end

@implementation CHHomePagePostsViewController

- (void)loadData{

    if (self.CHPostsUrl != nil) {
        
        [CHAFNetWorkTool getUrl:self.CHPostsUrl body:nil result:DWJSON headerFile:nil sucess:^(id result) {
            
            [self.CHHud setHidden:YES];
            self.CHPostsModelArr = [result objectForKey:@"postList"];
            [self.CHPostsTableView reloadData];
            
        } failure:^(NSError *error) {
            
            [self.CHHud setHidden:YES];
            NSLog(@"数据加载失败");
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *CHHeadLine = [[UIView alloc] init];
    [self.view addSubview:CHHeadLine];
    [CHHeadLine setBackgroundColor:[UIColor grayColor]];
    [CHHeadLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0.5);
        make.height.mas_equalTo(0.5);
    }];
    
    self.CHPostsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.CHPostsTableView setDelegate:self];
    [self.CHPostsTableView setDataSource:self];
    [self.view addSubview:_CHPostsTableView];
    [self.CHPostsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(CHHeadLine.mas_bottom);
    }];
    
    self.CHHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.CHHud.labelText = @"数据正在加载";
    [self loadData];
}


#pragma mark - UItableview的协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        
    return self.CHPostsModelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *requse = @"POSTSREQUSE";
    CHPostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
    if (!cell) {
        
        cell = [[CHPostsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
    }
    //标题
    cell.CHTitleLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[[self.CHPostsModelArr[indexPath.row] objectForKey:@"postTitle"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [cell.CHTitleLabel setFont:[UIFont systemFontOfSize:15]];
    
    //详细信息
    cell.CHDescLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[[self.CHPostsModelArr[indexPath.row] objectForKey:@"postDesc"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [cell.CHDescLabel setFont:[UIFont systemFontOfSize:13.5]];
    
    NSLog(@"%@",[self.CHPostsModelArr[indexPath.row] objectForKey:@"postDesc"]);
    //时间
    NSInteger differ = [[self.CHPostsModelArr[indexPath.row] objectForKey:@"postCreateTime"] integerValue];
    NSDate *times =[NSDate dateWithTimeIntervalSince1970:differ + 28800];
    NSString *str = [NSString stringWithFormat:@"%@",times];
    NSString *newStr = [str substringToIndex:10];
    cell.CHTimeLabel.text = [NSString stringWithFormat:@"%@",newStr];
    [cell.CHTimeLabel setFont:[UIFont systemFontOfSize:12]];
    
    //作者
    cell.CHAuthorLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[[self.CHPostsModelArr[indexPath.row] objectForKey:@"author"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [cell.CHAuthorLabel setFont:[UIFont systemFontOfSize:12]];
    
    //评论次数
    cell.CHReplyNumLabel.text = [[self.CHPostsModelArr[indexPath.row] objectForKey:@"replyNum"] stringValue];
    [cell.CHReplyNumLabel setFont:[UIFont systemFontOfSize:12]];
    
    //图片
    cell.CHImageView.image = [UIImage imageNamed:@"baitian_pinglun_old"];
    
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
