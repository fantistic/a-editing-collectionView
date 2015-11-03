//
//  CHPictureTableViewCell.m
//  CarHorizon
//
//  Created by dllo on 15/10/22.
//  Copyright © 2015年 luo. All rights reserved.
//

#import "CHPictureTableViewCell.h"

#define WIDTH [[UIScreen mainScreen] bounds].size.width

#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface CHPictureTableViewCell ()

@property (nonatomic, strong) UICollectionView *CHPicCollectionView;//显示图片的CollectionView

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation CHPictureTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setItemSize:CGSizeZero];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [_flowLayout setMinimumInteritemSpacing:5];
        [_flowLayout setMinimumLineSpacing:5];
        [_flowLayout setHeaderReferenceSize:CGSizeZero];
        
        self.CHPicCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        self.CHPicCollectionView.delegate = self;
        self.CHPicCollectionView.dataSource = self;
        [self.CHPicCollectionView setShowsHorizontalScrollIndicator:NO];
        [self.CHPicCollectionView setShowsVerticalScrollIndicator:NO];
        [self.CHPicCollectionView registerClass:[CHCarInfoPictureCollectionViewCell class] forCellWithReuseIdentifier:@"PICREQUSE"];
        
        [self.CHPicCollectionView registerClass:[CHPicCollectionHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADREQUSE"];
        
        [self.CHPicCollectionView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:_CHPicCollectionView];
    }
    
    return self;
}

//重写set方法来刷新视图
- (void)setCHPicArr:(NSMutableArray *)CHPicArr{
    
    if (_CHPicArr != CHPicArr) {
        
        _CHPicArr = CHPicArr;
    }
    
    [self.CHPicCollectionView reloadData];

}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    [self.flowLayout setItemSize:CGSizeMake((WIDTH - 26) / 3, (HEIGHT - 250) / 4)];
    
    [self.CHPicCollectionView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64)];
}


#pragma mark - CollectionView 的协议方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.CHPicArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    CHCarInfoPictureModel *model = self.CHPicArr[section];
    return model.imagesList.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    UIEdgeInsets edge = UIEdgeInsetsMake(5, 5, 5, 5);
    
    return edge;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(WIDTH, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if (kind == UICollectionElementKindSectionHeader) {
        
        CHPicCollectionHeaderCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADREQUSE" forIndexPath:indexPath];
        
        CHCarInfoPictureModel *model = self.CHPicArr[indexPath.section];
        
        cell.CHTitleLabel.text = model.imageCategory;
        
        return cell;
    }
    
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CHCarInfoPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PICREQUSE" forIndexPath:indexPath];
    
    CHCarInfoPictureModel *model = self.CHPicArr[indexPath.section];
    
    [cell.CHImageView sd_setImageWithURL:[model.imagesList[indexPath.row] objectForKey:@"imageSmall"]];
    
    return cell;

}



@end
