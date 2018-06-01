//
//  CentTableViewCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/5/29.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CentTableViewCell.h"
#import "CentralizeCell.h"

#define ITEM_W 300
#define ITEM_H 260
@interface CentTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation CentTableViewCell

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

- (void)setupUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(ITEM_W, ITEM_H);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ITEM_H) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CentralizeCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CentralizeCell class])];
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _collectionView.showsHorizontalScrollIndicator = false;
    _collectionView.delegate = self;
    [self.contentView addSubview:_collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CentralizeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CentralizeCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - lazy
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
