//
//  ServiceOnlineCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/30.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "ServiceOnlineCell.h"
#import "ServiceOnlineCollectionViewCell.h"

#define MARGIN 15
#define ITEM_W (SCREEN_WIDTH - 2 * MARGIN - 2 * 5) / 3.0
#define ITEM_H ITEM_W + 20
@interface ServiceOnlineCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation ServiceOnlineCell

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

    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ServiceOnlineCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ServiceOnlineCollectionViewCell class])];
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _collectionView.showsHorizontalScrollIndicator = false;
    _collectionView.delegate = self;
    [self.contentView addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ServiceOnlineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ServiceOnlineCollectionViewCell class]) forIndexPath:indexPath];
    if (_dataArray.count != 0) {
        [cell setCellWithDict:_dataArray[indexPath.item] indexPath:indexPath];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
