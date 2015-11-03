//
//  CHCarInfoCompareTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/24.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHCarInfoCompareTableViewCell.h"

@interface CHCarInfoCompareTableViewCell ()

@property (nonatomic, strong) UICollectionView *CHCollectionView;

@property (nonatomic, strong) UIView *CHRightLine;

@property (nonatomic, strong) UIView *CHBottomLine;

@end

@implementation CHCarInfoCompareTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.CHParametersLabel = [[UILabel alloc] init];
        [self.CHParametersLabel setNumberOfLines:0];
        [self.CHParametersLabel setFont:[UIFont systemFontOfSize:15]];
        [self.CHParametersLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_CHParametersLabel];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(140, 50)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setMinimumInteritemSpacing:0];
        [flowLayout setMinimumLineSpacing:0];
        
        self.CHCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.CHCollectionView.delegate = self;
        self.CHCollectionView.dataSource = self;
        [self.CHCollectionView registerClass:[CHCArCompareInfoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.CHCollectionView setBackgroundColor:[UIColor whiteColor]];
        [self.CHCollectionView setShowsHorizontalScrollIndicator:NO];
        [self.CHCollectionView setShowsVerticalScrollIndicator:NO];
        self.CHCollectionView.bounces = NO;
        [self.contentView addSubview:_CHCollectionView];
        
        //保存所有的collectionView
        [[CHSaveCarInfo defalutSaveCarInfo] addObject:_CHCollectionView];
        
        //右面线条
        self.CHRightLine = [[UIView alloc] init];
        [self.CHRightLine setBackgroundColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_CHRightLine];
        
        //底部下滑线
        self.CHBottomLine = [[UIView alloc] init];
        [self.CHBottomLine setBackgroundColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_CHBottomLine];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentOffSet:) name:@"ChangeContentOffSet" object:nil];
        
    }
    
    return self;
    
}

- (void)setCHCarInfoArr:(NSMutableArray *)CHCarInfoArr{

    if (_CHCarInfoArr != CHCarInfoArr) {
        
        _CHCarInfoArr = CHCarInfoArr;
    }
    
    [self.CHCollectionView reloadData];
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //参数label
    [self.CHParametersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.2);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    //右面的line
    [self.CHRightLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.CHParametersLabel.mas_right).offset(-0.5);
        make.height.equalTo(self.contentView.mas_height);
        make.width.mas_equalTo(0.5);
        
    }];
    
    //collectionView
    [self.CHCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.CHParametersLabel.mas_right);
        make.height.equalTo(self.CHParametersLabel.mas_height);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.8);
    }];
    
    //底部下滑线
    [self.CHBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
        
    }];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.CHCarInfoArr.count > 0) {
    
        return self.CHCarInfoArr.count;
    }
    
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(self.CHCollectionView.bounds.size.width / 2, self.contentView.bounds.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.CHCarInfoArr.count > 0) {
    
        CHCArCompareInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        CHCarCompareInfoModel *model = self.CHCarInfoArr[indexPath.section];
        
        cell.CHLabel.text = [[model.config[self.CHIndexPath.section] objectForKey:@"result"][self.CHIndexPath.row] objectForKey:@"value"];
        
        
        return cell;
    }
    
    return nil;
}

//同时改变所有的collectionView的偏移量
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _CHCollectionView) {
        
        for (UICollectionView *view in [CHSaveCarInfo defalutSaveCarInfo]) {
            
            [view setContentOffset:scrollView.contentOffset];
        }
        
        self.ChContentOffSet(scrollView.contentOffset);
    }
    
}

//通知中心触发的方法,改变所有collectionView的偏移量
- (void)changeContentOffSet:(NSNotification *)sender{

    NSValue *value = [sender.object objectAtIndex:0];
    CGPoint point = [value CGPointValue];
    for (UICollectionView *view in [CHSaveCarInfo defalutSaveCarInfo]) {
        
        [view setContentOffset:point];
    }
    
}


@end
