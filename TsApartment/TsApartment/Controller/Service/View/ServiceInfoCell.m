//
//  ServiceInfoCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/30.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceInfoCell.h"
#import "ServiceInfoCollectionViewCell.h"
#import "ServiceInfoDetailController.h"

#define ITEM_W 300
#define ITEM_H 230

@interface ServiceInfoCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation ServiceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setCellWithArray:(NSArray *)array{
    _dataArray = [NSArray arrayWithArray:array];
    [_collectionView reloadData];
}

- (void)setupUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(ITEM_W, ITEM_H);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ITEM_H) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[ServiceInfoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ServiceInfoCollectionViewCell class])];
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _collectionView.showsHorizontalScrollIndicator = false;
    _collectionView.delegate = self;
    [self.contentView addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ServiceInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ServiceInfoCollectionViewCell class]) forIndexPath:indexPath];
    if (_dataArray.count != 0) {
        [cell setCellWithDict:_dataArray[indexPath.row] indexPath:indexPath];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
    ServiceInfoDetailController *detailVc = [[ServiceInfoDetailController alloc]init];
    detailVc.hidesBottomBarWhenPushed = true;
    detailVc.Id = [[_dataArray[indexPath.row] objectForKey:kId] integerValue];
    UIViewController *vc = [CommonTools findViewController:self];
    [vc.navigationController pushViewController:detailVc animated:true];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
