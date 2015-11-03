//
//  CHHomePageCarsViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/19.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHHomePageCarsViewController.h"

@interface CHHomePageCarsViewController ()

@property (nonatomic, strong) UITableView *CHCarsTableView;

@property (nonatomic, strong) NSMutableArray *CHCarsModelArr;

@property (nonatomic, strong) MBProgressHUD *CHHud;

@end

@implementation CHHomePageCarsViewController

- (void)loadData{

    if (self.CHCarsUrl != nil) {
        
        [CHAFNetWorkTool getUrl:self.CHCarsUrl body:nil result:DWJSON headerFile:nil sucess:^(id result) {
            
            [self.CHHud setHidden:YES];
            self.CHCarsModelArr = [result objectForKey:@"seriesList"];
            [self.CHCarsTableView reloadData];
            
        } failure:^(NSError *error) {
            
            [self.CHHud setHidden:YES];
            NSLog(@"加载失败");
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor brownColor]];
    
    self.CHCarsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.CHCarsTableView setDelegate:self];
    [self.CHCarsTableView setDataSource:self];
    [self.view addSubview:_CHCarsTableView];
    [self.CHCarsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    self.CHHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.CHHud.labelText = @"数据正在加载...";
    [self loadData];
}

#pragma mark - UItableview的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.CHCarsModelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.CHCarsModelArr.count > 0) {
        
        return [[self.CHCarsModelArr[section] objectForKey:@"carList"] count];
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (self.CHCarsModelArr.count > 0) {
        
        return @" ";
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (self.CHCarsModelArr.count > 0) {
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
#warning 颜色
        [headView setBackgroundColor:[UIColor lightGrayColor]];
        
        UIView *underCakeView = [[UIView alloc] init];
#warning 颜色
        [underCakeView setBackgroundColor:[UIColor whiteColor]];
        [headView addSubview:underCakeView];
        [underCakeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(headView.mas_top).offset(15);
            make.left.right.bottom.equalTo(headView);
        }];
        
        UIImageView *leftImageView = [[UIImageView alloc] init];
        leftImageView.layer.borderWidth = 0.3;
        leftImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        UILabel *titleLabel = [[UILabel alloc] init];
        UILabel *priceLabel = [[UILabel alloc] init];
        
        [underCakeView addSubview:leftImageView];
        [underCakeView addSubview:titleLabel];
        [underCakeView addSubview:priceLabel];
        
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(underCakeView.mas_top).offset(5);
            make.bottom.equalTo(underCakeView.mas_bottom).offset(-5);
            make.left.equalTo(underCakeView.mas_left).offset(10);
            make.width.equalTo(leftImageView.mas_height).multipliedBy(1.2);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(leftImageView.mas_top);
            make.left.equalTo(leftImageView.mas_right).offset(10);
            make.right.equalTo(headView.mas_right);
            make.height.equalTo(underCakeView.mas_height).multipliedBy(0.4);
        }];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(underCakeView.mas_bottom).offset(-8);
            make.top.equalTo(titleLabel.mas_bottom).offset(10);
            make.left.right.equalTo(titleLabel);
        }];
        
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:[self.CHCarsModelArr[section] objectForKey:@"seriesImage"]]];
        titleLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[[self.CHCarsModelArr[section] objectForKey:@"seriesName"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        NSString *str = [NSString stringWithFormat:@"指导价: <font color=""red"">%@</font>",[self.CHCarsModelArr[section] objectForKey:@"guidePrice"]];
        priceLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        [priceLabel setFont:[UIFont systemFontOfSize:14]];
        
        
        //添加下划线
        UIView *bottomLine = [[UIView alloc] init];
        [headView addSubview:bottomLine];
        [bottomLine setBackgroundColor:[UIColor grayColor]];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.left.equalTo(headView);
            make.bottom.equalTo(headView.mas_bottom).offset(-0.5);
            make.height.mas_equalTo(0.5);
        }];
        
        //添加一个手势
//        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureClick:)];
//        [gesture setNumberOfTapsRequired:1];
//        [headView addGestureRecognizer:gesture];
        
        
        return headView;
    }
    
    return nil;
    
}

//手势触发方法
//- (void)gestureClick:(UITapGestureRecognizer *)gesture{
//
//    UIView *view = gesture
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.CHCarsModelArr.count > 0) {
        
        static NSString *requse = @"CArsREQUSE";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
        }
        
        cell.textLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[[[self.CHCarsModelArr[indexPath.section] objectForKey:@"carList"][indexPath.row] objectForKey:@"carName"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
        
        NSString *str = [NSString stringWithFormat:@"<font color=""red"">%@</font> ",[[self.CHCarsModelArr[indexPath.section] objectForKey:@"carList"][indexPath.row] objectForKey:@"carPriceLowest"]];
        cell.detailTextLabel.attributedText = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:15]];
        
        return cell;
    }
    
    return nil;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 80;
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
