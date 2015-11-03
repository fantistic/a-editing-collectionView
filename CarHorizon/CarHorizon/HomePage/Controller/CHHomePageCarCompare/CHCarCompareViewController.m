//
//  CHCarCompareViewController.m
//  CarHorizon
//
//  Created by dllo on 15/10/23.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHCarCompareViewController.h"

//车辆对比信息请求网址
#define CARINFOURL @"http://mi.xcar.com.cn/interface/xcarapp/getCarParameterListById.php?carId="

@interface CHCarCompareViewController ()

@property (nonatomic, strong) UITableView *CHTableview;

@property (nonatomic, strong) NSMutableArray *CHSaveCurrentIndexArr;//保存当前点击cell的indexPath规避cell重用

@property (nonatomic, strong) UIButton *CHCompareButton;//对比按钮


@end

@implementation CHCarCompareViewController

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor redColor]];
    
    self.title = @"车型对比";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick:)];
    
    self.CHTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.CHTableview.delegate = self;
    self.CHTableview.dataSource = self;
    [self.view addSubview:_CHTableview];
    
    [self.CHTableview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.left.bottom.equalTo(self.view);
        
    }];
    
    //数组初始化
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CarInfoCompare"]) {
        
        self.CHSaveCurrentIndexArr = @[].mutableCopy;
        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"CarInfoCompare"];
        [self.CHSaveCurrentIndexArr addObjectsFromArray:arr];
        
    }else{
        
        self.CHSaveCurrentIndexArr = @[].mutableCopy;
    }
    
    self.CHCompareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.CHCompareButton setTitle:@"开始对比" forState:UIControlStateNormal];
    [self.CHCompareButton addTarget:self action:@selector(CHCompareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.CHCompareButton setBackgroundColor:[UIColor blueColor]];
    [self.CHCompareButton setAlpha:0.8];
    [self.view addSubview:_CHCompareButton];
    [self.CHCompareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(50);
    }];
}

//编辑
- (void)rightBarButtonItemClick:(UIBarButtonItem *)sender{

    static BOOL isClick = YES;
    
    
    if (isClick) {
        
        [sender setTitle:@"完成"];
        
    }else{
        
        [sender setTitle:@"编辑"];
    }
    [self.CHTableview setEditing:isClick animated:YES];
    
    isClick = !isClick;
}

//对比按钮
- (void)CHCompareButtonClick:(UIButton *)sender{

    
    CHCarCompareInfoViewController *CHCarCompareInfoControl = [[CHCarCompareInfoViewController alloc] init];
    
    NSMutableArray *arr = @[].mutableCopy;
    
    for (NSNumber *carId in self.CHSaveCurrentIndexArr) {
        
        [arr addObject:carId];
    }
    NSString *str = [arr componentsJoinedByString:@"_"];
    CHCarCompareInfoControl.CHCarCompareInfoUrl = [NSString stringWithFormat:@"%@%@",CARINFOURL,str];
    
    [self.navigationController pushViewController:CHCarCompareInfoControl animated:YES];
}

#pragma mark - UITableView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.CHCarInfoArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *requse = @"CarMessage";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:requse];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:requse];
    }
    
    if (self.CHCarInfoArr.count > 0) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@",[self.CHCarInfoArr[indexPath.row] objectForKey:@"subSeriesName"],[self.CHCarInfoArr[indexPath.row] objectForKey:@"carName"]];
        
        if ([self.CHSaveCurrentIndexArr indexOfObject:[self.CHCarInfoArr[indexPath.row] objectForKey:@"carId"]] == NSNotFound) {
            
            cell.imageView.image = [UIImage imageNamed:@"weixuan"];
            
        }else{
            
            cell.imageView.image = [UIImage imageNamed:@"xuanzhong"];
        }
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"xuanzhong"];
    [self.CHSaveCurrentIndexArr addObject:[self.CHCarInfoArr[indexPath.row] objectForKey:@"carId"]];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.CHCarInfoArr removeObjectAtIndex:indexPath.row];
        [self.CHTableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.CHSaveCurrentIndexArr removeObject:[self.CHCarInfoArr[indexPath.row] objectForKey:@"carId"]];
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
